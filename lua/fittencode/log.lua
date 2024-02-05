local M = {}

M.enabled = true

local function to_string(level)
  if level == vim.log.levels.ERROR then
    return 'ERROR'
  elseif level == vim.log.levels.WARN then
    return 'WARN'
  elseif level == vim.log.levels.INFO then
    return 'INFO'
  elseif level == vim.log.levels.DEBUG then
    return 'DEBUG'
  else
    return 'UNKNOWN'
  end
end

function M.log(level, msg, ...)
  if not M.enabled then
    return
  end
  local args = { ... }
  if #args > 0 then
    msg = string.format(msg, unpack(vim.tbl_map(vim.inspect, { ... })))
  end
  msg = '[' .. to_string(level) .. '] ' .. '[' .. os.date('%Y-%m-%d %H:%M:%S') .. '] ' .. '[fittencode.nvim] ' .. msg
  vim.notify(msg, level)
end

function M.info(...)
  M.log(vim.log.levels.INFO, ...)
end

function M.debug(...)
  M.log(vim.log.levels.DEBUG, ...)
end

function M.warn(...)
  M.log(vim.log.levels.WARN, ...)
end

function M.error(...)
  M.log(vim.log.levels.ERROR, ...)
end

return M
