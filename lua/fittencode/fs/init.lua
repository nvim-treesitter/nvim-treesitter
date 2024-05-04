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
local function parse_err(err)
  if not err then
    return { name = 'parse_err', message = 'Error is nil' }
  end
  local pos = err:find(':', 1, true)
  local name = err:sub(1, pos - 1)
  local message = err:sub(pos + 2)
  return { name = name, message = message }
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
          reject(err)
        else
          resolve(success)
        end
      end)
  end):forward(function(success)
    if on_success then
      vim.schedule(function()
        on_success(dir)
      end)
    end
  end, function(err)
    local parsed = parse_err(err)
    if parsed.name ~= 'EEXIST' then
      if on_error then
        vim.schedule(function()
          on_error(parsed)
        end)
      end
      return
    end
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
  uv.fs_open(
    path,
    'w',
    438, -- decimal 438 = octal 0666
    ---@param e_open string|nil
    function(e_open, fd)
      if e_open then
        if on_error then
          vim.schedule(function()
            on_error(parse_err(e_open))
          end)
        end
        return
      end
      if fd ~= nil then
        ---@param e_write string|nil
        uv.fs_write(fd, data, -1, function(e_write, _)
          if e_write then
            if on_error then
              vim.schedule(function()
                on_error(parse_err(e_write))
              end)
            end
            return
          end
          uv.fs_close(fd, function(_, _) end)
          if on_success then
            vim.schedule(function()
              on_success(data, path)
            end)
          end
        end)
      end
    end
  )
end

-- Write data to a file, creating the directory if it doesn't exist.
-- * If successful, call `on_success` with the data, file path, and directory path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.write_mkdir(data, path, on_success, on_error)
  local head = fn.fnamemodify(path, ':h')
  if head == nil or head == '' then
    if on_error ~= nil then
      vim.schedule(function()
        on_error({ name = 'fn.fnamemodify', message = 'Failed to get the head of the file name' })
      end)
    end
    return
  end
  M.mkdir(head, function(h)
    M.write(data, path, function(d, p)
      if on_success then
        vim.schedule(function()
          on_success(d, p, h)
        end)
      end
    end, on_error)
  end, on_error)
end

-- Write data to a temporary file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param on_success function|nil
---@param on_error function|nil
function M.write_temp_file(data, on_success, on_error)
  local path = fn.tempname()
  if not path then
    if on_error then
      vim.schedule(function()
        on_error({ name = 'fn.tempname', message = 'Failed to generate temporary file name' })
      end)
    end
    return
  end
  path = Base.to_native(path)
  M.write(data, path, function(d, p)
    if on_success then
      vim.schedule(function()
        on_success(d, p)
      end)
    end
  end, on_error)
end

-- Read data from a file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.read(path, on_success, on_error)
  uv.fs_open(
    path,
    'r',
    438, -- decimal 438 = octal 0666
    ---@param e_open string|nil
    function(e_open, fd)
      if e_open then
        if on_error then
          vim.schedule(function()
            on_error(parse_err(e_open))
          end)
        end
        return
      end
      if fd ~= nil then
        ---@param e_stat string|nil
        uv.fs_fstat(fd, function(e_stat, stat)
          if e_stat then
            if on_error then
              vim.schedule(function()
                on_error(parse_err(e_stat))
              end)
            end
            return
          end
          if stat ~= nil then
            ---@param e_read string|nil
            uv.fs_read(fd, stat.size, -1, function(e_read, data)
              if e_read then
                if on_error then
                  vim.schedule(function()
                    on_error(parse_err(e_read))
                  end)
                end
                return
              end
              uv.fs_close(fd, function(_, _) end)
              if on_success then
                vim.schedule(function()
                  on_success(data, path)
                end)
              end
            end)
          end
        end)
      end
    end
  )
end

---@param file string
---@return boolean
function M.exists(file)
  return uv.fs_stat(file) ~= nil
end

return M
