local M = {}

-- Returns the system-specific path separator.
---@return string
function M.get_path_sep()
  return (vim.loop.os_uname().sysname == 'Windows_NT' and not vim.opt.shellslash:get()) and '\\'
    or '/'
end

function M.join_path(...)
  return table.concat({ ... }, M.get_path_sep())
end

function M.get_package_path()
  -- Path to this source file, removing the leading '@'
  local source = string.sub(debug.getinfo(1, 'S').source, 2)

  -- Path to the package root
  return vim.fn.fnamemodify(source, ':p:h:h:h')
end

return M
