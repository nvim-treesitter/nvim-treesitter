local fn = vim.fn
local api = vim.api
local uv = vim.uv or vim.loop

local Base = require('fittencode.base')
local Rest = require('fittencode.rest')
local Log = require('fittencode.log')
local KeyStorage = require('fittencode.key_storage')
local Config = require('fittencode.config')

local M = {}

local URL_LOGIN = 'https://codeuser.fittentech.cn:14443/login'
local URL_GET_FT_TOKEN = 'https://codeuser.fittentech.cn:14443/get_ft_token'
local URL_GENERATE_ONE_STAGE = 'https://codeapi.fittentech.cn:13443/generate_one_stage/'
local CMD = 'curl'
local KEY_STORE_PATH = Base.to_native(fn.stdpath('data') .. '/fittencode' .. '/api_key.json')

---@type KeyStorage
local key_storage = KeyStorage:new({
  path = KEY_STORE_PATH,
})

-- Current user name, used for mapping to API key
---@type string|nil
local username = nil

---@param signal integer
---@param _ string
local function on_curl_signal(signal, _)
  Log.error('curl throwed signal: {}', signal)
end

-- Callback for request_fico when HTTP request is successful
---@param response string
local function on_fico(_, response)
  if response == nil or response == '' then
    Log.e('Login failed: Server response without data')
    return
  end

  local fico_data = fn.json_decode(response)
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.e('Login failed: Server response without fico_token field; decoded response: {}', fico_data)
    return
  end

  ---@type string
  local api_key = fico_data.data.fico_token
  key_storage:set_key_by_name(username, api_key)
  Log.i('Login successful')
end

-- User token is required for getting fico token
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

-- Decode login response and get token
---@param response string
---@return string|nil
local function decode_token(response)
  if response == nil or response == '' then
    Log.e('Login failed: Server response without data')
    return
  end

  local login_data = fn.json_decode(response)
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

-- Callback for request_login when HTTP request is successful
---@param response string
local function on_login(_, response)
  local token = decode_token(response)
  if token ~= nil then
    request_fico(token)
  end
end

-- Request login with given username and password
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
  local args = {
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
    args = args,
  }, on_login, on_curl_signal)
end

-- Request logout and clear API key
function M.request_logout()
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.i('You are already logged out')
    return
  end
  key_storage:clear()
  username = nil
  Log.i('Logout successful')
end

-- Load last session from key storage and set username
function M.request_load_last_session()
  Log.info('Loading last session')
  key_storage:load(function(name)
    username = name
    Log.i('Last session for user {} loaded successful', name)
  end, function()
    Log.i('Last session not found or invalid, please login again')
  end)
end

---@alias Suggestions string[] Formated suggesion

-- Generate suggestions from generated text
---@param generated_text string
---@return Suggestions?, string?
local function generate_suggestions(generated_text)
  local generated_text = fn.substitute(generated_text, '<.endoftext.>', '', 'g') or ''
  local lines = vim.split(generated_text, '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    Log.debug('No more suggestions')
    return
  end

  Log.debug('Generated text: {}', generated_text)

  if string.len(lines[#lines]) == 0 then
    table.remove(lines, #lines)
  end

  ---@type Suggestions
  local suggestions = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '\n')
    for _, part in ipairs(parts) do
      table.insert(suggestions, part)
    end
  end
  return suggestions, generated_text
end

---@class OnGenerateOneStageData User data for GenerateOneStage request
---@field path string|nil Temporary file path for HTTP request data
---@field task_id integer Task ID
---@field on_suggestions function|nil Callback when suggestions is generated
---@field on_error function|nil Callback when request is failed

-- Callback for request_generate_one_stage when HTTP request is successful
---@param response string
---@param data OnGenerateOneStageData
local function on_generate_one_stage(_, response, data)
  if response == nil or response == '' then
    Log.error('Generate one stage failed: Server response without data')
    if data.on_error then
      data.on_error()
    end
    return
  end

  local completion_data = fn.json_decode(response)
  if completion_data.generated_text == nil then
    Log.error('Generate one stage failed: Server response without generated_text field; decoded response: {}', completion_data)
    if data.on_error then
      data.on_error()
    end
    return
  end

  local suggestions, generated_text = generate_suggestions(completion_data.generated_text)

  if data.on_suggestions then
    data.on_suggestions(data.task_id, suggestions, generated_text)
  end
end

-- Callback for request_generate_one_stage when HTTP request is done
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

---@return table|nil
local function make_generate_one_stage_params()
  local filename = api.nvim_buf_get_name(0)
  if filename == nil or filename == '' then
    filename = 'NONAME'
  end

  local row, col = Base.get_cursor()

  if not Config.internal.virtual_text.inline then
    local line = api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local len = string.len(line)
    Log.debug('Inline mode is disabled; col: {}, line: {}, length of line: {}', col, line, len)
    if col ~= len then
      Log.debug('Cursor is not at the end of the line, aborting')
      return
    end
  end

  local prefix = table.concat(api.nvim_buf_get_text(0, 0, 0, row, col, {}), '\n')
  Log.debug('Prefix: {}', prefix)
  local suffix = table.concat(api.nvim_buf_get_text(0, row, col, -1, -1, {}), '\n')
  Log.debug('Suffix: {}', suffix)
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

-- Check if the user is ready for generating one stage
function M.ready_for_generate()
  return key_storage:get_key_by_name(username) ~= nil
end

---@param task_id integer
---@param on_suggestions function|nil
---@param on_error function|nil
function M.request_generate_one_stage(task_id, on_suggestions, on_error)
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.debug('API key is nil, skip request')
    if on_error then
      on_error()
    end
    return
  end
  local params = make_generate_one_stage_params()
  Log.debug('Request generate one stage params: {}', params)
  if params == nil then
    Log.debug('Invalid params, skip request')
    if on_error then
      on_error()
    end
    return
  end
  Base.write_temp_file(fn.json_encode(params), function(_, path)
    local server = URL_GENERATE_ONE_STAGE
    local args = {
      '-s',
      '-X',
      'POST',
      '-H',
      'Content-Type: application/json',
      '-d',
      '@' .. path,
      server .. api_key .. '?ide=neovim&v=0.1.0',
    }
    Rest.send(
      {
        cmd = CMD,
        args = args,
        ---@type OnGenerateOneStageData
        data = {
          path = path,
          task_id = task_id,
          on_suggestions = on_suggestions,
          on_error = on_error,
        },
      },
      on_generate_one_stage,
      function(signal, ...)
        on_curl_signal(signal, ...)
        if on_error then
          on_error()
        end
      end,
      on_generate_one_stage_exit
    )
  end, function()
    if on_error then
      on_error()
    end
  end)
end

return M
