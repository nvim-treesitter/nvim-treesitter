local api = vim.api
local fn = vim.fn
local uv = vim.uv or vim.loop

local Base = require('fittencode.base')
local Promise = require('fittencode.concurrency.promise')

local M = {}

-- Refs:
-- * `3rd\luv\library\uv.lua`
---* `3rd\luv\library\errors.lua`
-- * uv.error.name
-- * uv.error.message
---@class UvError
---@field name string
---@field message string

---@param err string
---@return UvError
local function uv_err(err)
  if not err then
    return { name = 'uv_err', message = 'Error is nil' }
  end
  local pos = err:find(':', 1, true)
  local name = err:sub(1, pos - 1)
  local message = err:sub(pos + 2)
  return { name = name, message = message }
end

local function schedule_wrap(fx, ...)
  if fx then
    local args = { ... }
    vim.schedule(function()
      fx(unpack(args))
    end)
  end
end

-- Create a directory if it doesn't exist.
-- * If successful, call `on_success` with the directory path.
-- * If an error occurs, call `on_error` with the error message.
---@param dir string
---@param on_success function|nil
---@param on_error function|nil
function M.mkdir(dir, on_success, on_error)
  Promise:new(function(resolve, reject)
    uv.fs_mkdir(
      dir,
      448, -- decimal 448 = octal 0700
      function(err, success)
        if err then
          local parsed = uv_err(err)
          if parsed.name ~= 'EEXIST' then
            reject(parsed)
          else
            resolve(success)
          end
        else
          resolve(success)
        end
      end)
  end):forward(function(_)
    schedule_wrap(on_success, dir)
  end, function(parsed)
    schedule_wrap(on_error, parsed)
  end)
end

-- Write data to a file. Assumes the directory already exists.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.write(data, path, on_success, on_error)
  Promise:new(function(resolve, reject)
    uv.fs_open(
      path,
      'w',
      438, -- decimal 438 = octal 0666
      function(e_open, fd)
        if e_open then
          reject(e_open)
        else
          assert(fd ~= nil)
          resolve(fd)
        end
      end)
  end):forward(function(fd)
    return Promise:new(function(resolve, reject)
      uv.fs_write(
        fd,
        data,
        -1,
        function(e_write, _)
          if e_write then
            reject(e_write)
          else
            uv.fs_close(fd, function(_, _) end)
            resolve()
          end
        end)
    end)
  end, function(e_open)
    schedule_wrap(on_error, uv_err(e_open))
  end):forward(function()
    schedule_wrap(on_success, data, path)
  end, function(e_write)
    schedule_wrap(on_error, uv_err(e_write))
  end)
end

-- Write data to a file, creating the directory if it doesn't exist.
-- * If successful, call `on_success` with the data, file path, and directory path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.write_mkdir(data, path, on_success, on_error)
  Promise:new(function(resolve, reject)
    local head = fn.fnamemodify(path, ':h')
    if head == nil or head == '' then
      reject()
    else
      resolve(head)
    end
  end):forward(function(head)
    return Promise:new(function(resolve, reject)
      M.mkdir(head, function(h)
        resolve(h)
      end, function(e_mkdir)
        reject(e_mkdir)
      end)
    end)
  end, function()
    schedule_wrap(on_error, { name = 'fn.fnamemodify', message = 'Failed to get the head of the file name' })
  end):forward(function(h)
    return Promise:new(function(resolve, reject)
      M.write(data, path, function(d, p)
        resolve({ d, p, h })
      end, function(e_write)
        reject(e_write)
      end)
    end)
  end, function(e_mkdir)
    schedule_wrap(on_error, e_mkdir)
  end):forward(function(dph)
    schedule_wrap(on_success, dph[1], dph[2], dph[3])
  end, function(e_write)
    schedule_wrap(on_error, e_write)
  end)
end

-- Write data to a temporary file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param on_success function|nil
---@param on_error function|nil
function M.write_temp_file(data, on_success, on_error)
  Promise:new(function(resolve, reject)
    local path = fn.tempname()
    if not path then
      local e_tempname = { name = 'fn.tempname', message = 'Failed to generate temporary file name' }
      reject(e_tempname)
    else
      resolve(path)
    end
  end):forward(function(path)
    return Promise:new(function(resolve, reject)
      path = Base.to_native(path)
      M.write(data, path, function(d, p)
        resolve({ d, p })
      end, function(e_write)
        reject(e_write)
      end)
    end)
  end, function(e_tempname)
    schedule_wrap(on_error, e_tempname)
  end):forward(function(dp)
    schedule_wrap(on_success, dp[1], dp[2])
  end, function(e_write)
    schedule_wrap(on_error, e_write)
  end)
end

-- Read data from a file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.read(path, on_success, on_error)
  Promise:new(function(resolve, reject)
    uv.fs_open(
      path,
      'r',
      438, -- decimal 438 = octal 0666
      function(e_open, fd)
        if e_open then
          reject(e_open)
        else
          assert(fd ~= nil)
          resolve(fd)
        end
      end)
  end):forward(function(fd)
    return Promise:new(function(resolve, reject)
      uv.fs_fstat(fd, function(e_stat, stat)
        if e_stat then
          reject(e_stat)
        else
          assert(stat ~= nil)
          resolve({ fd, stat.size })
        end
      end)
    end)
  end, function(e_open)
    schedule_wrap(on_error, uv_err(e_open))
  end):forward(function(fdssz)
    return Promise:new(function(resolve, reject)
      uv.fs_read(
        fdssz[1],
        fdssz[2],
        -1,
        function(e_read, data)
          if e_read then
            reject(e_read)
          else
            uv.fs_close(fdssz[1], function(_, _) end)
            resolve(data)
          end
        end)
    end)
  end, function(e_stat)
    schedule_wrap(on_error, uv_err(e_stat))
  end):forward(function(data)
    schedule_wrap(on_success, data, path)
  end, function(e_read)
    schedule_wrap(on_error, uv_err(e_read))
  end)
end

---@param file string
---@return boolean
function M.exists(file)
  return uv.fs_stat(file) ~= nil
end

return M
