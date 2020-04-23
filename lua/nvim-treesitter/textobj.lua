local api = vim.api
local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local M = {}

local function node_range_to_vim(node)
  if node then
    local start_row, start_col, end_row, end_col = node:range()

    return {{start_row, start_col}, {end_row, end_col}}
  else
    return {{}, {}}
  end
end

function M.node_incremental()
  local buf, sel_start_line, sel_start_col, _ = unpack(vim.fn.getpos("'<"))
  local buf, sel_end_line, sel_end_col, _ = unpack(vim.fn.getpos("'>"))

  if parsers.has_parser() then
    local root = parsers.get_parser():parse():root()
    local node = root:named_descendant_for_range(sel_start_line-1, sel_start_col-1, sel_end_line-1, sel_end_col)
    local node_start_row, node_start_col, node_end_row, node_end_col = node:range()

    if (sel_start_line-1) == node_start_row and (sel_start_col-1) == node_start_col
      and (sel_end_line-1) == node_end_row and sel_end_col == node_end_col then
      return node_range_to_vim(node:parent() or node)
    else
      return node_range_to_vim(node)
    end
  else
    return node_range_to_vim()
  end
end

function M.scope_incremental()
  local _, sel_start_line, sel_start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, sel_end_line, sel_end_col, _ = unpack(vim.fn.getpos("'>"))

  if parsers.has_parser() then
    local root = parsers.get_parser():parse():root()
    local node = utils.smallest_containing_scope(
    root:named_descendant_for_range(sel_start_line-1, sel_start_col-1, sel_end_line-1, sel_end_col))

    local node_start_row, node_start_col, node_end_row, node_end_col = node:range()

    if (sel_start_line-1) == node_start_row and (sel_start_col-1) == node_start_col
      and (sel_end_line-1) == node_end_row and sel_end_col == node_end_col then
      return node_range_to_vim(utils.smallest_containing_scope(node:parent() or node))
    else
      return node_range_to_vim(node)
    end
  else
    return node_range_to_vim()
  end
end

return M
