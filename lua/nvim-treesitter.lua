local api = vim.api

local install = require'nvim-treesitter.install'
local utils = require'nvim-treesitter.utils'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'
local state = require'nvim-treesitter.state'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

function M.setup()
  utils.setup_commands('install', install.commands)
  utils.setup_commands('info', info.commands)
  utils.setup_commands('configs', configs.commands)

  for _, ft in pairs(configs.available_parsers()) do
    for _, mod in pairs(configs.available_modules()) do
      if configs.is_enabled(mod, ft) then
        local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
        api.nvim_command(string.format("autocmd NvimTreesitter FileType %s %s", ft, cmd))
      end
    end
    local cmd = string.format("lua require'nvim-treesitter.state'.attach_to_buffer(%s)", ft)
    api.nvim_command(string.format('autocmd NvimTreesitter FileType %s %s', ft, cmd))
  end

  state.run_update()
end

function M.statusline(indicator_size)
  local indicator_size = indicator_size or 100
  local bufnr = api.nvim_get_current_buf()
  local buf_state = state.get_buf_state(bufnr)
  if not buf_state then return "" end

  local current_node = buf_state.current_node
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

function M.get_buf_state()
  local bufnr = api.nvim_get_current_buf()
  return state.exposed_state(bufnr)
end

function M.get_node_api()
  return ts_utils
end

return M
