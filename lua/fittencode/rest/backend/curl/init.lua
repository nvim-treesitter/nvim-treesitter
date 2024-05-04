local fn = vim.fn

local Base = require('fittencode.base')
local FittenClient = require('fittencode.rest.fitten_client')
local FS = require('fittencode.fs')
local Log = require('fittencode.log')
local Process = require('fittencode.concurrency.process')
local Promise = require('fittencode.concurrency.promise')
local URL = require('fittencode.rest.url')

local schedule = Base.schedule

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

---@param exit_code integer
---@param response string
---@param error string
local function process_response(exit_code, response, error)
  if exit_code ~= CMD_EXIT_CODE_SUCCESS then
    ---@type string[]
    local formatted_error = vim.tbl_filter(function(s)
      return #s > 0
    end, vim.split(error, '\n'))
    Log.error('Request failed; exit_code: {}, error: {}', exit_code, formatted_error)
    return
  end

  if response == nil or response == '' then
    Log.error('Server response without data')
    return
  end

  local decode_ok, result = pcall(fn.json_decode, response)
  if decode_ok == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    return
  end

  local completion_data = result
  if completion_data.generated_text == nil then
    Log.error('Server response without generated_text field; decoded response: {}', completion_data)
    return
  end

  return completion_data.generated_text
end

function M:generate_one_stage(api_key, params, on_success, on_error)
  Promise:new(function(resolve, reject)
    FS.write_temp_file(fn.json_encode(params), function(_, path)
      resolve(path)
    end, function(e_tmpfile)
      reject(e_tmpfile)
    end)
  end):forward(function(path)
    return Promise:new(function(resolve, reject)
      local server = URL.GENERATE_ONE_STAGE
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

      Process.spawn({
        cmd = CMD,
        args = args,
      }, function(exit_code, response, error)
        resolve({ exit_code, response, error })
      end, function(signal, ...)
        on_cmd_signal(signal, ...)
        reject(signal)
      end, function()
        FS.delete(path)
      end)
    end)
  end, function(e_tmpfile)
    schedule(on_error, e_tmpfile)
  end):forward(function(ere)
    local generated_text = process_response(ere[1], ere[2], ere[3])
    if generated_text == nil then
      schedule(on_error)
    else
      schedule(on_success, generated_text)
    end
  end, function(signal)
    schedule(on_error, signal)
  end)
end

return M
