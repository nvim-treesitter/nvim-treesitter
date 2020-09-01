--TODO(theHamsta): remove once stabilized!
if not pcall(require,"vim.treesitter.query") then
  error("nvim-treesitter requires a more recent Neovim nightly version!")
end

local install = require'nvim-treesitter.install'
local utils = require'nvim-treesitter.utils'
local ts_utils = require'nvim-treesitter.ts_utils'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'


-- Registers all query predicates
require"nvim-treesitter.query_predicates"

local M = {}

function M.setup()
  utils.setup_commands('install', install.commands)
  utils.setup_commands('info', info.commands)
  utils.setup_commands('configs', configs.commands)
  configs.init()
end

function M.define_modules(...)
  configs.define_modules(...)
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
