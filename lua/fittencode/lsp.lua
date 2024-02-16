local M = {}

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

return M
