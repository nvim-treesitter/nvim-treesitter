local api = vim.api
local install = require'nvim-treesitter.install'
local utils = require'nvim-treesitter.utils'
local highlight = require'nvim-treesitter.highlight'

local M = {}

function M.setup()
  utils.setup_commands('install', install.commands)
  utils.setup_commands('highlight', highlight.commands)
end

return M
