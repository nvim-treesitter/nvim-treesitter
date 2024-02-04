local M = {}

local INFO = 'info'
local DEBUG = 'debug'
local WARN = 'warn'
local ERROR = 'error'
local FATAL = 'fatal'

M.type = 'message' -- 'file' 'both'
M.enabled = false

function M.log(level, msg, ...)
  if not M.enabled then
    return
  end
  local args = { ... }
  if #args > 0 then
    msg = string.format(msg, unpack(vim.tbl_map(vim.inspect, { ... })))
  end
  print('[' .. M.level .. '] ' .. '[' .. os.date('%Y-%m-%d %H:%M:%S') .. '] ' .. msg)
end

function M.info(...)
  M.log(INFO, ...)
end

function M.debug(...)
  M.log(DEBUG, ...)
end

function M.warn(...)
  M.log(WARN, ...)
end

function M.error(...)
  M.log(ERROR, ...)
end

function M.fatal(...)
  M.log(FATAL, ...)
end

return M
