local api = vim.api
local parsers = require'nvim-treesitter.parsers'
local install = require'nvim-treesitter.install'
local locals = require'nvim-treesitter.locals'
local utils = require'nvim-treesitter.utils'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'

local M = {}

-- This function sets up everythin needed for a given language
-- this is the main interface through the plugin
function M.setup(lang)
  utils.setup_commands('install', install.commands)
  utils.setup_commands('info', info.commands)
  utils.setup_commands('configs', configs.commands)

  for _, ft in pairs(configs.available_parsers()) do
    for _, mod in pairs(configs.available_modules()) do
      if parsers.has_parser(ft) and configs.is_enabled(mod, ft) then
        local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
        api.nvim_command(string.format("autocmd FileType %s %s", ft, cmd))
      end
    end
  end
end

return M
