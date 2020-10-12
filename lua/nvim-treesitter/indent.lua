-- TODO: logic not working properly
-- need to find a better way to get the indent from a line
-- it almosts works though
local api = vim.api
local utils = require'nvim-treesitter.ts_utils'
local query = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'

local M = {}

local function get_node_at_line(lnum)
  local node = utils.get_node_at_cursor()
  local srow = node:range()

  if srow+1 < lnum then
    for n in node:iter_children() do
      local row = n:range()
      if row+1 == lnum then
        node = n
        break
      end
    end
  end

  return node
end

function M.get_indent(lnum)
  if not parsers.has_parser() or not lnum then return -1 end

  local node = get_node_at_line(lnum)
  local srow, scol, erow, ecol = node:range()

  local parent = locals.containing_scope(node:parent() or node)
  local parent_row, pscol, perow, pecol = parent:range()
  local parent_indent = vim.fn.indent(parent_row+1)

  if (parent_row == srow and pscol == scol) or (perow == erow and pecol == ecol) then
    node = parent
    srow = node:range()
    node_indent = vim.fn.indent(srow+1)

    parent = locals.containing_scope(parent:parent() or parent) 
    parent_row = parent:range()
    parent_indent = vim.fn.indent(parent_row+1)

    if node_indent == 0 and parent_indent == 0 then
      return 0
    end
  end

  local tabstop = vim.bo.tabstop
  return parent_indent + tabstop
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
