local M = {}

function M.setup(...)
  require('nvim-treesitter.config').setup(...)
end

function M.get_available(...)
  return require('nvim-treesitter.config').get_available(...)
end

function M.get_installed(...)
  return require('nvim-treesitter.config').get_installed(...)
end

function M.install(...)
  return require('nvim-treesitter.install').install(...)
end

function M.uninstall(...)
  return require('nvim-treesitter.install').uninstall(...)
end

function M.update(...)
  return require('nvim-treesitter.install').update(...)
end

function M.indentexpr()
  return require('nvim-treesitter.indent').get_indent(vim.v.lnum)
end

return M
