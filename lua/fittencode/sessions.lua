local api = vim.api
local fn = vim.fn
local uv = vim.uv or vim.loop

local Base = require('fittencode.base')
local Config = require('fittencode.config')
local FS = require('fittencode.fs')
local KeyStorage = require('fittencode.key_storage')
local Log = require('fittencode.log')
local PromptProviders = require('fittencode.prompt_providers')
local Rest = require('fittencode.rest')

local M = {}

local URL_LOGIN = 'https://fc.fittenlab.cn/codeuser/login'
local URL_GET_FT_TOKEN = 'https://fc.fittenlab.cn/codeuser/get_ft_token'
local URL_GENERATE_ONE_STAGE = 'https://fc.fittenlab.cn/codeapi/completion/generate_one_stage/'

local CMD = 'curl'
local CMD_TIMEOUT = 5 -- 5 seconds
local CMD_DEFAULT_ARGS = {
  '--connect-timeout',
  CMD_TIMEOUT,
  '--show-error',
  -- For debug purposes only, `-v, Make the operation more talkative`
  -- '-v',
}
local CMD_EXIT_CODE_SUCCESS = 0

local KEY_STORE_PATH = Base.to_native(fn.stdpath('data') .. '/fittencode' .. '/api_key.json')

---@type KeyStorage
local key_storage = KeyStorage:new({
  path = KEY_STORE_PATH,
})

-- Current user name, used for mapping to API key
---@type string?
local username = nil

---@param signal integer
---@param _ string
local function on_cmd_signal(signal, _)
  Log.error('CMD: {}, throwed signal: {}', CMD, signal)
end

---@param response string
---@param on_success? function
---@param on_error? function
local function on_fico(_, response, on_success, on_error)
  if response == nil or response == '' then
    Log.error('Server response without data')
    if on_error then
      on_error()
    end
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    if on_error then
      on_error()
    end
    return
  end

  local fico_data = result
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.error('Server response without fico_token field; decoded response: {}', fico_data)
    if on_error then
      on_error()
    end
    return
  end

  key_storage:set_key_by_name(username, fico_data.data.fico_token)
  if on_success then
    on_success()
  end
end

---@param token string
---@param on_success? function
---@param on_error? function
local function request_fico(token, on_success, on_error)
  local fico_url = URL_GET_FT_TOKEN
  local args = {
    '-s',
    '-H',
    'Authorization: Bearer ' .. token,
    fico_url,
  }
  vim.list_extend(args, CMD_DEFAULT_ARGS)
  Rest.send({
    cmd = CMD,
    args = args,
  }, function(_, response)
    on_fico(nil, response, function()
      if on_success then
        on_success()
      end
    end, function()
      if on_error then
        on_error()
      end
    end)
  end, function(signal, ...)
    on_cmd_signal(signal, ...)
    if on_error then
      on_error()
    end
  end)
end

---@param response string
---@return string|nil
local function decode_token(response)
  if response == nil or response == '' then
    Log.error('Server response without data')
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON: {}; error: {}', response, result)
    return
  end

  local login_data = result
  if login_data.code ~= 200 then
    if login_data.code == nil then
      Log.error('Server status code: {}; response: {}', login_data.status_code, login_data)
      return
    else
      Log.error('HTTP code: {}; response: {}', login_data.code, login_data)
    end
    return
  end

  return login_data.data.token
end

---@param response string
---@param on_success? function
---@param on_error? function
local function on_login(_, response, on_success, on_error)
  local token = decode_token(response)
  if token ~= nil then
    request_fico(token, on_success, on_error)
  else
    if on_error then
      on_error()
    end
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
  vim.list_extend(args, CMD_DEFAULT_ARGS)
  Rest.send({
    cmd = CMD,
    args = args,
  }, function(_, response)
    on_login(nil, response, function()
      Log.i('Login successful')
    end, function()
      Log.e('Login failed')
    end)
  end, function(signal, ...)
    on_cmd_signal(signal, ...)
    Log.e('Login failed')
  end)
