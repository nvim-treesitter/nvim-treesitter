local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local utils = require'nvim-treesitter.ts_utils'

local M = {}

local function get_node_at_line(root, lnum)
  for node in root:iter_children() do
    local srow, _, erow = node:range()
    if srow == lnum then return node end

    if node:child_count() > 0 and srow < lnum and lnum <= erow then
      return get_node_at_line(node, lnum)
    end
  end

  local wrapper = root:descendant_for_range(lnum, 0, lnum, -1)
  local child = wrapper:child(0)
  return child or wrapper
end

local get_indents = utils.memoize_by_buf_tick(function(bufnr)
  local indents = queries.get_capture_matches(bufnr, '@indent.node', 'indents') or {}
  local branches = queries.get_capture_matches(bufnr, '@branch.node', 'indents') or {}

  local indents_map = {}
  for _, node in ipairs(indents) do
    indents_map[tostring(node)] = true
  end

  local branches_map = {}
  for _, node in ipairs(branches) do
    branches_map[tostring(node)] = true
  end

  return { indents = indents_map, branches = branches_map }
end)

function M.get_indent(lnum)
  local parser = parsers.get_parser()
  if not parser or not lnum then return -1 end

  local node = get_node_at_line(parser:parse():root(), lnum-1)
  local indent_queries = get_indents(vim.api.nvim_get_current_buf())
  local indents = indent_queries.indents
  local branches = indent_queries.branches
  if not indents then return 0 end

  while node and branches[tostring(node)] do
    node = node:parent()
  end

  local ind = 0
  while node do
    node = node:parent()
    if indents[tostring(node)] then
      ind = ind + vim.bo.tabstop
    end
  end

  return ind
end

local indent_funcs = {}

function M.attach(bufnr)
  indent_funcs[bufnr] = vim.bo.indentexpr
  vim.bo.indentexpr = 'nvim_treesitter#indent()'
end

function M.detach(bufnr)
  vim.bo.indentexpr = indent_funcs[bufnr]
end

return M
