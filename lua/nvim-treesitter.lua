local M = {}

function M.setup(...)
  require('lua.nvim-treesitter.configs').setup(...)
end

function M.indentexpr()
  return require('nvim-treeesitter.indent').get_indent(vim.v.lnum)
end

return M
