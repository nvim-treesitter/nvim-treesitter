local fn = vim.fn
local uv = vim.uv

local Base = require('fittencode.base')

local M = {}

local MODULE_NAME = 'fittencode.nvim'
local LOG_PATH = fn.stdpath('log') .. '/fittencode' .. '/fittencode.log'

-- See `help vim.log.levels`
-- Refs: neovim/runtime/lua/vim/_editor.lua
--[[
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
]]
local levels = vim.deepcopy(vim.log.levels)
local current = levels.TRACE

local first_log = true
local cpu = 0
local environ = 0

---@param level integer
---@return string
local function to_string(level)
  if level == levels.ERROR then
    return 'ERROR'
  elseif level == levels.WARN then
    return 'WARN'
  elseif level == levels.INFO then
    return 'INFO'
  elseif level == levels.DEBUG then
    return 'DEBUG'
  elseif level == levels.TRACE then
    return 'TRACE'
  else
    return '????'
  end
end

---@param msg string
local function log_file(msg)
  local f = io.open(LOG_PATH, 'a')
  if f then
    if first_log then
      local EDGE = '================================================================================\n'
      f:write(EDGE)
      ---@type table<string,any>
      local mat = {}
      table.insert(mat, { 'Verbose logging started', os.date('%Y-%m-%d %H:%M:%S') })
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

---@param notify boolean
---@param level integer
---@param msg string|nil
local function do_log(notify, level, msg, ...)
  if level < current or current == levels.OFF then
    return
  end
  msg = msg or ''
  local args = { ... }
  if #args > 0 then
    msg = fn.substitute(msg, '{}', '%s', 'g')
    ---@diagnostic disable-next-line: param-type-mismatch
    msg = string.format(msg, unpack(vim.tbl_map(vim.inspect, { ... })))
  end
  vim.schedule(function()
    if notify then
      vim.notify(msg, level, { title = MODULE_NAME })
    end
    ---@type table<string,string>
    local mat = {}
    local ms = string.format('%03d', math.floor((uv.hrtime() / 1e6) % 1000))
    table.insert(mat, string.format('%5s', to_string(level)))
    table.insert(mat, os.date('%Y-%m-%d %H:%M:%S') .. '.' .. ms)
    table.insert(mat, MODULE_NAME)
    local tags = ''
    for i in ipairs(mat) do
      tags = tags .. string.format('[%s]', mat[i]) .. ' '
    end
    msg = tags .. msg
    log_file(msg)
  end)
end

function M.setup()
  local LOG_HOME = fn.fnamemodify(LOG_PATH, ':h')
  fn.mkdir(LOG_HOME, 'p')
end

function M.set_level(level)
  current = level
end

---@param level integer
---@param msg string|nil
function M.log(level, msg, ...)
  do_log(false, level, msg, ...)
end

---@param level integer
---@param msg string|nil
function M.notify(level, msg, ...)
  do_log(true, level, msg, ...)
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