end

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

function M.request_load_last_session()
  Log.info('Loading last session')
  key_storage:load(function(name)
    username = name
    Log.info('Last session for user {} loaded successful', name)
  end, function()
    Log.info('Last session not found or invalid')
  end)
end

---@alias Suggestions string[] Formated suggesion

---@param generated_text string
---@return Suggestions?
local function generate_suggestions(generated_text)
  local generated_text = fn.substitute(generated_text, '<.endoftext.>', '', 'g') or ''
  local lines = vim.split(generated_text, '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    return
  end

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
  return suggestions
end

---@class OnGenerateOneStageData User data for GenerateOneStage request
---@field path? string Temporary file path for HTTP request data
---@field task_id integer Task ID
---@field on_success? function Callback when suggestions is generated
---@field on_error? function Callback when request is failed

---@param exit_code integer
---@param response string
---@param error string
---@param data OnGenerateOneStageData
local function on_generate_one_stage(exit_code, response, error, data)
  if exit_code ~= CMD_EXIT_CODE_SUCCESS then
    ---@type string[]
    local formatted_error = vim.tbl_filter(function(s)
      return #s > 0
    end, vim.split(error, '\n'))
    Log.error('Request failed; exit_code: {}, error: {}', exit_code, formatted_error)
    if data.on_error then
      data.on_error()
    end
    return
  end

  if response == nil or response == '' then
    Log.error('Server response without data')
    if data.on_error then
      data.on_error()
    end
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    if data.on_error then
      data.on_error()
    end
    return
  end

  local completion_data = result
  if completion_data.generated_text == nil then
    Log.error('Server response without generated_text field; decoded response: {}', completion_data)
    if data.on_error then
      data.on_error()
    end
    return
  end

  local suggestions = generate_suggestions(completion_data.generated_text)

  if data.on_success then
    data.on_success(data.task_id, suggestions)
  end
end

---@param data OnGenerateOneStageData
local function on_generate_one_stage_exit(data)
  Log.debug('Clearing HTTP temporary file: {}', data.path)
  local path = data.path
  if path then
    uv.fs_unlink(path, function(err)
      if err then
        Log.error('Failed to delete HTTP temporary file; error: {}', err)
      else
        Log.debug('HTTP temporary file deleted successfully')
      end
    end)
  else
    Log.error('HTTP temporary file not found')
  end
end

---@return table|nil
local function make_generate_one_stage_params()
  local result = PromptProviders.get_current_prompt()
  if result == nil then
    return
  end
  if result.within_the_line and (not Config.internal.virtual_text.inline or Config.options.inline_completion.disable_completion_within_the_line) then
    return
  end
  local prompt = '!FCPREFIX!' .. result.prefix .. '!FCSUFFIX!' .. result.suffix .. '!FCMIDDLE!'
  local escaped_prompt = string.gsub(prompt, '"', '\\"')
  local params = {
    inputs = escaped_prompt,
    meta_datas = {
      filename = result.filename,
    },
  }
  return params
end

function M.ready_for_generate()
  return key_storage:get_key_by_name(username) ~= nil
end

---@param task_id integer
---@param on_success function|nil
---@param on_error function|nil
function M.request_generate_one_stage(task_id, on_success, on_error)
  Log.debug('Request generate one stage...')
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.debug('Key is not found')
    if on_error then
      on_error()
    end
    return
  end
  local params = make_generate_one_stage_params()
  -- Log.debug('Params: {}', params)
  if params == nil then
    if on_error then
      on_error()
    end
    return
  end
  FS.write_temp_file(fn.json_encode(params), function(_, path)
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
    vim.list_extend(args, CMD_DEFAULT_ARGS)
    Rest.send(
      {
        cmd = CMD,
        args = args,
        ---@type OnGenerateOneStageData
        data = {
          path = path,
          task_id = task_id,
          on_success = on_success,
          on_error = on_error,
        },
      },
      on_generate_one_stage,
      function(signal, ...)
        on_cmd_signal(signal, ...)
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
