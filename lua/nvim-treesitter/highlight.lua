local api = vim.api
local ts = vim.treesitter
local queries = require'nvim-treesitter.query'

local M = {
  highlighters = {}
}

function M.attach(bufnr, ft)
  local buf = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(buf, 'ft')

  local query = queries.get_query(ft, "highlights")
  if not query then return end

  M.highlighters[buf] = ts.TSHighlighter.new(query, buf, ft)
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  if M.highlighters[buf] then
    M.highlighters[buf]:set_query("")
    M.highlighters[buf] = nil
  end
  api.nvim_buf_set_option(buf, 'syntax', 'on')
end

return M
