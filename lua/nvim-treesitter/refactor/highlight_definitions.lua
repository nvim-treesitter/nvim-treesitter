-- This module highlights reference usages and the corresponding
-- definition on cursor hold.

local parsers = require'nvim-treesitter.parsers'
local ts_utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'
local api = vim.api
local cmd = api.nvim_command

local M = {}

local usage_namespace = api.nvim_create_namespace('nvim-treesitter-usages')

function M.highlight_usages(bufnr)
  M.clear_usage_highlights(bufnr)

  local node_at_point = ts_utils.get_node_at_cursor()
  local references = locals.get_references(bufnr)

  if not node_at_point or not vim.tbl_contains(references, node_at_point) then 
    return
  end

  local def_node, scope = ts_utils.find_definition(node_at_point, bufnr)
  local usages = ts_utils.find_usages(node_at_point, scope)

  for _, usage_node in ipairs(usages) do
    local start_row, start_col, _, end_col = usage_node:range()

    if usage_node ~= node_at_point then
      api.nvim_buf_add_highlight(
        bufnr, 
        usage_namespace, 
        'TSDefinitionUsage', 
        start_row,
        start_col,
        end_col)
    end
  end

  if def_node ~= node_at_point then
    local start_row, start_col, _, end_col = def_node:range()

    api.nvim_buf_add_highlight(
      bufnr, 
      usage_namespace, 
      'TSDefinition', 
      start_row,
      start_col,
      end_col)
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
