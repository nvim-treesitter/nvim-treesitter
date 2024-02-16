local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Rest = require('fittencode.rest')
local Log = require('fittencode.log')

local M = {}

---@alias Suggestion string[]

---@type string|nil
M.api_key = nil

local URL_LOGIN = 'https://codeuser.fittentech.cn:14443/login'
local URL_GET_FT_TOKEN = 'https://codeuser.fittentech.cn:14443/get_ft_token'
local URL_GENERATE_ONE_STAGE = 'https://codeapi.fittentech.cn:13443/generate_one_stage/'

---@param api_key string|nil
---@return boolean
local function validate_api_key(api_key)
  if api_key == nil or api_key == '' then
    Log.error('API key is invalid')
    return false
  end
  return true
end

function M.validate_current_api_key()
  return validate_api_key(M.api_key)
end

---@return string, string
local function get_api_key_store_path()
  local dir = fn.stdpath('data') .. '/fittencode'
  local path = dir .. '/api_key'
  return Base.to_native(dir), Base.to_native(path)
end

---@param path string
---@param on_success function|nil
---@param on_error function|nil
local function delete_api_key_file(path, on_success, on_error)
  uv.fs_unlink(path, function(err)
    if err then
      Log.error('Failed to delete API key file; path: {}; error: {}', path, err)
      if on_error then
        on_error()
      end
    else
      Log.info('Delete API key file successful; path: {}', path)
      if on_success then
        on_success()
      end
    end
  end)
end

---@param on_success function|nil
---@param on_error function|nil
local function read_local_api_key_file(on_success, on_error)
  local _, path = get_api_key_store_path()
  Log.debug('Reading API key file; path: {}', path)
  if not Base.exists(path) then
    Log.error('API key file not found; path: {}', path)
    if on_error then
      on_error()
    end
    return
  end
  Base.read(path, function(data)
    ---@type string
    local api_key = data:gsub('\n', '')
    if validate_api_key(api_key) then
      M.api_key = api_key
      Log.info('API key loaded successful')
      if on_success then
        on_success()
      end
    else
      delete_api_key_file(path)
      if on_error then
        on_error()
      end
    end
  end)
end

---@param signal integer
---@param _ string
local function on_curl_signal_callback(signal, _)
  Log.error('curl throw; signal: {}', signal)
end

---@param api_key string
local function write_api_key(api_key)
  local dir, path = get_api_key_store_path()
  Base.write_mkdir(api_key, dir, path, function()
    Log.info('API key file saved successful; path: {}', path)
  end)
end

---@param exit_code integer
---@param output string
local function on_login_api_key_callback(exit_code, output)
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
  if validate_api_key(api_key) then
    M.api_key = api_key
    Log.i('Login successful')
    write_api_key(api_key)
  end
end

---@param token string|nil
local function login_with_token(token)
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
    cmd = 'curl',
    args = fico_args,
  }, on_login_api_key_callback, on_curl_signal_callback)
end

---@param exit_code integer
---@param output string
local function on_login_callback(exit_code, output)
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
  login_with_token(token)
end

function M.load_last_session()
  Log.info('Loading last session')
  read_local_api_key_file(function()
    Log.i('Last session loaded successful')
  end, function()
    Log.i('Last session not found or invalid, please login again')
  end)
end

---@param name string
---@param password string
function M.login(name, password)
  if name == nil or name == '' or password == nil or password == '' then
    Log.e('Invalid username or password')
    return
  end

  local _, path = get_api_key_store_path()
  if Base.exists(path) then
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
    cmd = 'curl',
    args = login_args,
  }, on_login_callback, on_curl_signal_callback)
end

function M.logout()
  local _, path = get_api_key_store_path()
  if not Base.exists(path) then
    Log.i('You are already logged out')
    return
  end
  delete_api_key_file(path, function()
    Log.i('Logout successful')
  end, function()
    Log.e('Logout failed')
  end)
end

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

---@param exit_code integer
---@param response string
---@param data RestCallbackData
local function on_completion_callback(exit_code, response, data)
  if response == nil or response == '' then
    return
  end

  local completion_data = fn.json_decode(response)
  if completion_data.generated_text == nil then
    return
  end

  local suggestion = generate_suggestion(completion_data.generated_text)

  if data.on_completion_request_success ~= nil then
    data.on_completion_request_success(data.task_id, suggestion)
  end
end

---@param data RestCallbackData
local function on_completion_delete_tempfile_callback(data)
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
local function make_completion_request_params()
  local filename = api.nvim_buf_get_name(api.nvim_get_current_buf())
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
---@param on_completion_request_success function|nil
function M.do_completion_request(task_id, on_completion_request_success)
  local encoded_params = fn.json_encode(make_completion_request_params())
  Base.write_temp_file(encoded_params, function(path)
    local server_addr = URL_GENERATE_ONE_STAGE
    local completion_args = {
      '-s',
      '-X',
      'POST',
      '-H',
      'Content-Type: application/json',
      '-d',
      '@' .. Base.to_native(path),
      server_addr .. M.api_key .. '?ide=vim&v=0.1.0',
    }
    Rest.send({
      cmd = 'curl',
      args = completion_args,
      data = {
        path = path,
        task_id = task_id,
        on_completion_request_success = on_completion_request_success,
      },
    }, on_completion_callback, on_curl_signal_callback, on_completion_delete_tempfile_callback)
  end)
end

return M
