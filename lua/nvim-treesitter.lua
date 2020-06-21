local api = vim.api

local install = require'nvim-treesitter.install'
local utils = require'nvim-treesitter.utils'
local ts_utils = require'nvim-treesitter.ts_utils'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'

local M = {}

function M.setup()
  utils.setup_commands('install', install.commands)
  utils.setup_commands('info', info.commands)
  utils.setup_commands('configs', configs.commands)

  for _, lang in pairs(parsers.available_parsers()) do
    for _, mod in pairs(configs.available_modules()) do
      if configs.is_enabled(mod, lang) then
        local ft = parsers.lang_to_ft(lang)
        local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
        api.nvim_command(string.format("autocmd NvimTreesitter FileType %s %s", ft, cmd))
      end
    end
  end
end

function M.statusline(indicator_size)
  if not parsers.has_parser() then return end
  local indicator_size = indicator_size or 100

  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return "" end

  local expr = current_node:parent()
  local prefix = ""
  if expr then
    prefix = "->"
  end

  local indicator = current_node:type()
  while expr and (#indicator + #(expr:type()) + 5) < indicator_size do
    indicator = expr:type() .. prefix .. indicator
    expr = expr:parent()
  end

  if expr then
    return "..." .. indicator
  else
    return indicator
  end
end

return M
