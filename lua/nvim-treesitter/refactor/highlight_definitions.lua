-- This module highlights reference usages and the corresponding
-- definition on cursor hold.

local parsers = require'nvim-treesitter.parsers'
local ts_utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'
local api = vim.api
local cmd = api.nvim_command

local M = {}

local usage_namespace = api.nvim_create_namespace('nvim-treesitter-usages')

local function find_usages(node, scope_node)
  local usages = {}
  local node_text = ts_utils.get_node_text(node)[1]

  if not node_text or #node_text < 1 then return end

  for _, def in ipairs(locals.collect_locals(bufnr, scope_node)) do
    if def.reference 
      and def.reference.node 
      and ts_utils.get_node_text(def.reference.node)[1] == node_text then
      
      table.insert(usages, def.reference.node)
    end
  end

  return usages
end

function M.highlight_usages(bufnr)
  M.clear_usage_highlights(bufnr)

  local node_at_point = ts_utils.get_node_at_cursor()

  if not node_at_point then return end

  local def_node, scope = ts_utils.find_definition(node_at_point, bufnr)
  local usages = find_usages(node_at_point, scope)

  for _, usage_node in ipairs(usages) do
    local start_row, start_col, _, end_col = usage_node:range()

    if usage_node ~= node_at_point then
      api.nvim_buf_add_highlight(
        bufnr, 
        usage_namespace, 
        'Visual', 
        start_row,
        start_col,
        end_col)
    end
  end

  if def_node then
    local start_row, start_col, _, end_col = def_node:range()

    if def_node ~= node_at_point then
      api.nvim_buf_add_highlight(
        bufnr, 
        usage_namespace, 
        'Search', 
        start_row,
        start_col,
        end_col)
    end
  end
end

function M.clear_usage_highlights(bufnr)
  api.nvim_buf_clear_namespace(bufnr, usage_namespace, 0, -1)
end

function M.attach(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  cmd(string.format('augroup NvimTreesitterUsages_%d', bufnr))
  cmd 'au!'
  cmd(string.format([[autocmd CursorHold <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.highlight_usages(%d)]], bufnr, bufnr))
  cmd(string.format([[autocmd CursorMoved <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.clear_usage_highlights(%d)]], bufnr, bufnr))
  cmd(string.format([[autocmd InsertEnter <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.clear_usage_highlights(%d)]], bufnr, bufnr))
  cmd 'augroup END'
end

function M.detach(bufnr)
  M.clear_usage_highlights(bufnr)
  cmd(string.format('autocmd! NvimTreesitterUsages_%d CursorHold', bufnr))
  cmd(string.format('autocmd! NvimTreesitterUsages_%d CursorMoved', bufnr))
  cmd(string.format('autocmd! NvimTreesitterUsages_%d InsertEnter', bufnr))
end

return M
