local M = {}

function M.setup(...)
  require('nvim-treesitter.config').setup(...)
end

function M.indentexpr()
  return require('nvim-treesitter.indent').get_indent(vim.v.lnum)
end

return M
