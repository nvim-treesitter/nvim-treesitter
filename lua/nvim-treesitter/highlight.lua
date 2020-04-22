local api = vim.api
local queries = require'nvim-treesitter.query'
local ts = vim.treesitter

local M = {
  highlighters={}
}

function M.setup(bufnr, ft)
  local buf = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(buf, 'ft')

  local query = queries.get_query(ft, "highlights")
  if not query then return end

  M.highlighters[buf] = ts.TSHighlighter.new(query, buf, ft)
end

return M
