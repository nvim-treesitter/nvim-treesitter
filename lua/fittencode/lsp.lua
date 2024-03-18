local M = {}

-- Check if the current buffer is active in the completion menu
---@return boolean
function M.is_active()
  ---@type boolean, any
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return false
  end
  ---@type table
  local entries = cmp.get_entries()
  return vim.tbl_count(entries) > 0
end

function M.resiter_source()
  ---@type boolean, any
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return false
  end
  cmp.register_source('fittencode', require('fittencode.source'):new())
end

return M
