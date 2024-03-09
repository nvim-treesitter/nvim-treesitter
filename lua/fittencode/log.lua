local fn = vim.fn
local uv = vim.uv

local Base = require('fittencode.base')

local M = {}

---@class LogOptions
---@field level? integer @one of the `vim.log.levels` values

local MODULE_NAME = 'fittencode.nvim'
local LOG_PATH = Base.to_native(fn.stdpath('log') .. '/fittencode' .. '/fittencode.log')

-- See `help vim.log.levels`
-- Refs: `neovim/runtime/lua/vim/_editor.lua`
--[[
  ```lua
  vim.log = {
    levels = {
      TRACE = 0,
      DEBUG = 1,
      INFO = 2,
      WARN = 3,
      ERROR = 4,
      OFF = 5,
    },
  }
  ```
]]
local levels = vim.deepcopy(vim.log.levels)
-- Default log level is WARN.
-- If you want to change it, use `require('fittencode').set_log_level(level)`
local current = levels.WARN

local first_log = true
local cpu = 0
local environ = 0

local function level_name(x)
  for k, v in pairs(levels) do
    if v == x then
      return k
    end
  end
  return '????'
end

-- Log a message to a file.
---@param msg string @the message to log
local function log_file(msg)
  local f = io.open(LOG_PATH, 'a')
  if f then
    if first_log then
      local EDGE = '================================================================================\n'
      f:write(EDGE)
      ---@type table<string,any>
      local mat = {}
      table.insert(mat, { 'Verbose logging started', os.date('%Y-%m-%d %H:%M:%S') })
      table.insert(mat, { 'Log level', level_name(current) })
      table.insert(mat, { 'Calling process', uv.exepath() })
      table.insert(mat, { 'Neovim version', vim.inspect(Base.get_version()) })
      table.insert(mat, { 'Process ID', uv.os_getpid() })
      table.insert(mat, { 'Parent process ID', uv.os_getppid() })
      table.insert(mat, { 'OS', vim.inspect(uv.os_uname()) })
      if cpu ~= 0 then
        table.insert(mat, { 'CPU', vim.inspect(uv.cpu_info()) })
      end
      if environ ~= 0 then
        table.insert(mat, { 'Environment', vim.inspect(uv.os_environ()) })
      end
      for i in ipairs(mat) do
        f:write(string.format('%s: %s\n', mat[i][1], mat[i][2]))
      end
      f:write(EDGE)
      first_log = false
    end
    f:write(string.format('%s\n', msg))
    f:close()
  end
end

-- Expand a message with optional arguments.
---@param msg string|nil @can be a format string with {} placeholders
---@param... any @optional arguments to substitute into the message
---@return string
local function expand_msg(msg, ...)
  msg = msg or ''
  local count = 0
  msg, count = msg:gsub('{}', '%%s')
  local args = vim.tbl_map(vim.inspect, { ... })
  if #args < count then
    for i = #args + 1, count do
      args[i] = vim.inspect(nil)
    end
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  msg = string.format(msg, unpack(args))
  return msg
end

-- Log a message with a given level.
---@param level integer @one of the `vim.log.levels` values
---@param msg string|nil @can be a format string with {} placeholders
local function do_log(level, msg)
  ---@type table<string,string>
  local mat = {}
  local ms = string.format('%03d', math.floor((uv.hrtime() / 1e6) % 1000))
  table.insert(mat, string.format('%5s', level_name(level)))
  table.insert(mat, os.date('%Y-%m-%d %H:%M:%S') .. '.' .. ms)
  table.insert(mat, MODULE_NAME)
  local tags = ''
  for i in ipairs(mat) do
    tags = tags .. string.format('[%s]', mat[i]) .. ' '
  end
  msg = tags .. msg
  log_file(msg)
end

---@param opts LogOptions
function M.setup(opts)
  -- Parse options.
  if opts and type(opts.level) == 'number' then
    current = opts.level
  end

  local LOG_HOME = fn.fnamemodify(LOG_PATH, ':h')
  fn.mkdir(LOG_HOME, 'p')
end

---@param level integer @one of the `vim.log.levels` values
function M.set_level(level)
  current = level
end

---@param level integer @one of the `vim.log.levels` values
---@param msg string|nil @can be a format string with {} placeholders
function M.log(level, msg, ...)
  if level < current or current == levels.OFF then
    return
  end
  msg = expand_msg(msg, ...)
  do_log(level, msg)
end

-- Notify the user of a message.
---@param level integer @one of the `vim.log.levels` values
---@param msg string|nil @can be a format string with {} placeholders
function M.notify(level, msg, ...)
  msg = expand_msg(msg, ...)
  vim.schedule(function()
    vim.notify(msg, level, { title = MODULE_NAME })
  end)
end

function M.error(...)
  M.log(levels.ERROR, ...)
end

function M.e(...)
  M.notify(levels.ERROR, ...)
end

function M.warn(...)
  M.log(levels.WARN, ...)
end

function M.w(...)
  M.notify(levels.WARN, ...)
end

function M.info(...)
  M.log(levels.INFO, ...)
end

function M.i(...)
  M.notify(levels.INFO, ...)
end

function M.debug(...)
  M.log(levels.DEBUG, ...)
end

function M.d(...)
  M.notify(levels.DEBUG, ...)
end

function M.trace(...)
  M.log(levels.TRACE, ...)
end

function M.t(...)
  M.notify(levels.TRACE, ...)
end

return M
