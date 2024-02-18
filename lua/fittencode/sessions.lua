local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Rest = require('fittencode.rest')
local Log = require('fittencode.log')
local KeyStorage = require('fittencode.key_storage')

local M = {}

local URL_LOGIN = 'https://codeuser.fittentech.cn:14443/login'
local URL_GET_FT_TOKEN = 'https://codeuser.fittentech.cn:14443/get_ft_token'
local URL_GENERATE_ONE_STAGE = 'https://codeapi.fittentech.cn:13443/generate_one_stage/'
local CMD = 'curl'
local KEY_STORE_PATH = fn.stdpath('data') .. '/fittencode' .. '/api_key.json'

---@type KeyStorage
local key_storage = KeyStorage:new({
  path = KEY_STORE_PATH,
})

---@type string
local username = nil

---@param signal integer
---@param _ string
local function on_curl_signal(signal, _)
  Log.error('curl throwed signal: {}', signal)
end

---@param output string
local function on_fico(_, output)
  if output == nil or output == '' then
    Log.e('Login failed: Server response without data')
    return
  end

  local fico_data = fn.json_decode(output)
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.e('Login failed: Server response without fico_token field; decoded response: {}', fico_data)
    return
  end

  ---@type string
  local api_key = fico_data.data.fico_token
  key_storage:set_key_by_name(username, api_key)
  Log.i('Login successful')
end

---@param token string
local function request_fico(token)
  if token == nil or token == '' then
    Log.e('Login failed: Invalid user token')
    return
  end

  local fico_url = URL_GET_FT_TOKEN
  local fico_args = {
    '-s',
    '-H',
    'Authorization: Bearer ' .. token,
    fico_url,
  }
  Rest.send({
    cmd = CMD,
    args = fico_args,
  }, on_fico, on_curl_signal)
end

---@param output string
---@return string|nil
local function decode_token(output)
  if output == nil or output == '' then
    Log.e('Login failed: Server response without data')
    return
  end

  local login_data = fn.json_decode(output)
  if login_data.code ~= 200 then
    if login_data.code == nil then
      Log.e('Login failed: Server status code: {}; response: {}', login_data.status_code, login_data)
      return
    else
      Log.e('Login failed: HTTP code: {}; response: {}', login_data.code, login_data)
    end
    return
  end

  ---@type string
  local token = login_data.data.token
  return token
end

---@param output string
local function on_login(_, output)
  local token = decode_token(output)
  if token ~= nil then
    request_fico(token)
  end
end

---@param name string
---@param password string
function M.request_login(name, password)
  if name == nil or name == '' or password == nil or password == '' then
    Log.e('Invalid username or password')
    return
  end

  username = name

  local api_key = key_storage:get_key_by_name(username)
  if api_key ~= nil then
    Log.i('You are already logged in')
    return
  end

  local login_url = URL_LOGIN
  local data = {
    username = name,
    password = password,
  }
  local encoded_data = fn.json_encode(data)
  local login_args = {
    '-s',
    '-X',
    'POST',
    '-H',
    'Content-Type: application/json',
    '-d',
    encoded_data,
    login_url,
  }
  Rest.send({
    cmd = CMD,
    args = login_args,
  }, on_login, on_curl_signal)
end

function M.request_logout()
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.i('You are already logged out')
    return
  end
  key_storage:clear()
  Log.i('Logout successful')
end

function M.request_load_last_session()
  Log.info('Loading last session')
  key_storage:load(function(name)
    username = name
    Log.i('Last session for user {} loaded successful', name)
  end, function()
    Log.info('Last session not found or invalid, please login again')
  end)
end

---@alias Suggestion string[]

---@param generated_text string
---@return Suggestion|nil
local function generate_suggestion(generated_text)
  local replaced_text = fn.substitute(generated_text, '<.endoftext.>', '', 'g')
  if not replaced_text then
    return
  end
  local lines = vim.split(replaced_text, '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    return
  end

  if string.len(lines[#lines]) == 0 then
    table.remove(lines, #lines)
  end

  ---@type Suggestion
  local suggestion = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '\n')
    for _, part in ipairs(parts) do
      table.insert(suggestion, part)
    end
  end
  return suggestion
end

---@class OnGenerateOneStageData
---@field path string|nil
---@field task_id integer
---@field on_suggestion function|nil

---@param response string
---@param data OnGenerateOneStageData
local function on_generate_one_stage(_, response, data)
  if response == nil or response == '' then
    return
  end

  local completion_data = fn.json_decode(response)
  if completion_data.generated_text == nil then
    return
  end

  local suggestion = generate_suggestion(completion_data.generated_text)

  if data.on_suggestion ~= nil then
    data.on_suggestion(data.task_id, suggestion)
  end
end

---@param data OnGenerateOneStageData
local function on_generate_one_stage_exit(data)
  local path = data.path
  if path then
    uv.fs_unlink(path, function(err)
      if err then
        Log.error('Failed to delete HTTP temporary file; path: {}; error: {}', path, err)
      end
    end)
  else
    Log.error('Failed to delete HTTP temporary file; path is nil')
  end
end

---@return table
local function make_generate_one_stage_params()
  local filename = api.nvim_buf_get_name(0)
  if filename == nil or filename == '' then
    filename = 'NONAME'
  end

  local row, col = Base.get_cursor()
  local prefix = table.concat(api.nvim_buf_get_text(0, 0, 0, row, col, {}), '\n')
  local suffix = table.concat(api.nvim_buf_get_text(0, row, col, -1, -1, {}), '\n')
  local prompt = '!FCPREFIX!' .. prefix .. '!FCSUFFIX!' .. suffix .. '!FCMIDDLE!'
  local escaped_prompt = string.gsub(prompt, '"', '\\"')
  local params = {
    inputs = escaped_prompt,
    meta_datas = {
      filename = filename,
    },
  }
  return params
end

---@param task_id integer
---@param on_suggestion function|nil
function M.request_generate_one_stage(task_id, on_suggestion)
  local api_key = key_storage:get_key_by_name(username)
  local encoded_params = fn.json_encode(make_generate_one_stage_params())
  Base.write_temp_file(encoded_params, function(path)
    local server = URL_GENERATE_ONE_STAGE
    local args = {
      '-s',
      '-X',
      'POST',
      '-H',
      'Content-Type: application/json',
      '-d',
      '@' .. Base.to_native(path),
      server .. api_key .. '?ide=vim&v=0.1.0',
    }
    Rest.send({
      cmd = CMD,
      args = args,
      ---@type OnGenerateOneStageData
      data = {
        path = path,
        task_id = task_id,
        on_suggestion = on_suggestion,
      },
    }, on_generate_one_stage, on_curl_signal, on_generate_one_stage_exit)
  end)
end

return M
