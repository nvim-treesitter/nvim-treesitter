local fn = vim.fn
local uv = vim.uv

local Base = require('fittencode.base')

local M = {}

M.enabled = true
M.file = true

local first_log = true
local cpu = 0
local environ = 0

-- See `help vim.log.levels`
---@param level number
---@return string
local function to_string(level)
  if level == vim.log.levels.ERROR then
    return 'ERROR'
  elseif level == vim.log.levels.WARN then
    return 'WARN'
  elseif level == vim.log.levels.INFO then
    return 'INFO'
  elseif level == vim.log.levels.DEBUG then
    return 'DEBUG'
  elseif level == vim.log.levels.TRACE then
    return 'TRACE'
  else
    return '????'
  end
end

---@param msg string
local function log_file(msg)
  local dir = fn.stdpath('log') .. '/fittencode'
  fn.mkdir(dir, 'p')
  local path = dir .. '/fittencode.log'
  local f = io.open(path, 'a')
  if f then
    if first_log then
      local fixed = '\
================================================================================\
Verbose logging started: %s\
Calling process: %s\
Neovim version: %s\
Process ID: %d\
Parent process ID: %d\
OS: %s'
      f:write(string.format(fixed, os.date('%Y-%m-%d %H:%M:%S'), uv.exepath(), vim.inspect(Base.get_version()), uv.os_getpid(), uv.os_getppid(), vim.inspect(uv.os_uname())))
      if cpu ~= 0 then
        f:write(string.format('\nCPU: %s', vim.inspect(uv.cpu_info())))
      end
      if environ ~= 0 then
        f:write(string.format('\nEnvironment: %s', vim.inspect(uv.os_environ())))
      end
      f:write('\
================================================================================\n')
      first_log = false
    end
    f:write(string.format('%s\n', msg))
    f:close()
  end
end

---@param level number
---@param msg string|nil
function M.log(level, msg, ...)
  if not M.enabled then
    return
  end
  msg = msg or ''
  local args = { ... }
  if #args > 0 then
    msg = fn.substitute(msg, '{}', '%s', 'g')
    ---@diagnostic disable-next-line: param-type-mismatch
    msg = string.format(msg, unpack(vim.tbl_map(vim.inspect, { ... })))
  end
  local ms = string.format('%03d', math.floor((uv.hrtime() / 1e6) % 1000))
  msg = '[' .. string.format('%5s', to_string(level)) .. '] ' .. '[' .. os.date('%Y-%m-%d %H:%M:%S') .. '.' .. ms .. '] ' .. '[fittencode.nvim] ' .. (msg or '')
  vim.schedule(function()
    if M.file then
      log_file(msg)
    else
      vim.notify(msg, level)
    end
  end)
end

function M.error(...)
  M.log(vim.log.levels.ERROR, ...)
end

function M.warn(...)
  M.log(vim.log.levels.WARN, ...)
end

function M.info(...)
  M.log(vim.log.levels.INFO, ...)
end

function M.debug(...)
  M.log(vim.log.levels.DEBUG, ...)
end

function M.trace(...)
  M.log(vim.log.levels.TRACE, ...)
end

return M
