local api = vim.api
local parsers = require'nvim-treesitter.parsers'
local install = require'nvim-treesitter.install'

local M = {}

-- This function sets up everythin needed for a given language
-- this is the main interface through the plugin
function M.setup(lang)
  if parsers.has_parser(lang) then
  end
end

-- To install, run `:lua require'nvim-treesitter'.install_parser('language')`
-- we should add a vim layer over the lua function
M.install_parser = install.install_parser

return M
