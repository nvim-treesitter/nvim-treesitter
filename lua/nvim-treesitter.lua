local api = vim.api
local parsers = require'nvim-treesitter.parsers'
local install = require'nvim-treesitter.install'
local locals = require'nvim-treesitter.locals'

local M = {}

-- This function sets up everythin needed for a given language
-- this is the main interface through the plugin
function M.setup(lang)
  if parsers.has_parser(lang) then
    if locals.is_supported(lang) then
      print("Locals setup for", lang)
      api.nvim_command(string.format([[
      autocmd NvimTreesitter FileType %s lua vim.api.nvim_buf_attach(0, true, {on_lines=require'nvim-treesitter.locals'.on_lines})
      ]], lang))
    end
  end
end

-- To install, run `:lua require'nvim-treesitter'.install_parser('language')`
-- we should add a vim layer over the lua function
M.install_parser = install.install_parser

return M
