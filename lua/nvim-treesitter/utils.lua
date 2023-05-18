local M = {}

--TODO(clason): replace by vim.fs._join_paths
function M.join_path(...)
  return table.concat(
    { ... },
    (vim.loop.os_uname().sysname == 'Windows_NT' and not vim.opt.shellslash:get()) and '\\' or '/'
  )
end

function M.get_package_path(...)
  return M.join_path(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

return M
