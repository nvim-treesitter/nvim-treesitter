local fn = vim.fn

local FittenClient = require('fittencode.rest.fitten_client')
local Log = require('fittencode.log')
local Process = require('fittencode.concurrency.process')
local URL = require('fittencode.rest.url')

---@class FittenClientCurlBackend : FittenClient
local M = FittenClient:new('FittenClientCurlBackend')

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

  if on_success then
    on_success(fico_data.data.fico_token)
  end
end

---@param token string
---@param on_success? function
---@param on_error? function
local function request_fico(token, on_success, on_error)
  local args = {
    '-s',
    '-H',
    'Authorization: Bearer ' .. token,
    URL.GET_FT_TOKEN
    ,
  }
  vim.list_extend(args, CMD_DEFAULT_ARGS)
  Process.spawn({
    cmd = CMD,
    args = args,
  }, function(_, response)
    on_fico(nil, response, function(key)
      if on_success then
        on_success(key)
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

function M:login(username, password, on_success, on_error)
  local data = {
    username = username,
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
    URL.LOGIN,
  }
  vim.list_extend(args, CMD_DEFAULT_ARGS)
  Process.spawn({
    cmd = CMD,
    args = args,
  }, function(_, response)
    on_login(nil, response, function(key)
      if on_success then
        on_success(key)
      end
    end, function()
      Log.e('Login failed')
    end)
  end, function(signal, ...)
    on_cmd_signal(signal, ...)
    Log.e('Login failed')
  end)
end

function M:generate_one_stage()
end

return M
