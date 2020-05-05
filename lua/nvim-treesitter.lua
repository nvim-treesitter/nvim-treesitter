local api = vim.api
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
      if configs.is_enabled(mod, ft) then
        local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
        api.nvim_command(string.format("autocmd FileType %s %s", ft, cmd))
      end
    end
  end
end

function M.statusline(indicator_size)
  local indicator_size = indicator_size or 1000
  local expr = require"nvim-treesitter.utils".expression_at_point()
  local current_node =
    require'nvim-treesitter.node_movement'.current_node[api.nvim_get_current_buf()]

  local indicator = ""
  while expr and (#indicator + #(expr:type()) + 5) < indicator_size do

    local prefix = ""
    if expr:parent() then
      prefix = "->"
    end


    if expr == current_node then
      indicator = string.format("%s[%s]%s", prefix, expr:type(), indicator)
    else
      indicator = prefix .. expr:type() .. indicator
    end

    expr = expr:parent()
  end

  if expr then
    return "..." .. indicator
  else
    return indicator
  end
end

return M
