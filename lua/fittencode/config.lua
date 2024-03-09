local M = {}

---@class FittencodeOptions
M.options = {
  inline = vim.fn.has('nvim-0.10') == 1,
  ---@class LogOptions
  log = {
    level = vim.log.levels.WARN,
  },
}

---@param opts? FittencodeOptions
function M.setup(opts)
  M.options = vim.tbl_deep_extend('force', M.options, opts or {})
  if vim.fn.has('nvim-0.10') == 0 then
    M.options.inline = false
  end
end

return M
