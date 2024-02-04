local M = {}

local Log = require('fittencode.log')

function M.is_active()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return false
  end
  local entries = cmp.get_entries()
  return vim.tbl_count(entries) > 0
end

return M
