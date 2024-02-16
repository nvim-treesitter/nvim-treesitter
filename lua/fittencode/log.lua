local fn = vim.fn
local uv = vim.uv

local Base = require('fittencode.base')

local M = {}

local MODULE_NAME = 'fittencode.nvim'

M.enabled = true

local first_log = true
local cpu = 0
local environ = 0

-- See `help vim.log.levels`
---@param level integer
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
      local EDGE = '================================================================================\n'
      f:write(EDGE)
      ---@type table<string,any>
      local mat = {}
      mat['Verbose logging started'] = os.date('%Y-%m-%d %H:%M:%S')
      mat['Calling process'] = uv.exepath()
      mat['Neovim version'] = vim.inspect(Base.get_version())
      mat['Process ID'] = uv.os_getpid()
      mat['Parent process ID'] = uv.os_getppid()
      mat['OS'] = vim.inspect(uv.os_uname())
      if cpu ~= 0 then
        mat['CPU'] = vim.inspect(uv.cpu_info())
      end
      if environ ~= 0 then
        mat['Environment'] = vim.inspect(uv.os_environ())
      end
      for k, v in pairs(mat) do
        f:write(string.format('%s: %s\n', k, v))
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
  M.log(vim.log.levels.ERROR, ...)
end

function M.e(...)
  M.notify(vim.log.levels.ERROR, ...)
end

function M.warn(...)
  M.log(vim.log.levels.WARN, ...)
end

function M.w(...)
  M.notify(vim.log.levels.WARN, ...)
end

function M.info(...)
  M.log(vim.log.levels.INFO, ...)
end

function M.i(...)
  M.notify(vim.log.levels.INFO, ...)
end

function M.debug(...)
  M.log(vim.log.levels.DEBUG, ...)
end

function M.d(...)
  M.notify(vim.log.levels.DEBUG, ...)
end

function M.trace(...)
  M.log(vim.log.levels.TRACE, ...)
end

function M.t(...)
  M.notify(vim.log.levels.TRACE, ...)
end

return M
