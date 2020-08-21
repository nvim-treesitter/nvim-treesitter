-- This module highlights reference usages and the corresponding
-- definition on cursor hold.

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

  local def_node, scope = locals.find_definition(node_at_point, bufnr)
  local usages = locals.find_usages(def_node, scope, bufnr)

  for _, usage_node in ipairs(usages) do
    if usage_node ~= node_at_point then
      ts_utils.highlight_node(usage_node, bufnr, usage_namespace, 'TSDefinitionUsage')
    end
  end

  if def_node ~= node_at_point then
    ts_utils.highlight_node(def_node, bufnr, usage_namespace, 'TSDefinition')
  end
end

function M.clear_usage_highlights(bufnr)
  api.nvim_buf_clear_namespace(bufnr, usage_namespace, 0, -1)
end

function M.attach(bufnr)
  cmd(string.format('augroup NvimTreesitterUsages_%d', bufnr))
  cmd 'au!'
  -- luacheck: push ignore 631
  cmd(string.format([[autocmd CursorHold <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.highlight_usages(%d)]], bufnr, bufnr))
  cmd(string.format([[autocmd CursorMoved <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.clear_usage_highlights(%d)]], bufnr, bufnr))
  cmd(string.format([[autocmd InsertEnter <buffer=%d> lua require'nvim-treesitter.refactor.highlight_definitions'.clear_usage_highlights(%d)]], bufnr, bufnr))
  -- luacheck: pop
  cmd 'augroup END'
end

function M.detach(bufnr)
  M.clear_usage_highlights(bufnr)
  cmd(string.format('autocmd! NvimTreesitterUsages_%d CursorHold', bufnr))
  cmd(string.format('autocmd! NvimTreesitterUsages_%d CursorMoved', bufnr))
  cmd(string.format('autocmd! NvimTreesitterUsages_%d InsertEnter', bufnr))
end

return M
