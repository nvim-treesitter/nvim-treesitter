local M = {}

--TODO(clason): replace by vim.fs._join_paths
function M.join_path(...)
  return (table.concat({ ... }, '/'):gsub('//+', '/'))
end

function M.get_package_path(...)
  return M.join_path(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

return M
