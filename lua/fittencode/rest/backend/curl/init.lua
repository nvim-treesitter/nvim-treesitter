local fn = vim.fn

local Base = require('fittencode.base')
local FittenClient = require('fittencode.rest.fitten_client')
local Log = require('fittencode.log')
local Process = require('fittencode.concurrency.process')
local Promise = require('fittencode.concurrency.promise')
local URL = require('fittencode.rest.url')

---@class FittenClientCurlBackend : FittenClient
local M = FittenClient:new('FittenClientCurlBackend')

local schedule = Base.schedule

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
local function on_fico_response(_, response, on_success, on_error)
  if response == nil or response == '' then
    Log.error('Server response without data')
    schedule(on_error)
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    schedule(on_error)
    return
  end

  local fico_data = result
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.error('Server response without fico_token field; decoded response: {}', fico_data)
    schedule(on_error)
    return
  end

  schedule(on_success, fico_data.data.fico_token)
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

  Promise:new(function(resolve, reject)
    Process.spawn({
      cmd = CMD,
      args = args,
    }, function(_, response)
      resolve(response)
    end, function(signal, ...)
      on_cmd_signal(signal, ...)
      reject(signal)
    end)
  end):forward(function(response)
    return Promise:new(function(resolve, reject)
      on_fico_response(nil, response, function(key)
        resolve(key)
      end, function(fico_error)
        reject(fico_error)
      end)
    end)
  end, function(signal)
    schedule(on_error, signal)
  end):forward(function(key)
    schedule(on_success, key)
  end, function(fico_error)
    schedule(on_error, fico_error)
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

  Promise:new(function(resolve, reject)
    Process.spawn({
      cmd = CMD,
      args = args,
    }, function(_, response)
      resolve(response)
    end, function(signal, ...)
      on_cmd_signal(signal, ...)
      reject(signal)
    end)
  end):forward(function(response)
    return Promise:new(function(resolve, reject)
      local token = decode_token(response)
      if token ~= nil then
        resolve(token)
      else
        reject()
      end
    end)
  end, function(signal)
    schedule(on_error, signal)
  end):forward(function(token)
    return Promise:new(function(resolve, reject)
      request_fico(token, function(key)
        resolve(key)
      end, function(fico_error)
        reject(fico_error)
      end)
    end)
  end, function()
    schedule(on_error)
  end):forward(function(key)
    schedule(on_success, key)
  end, function(fico_error)
    schedule(on_error, fico_error)
  end)
end

function M:generate_one_stage()
end

return M
