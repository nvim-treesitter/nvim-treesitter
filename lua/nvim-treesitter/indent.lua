local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local utils = require'nvim-treesitter.ts_utils'

local M = {}

-- TODO(kiyan): move this in tsutils and document it
local function get_node_at_line(root, lnum)
  for node in root:iter_children() do
    local srow, _, erow = node:range()
    if srow == lnum then return node end

    if node:child_count() > 0 and srow < lnum and lnum <= erow then
      return get_node_at_line(node, lnum)
    end
  end
end

local function node_fmt(node)
  if not node then return nil end
  return tostring(node)
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

local function get_indent_size()
  return vim.bo.softtabstop < 0 and vim.bo.shiftwidth or vim.bo.tabstop
end

function M.get_indent(lnum)
  local parser = parsers.get_parser()
  if not parser or not lnum then return -1 end

  local indent_queries = get_indents(vim.api.nvim_get_current_buf())
  local indents = indent_queries.indents
  local branches = indent_queries.branches
  local root = parser:parse()[1]:root()
  local node = get_node_at_line(root, lnum-1)

  local indent = 0
  local indent_size = get_indent_size()

  -- if we are on a new line (for instance by typing `o` or `O`)
  -- we should get the node that wraps the line our cursor sits in
  -- and if the node is an indent node, we should set the indent level as the indent_size
  -- and we set the node as the first child of this wrapper node or the wrapper itself
  if not node then
    local wrapper = root:descendant_for_range(lnum, 0, lnum, -1)
    node = wrapper:child(0) or wrapper
    if indents[node_fmt(wrapper)] ~= nil and wrapper ~= root then
      indent = indent_size
    end
  end

  while node and branches[node_fmt(node)] do
    node = node:parent()
  end

  local prev_row = node:start()

  while node do
    node = node:parent()
    local row = node and node:start() or prev_row
    if indents[node_fmt(node)] and prev_row ~= row then
      indent = indent + indent_size
      prev_row = row
    end
  end

  return indent
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
