local install = require('nvim-treesitter.install')
local utils = require('nvim-treesitter.utils')
local info = require('nvim-treesitter.info')

-- Registers all query predicates
require('nvim-treesitter.query_predicates')

local M = {}

-- TODO(clason): replace with explicit Nvim API calls
function M.setup()
  utils.setup_commands('install', install.commands)
  utils.setup_commands('info', info.commands)
end

function M.indentexpr()
  return require('nvim-treeesitter.indent').get_indent(vim.v.lnum)
end

return M
