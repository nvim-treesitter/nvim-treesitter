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

local get_line_for_node = function(node, type_patterns, transform_fn)
  local node_type = node:type()
  local is_valid = false
  for _, rgx in ipairs(type_patterns) do
    if node_type:find(rgx) then
      is_valid = true
      break
    end
  end
  if not is_valid then return '' end
  local range = {node:range()}
  local line = transform_fn(vim.trim(vim.fn.getline(range[1] + 1)))
  -- Escape % to avoid statusline to evaluate content as expression
  return line:gsub('%%', '%%%%')
end

-- Trim spaces and opening brackets from end
local transform_line = function(line)
  return line:gsub('[%[%(%{]*%s*$', '')
end

function M.named_statusline(opts)
  if not parsers.has_parser() then return end
  local options = opts or {}
  local indicator_size = options.indicator_size or 100
  local type_patterns = options.type_patterns or {'class', 'function', 'method'}
  local transform_fn = options.transform_fn or transform_line
  local separator = options.separator or ' -> '

  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return "" end

  local lines = {}
  local expr = current_node

  while expr do
    local line = get_line_for_node(expr, type_patterns, transform_fn)
    if line ~= '' and not vim.tbl_contains(lines, line) then
      table.insert(lines, 1, line)
    end
    expr = expr:parent()
  end

  local text = table.concat(lines, separator)
  local text_len = #text
  if text_len > indicator_size then
    return '...'..text:sub(text_len - indicator_size, text_len)
  end

  return text
end

return M
