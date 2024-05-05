local fn = vim.fn

local Base = require('fittencode.base')
local FS = require('fittencode.fs')
local Rest = require('fittencode.rest.rest')
local Log = require('fittencode.log')
local Process = require('fittencode.concurrency.process')
local Promise = require('fittencode.concurrency.promise')

local schedule = Base.schedule

---@class RestCurlBackend : Rest
local M = Rest:new('RestCurlBackend')

local CURL = 'curl'
local TIMEOUT = 5 -- 5 seconds
local DEFAULT_ARGS = {
  '--connect-timeout',
  TIMEOUT,
  '--show-error',
  -- For debug purposes only, `-v, Make the operation more talkative`
  -- '-v',
}
local EXIT_CODE_SUCCESS = 0

local function on_cmd_exitcode(exit_code, response, error, on_success, on_error)
  if exit_code ~= EXIT_CODE_SUCCESS then
    ---@type string[]
    local formatted_error = vim.tbl_filter(function(s)
      return #s > 0
    end, vim.split(error, '\n'))
    Log.error('Request failed; exit_code: {}, error: {}', exit_code, formatted_error)
    schedule(on_error)
  else
    schedule(on_success, response)
  end
end

function M:authorize(url, token, on_success, on_error)
  local args = {
    '-s',
    '-H',
    'Authorization: Bearer ' .. token,
    url,
  }
  vim.list_extend(args, DEFAULT_ARGS)
  Process.spawn({
    cmd = CURL,
    args = args,
  }, function(exit_code, response, error)
    on_cmd_exitcode(exit_code, response, error, on_success, on_error)
  end, function(signal, ...)
    schedule(on_error, signal)
  end)
end

local function post_largedata(url, encoded_data, on_success, on_error)
  Promise:new(function(resolve, reject)
    FS.write_temp_file(encoded_data, function(_, path)
      resolve(path)
    end, function(e_tmpfile)
      schedule(on_error, e_tmpfile)
    end)
  end):forward(function(path)
    return Promise:new(function(resolve, reject)
      local args = {
        '-s',
        '-X',
        'POST',
        '-H',
        'Content-Type: application/json',
        '-d',
        '@' .. path,
        url,
      }
      vim.list_extend(args, DEFAULT_ARGS)
      Process.spawn({
        cmd = CURL,
        args = args,
      }, function(exit_code, response, error)
        on_cmd_exitcode(exit_code, response, error, on_success, on_error)
      end, function(signal, ...)
        schedule(on_error, signal)
      end, function()
        FS.delete(path)
      end)
    end)
  end)
end

function M:post(url, data, on_success, on_error)
  local encoded_data = fn.json_encode(data)
  if #encoded_data > 200 then
    return post_largedata(url, encoded_data, on_success, on_error)
  end
  local args = {
    '-s',
    '-X',
    'POST',
    '-H',
    'Content-Type: application/json',
    '-d',
    encoded_data,
    url,
  }
  vim.list_extend(args, DEFAULT_ARGS)
  Process.spawn({
    cmd = CURL,
    args = args,
  }, function(exit_code, response, error)
    on_cmd_exitcode(exit_code, response, error, on_success, on_error)
  end, function(signal, ...)
    schedule(on_error, signal)
  end)
end

return M
