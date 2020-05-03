local api = vim.api
local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local M = {}

local function select_incremental(increment_func)
  return function()
    local buf, sel_start_line, sel_start_col, _ = unpack(vim.fn.getpos("'<"))
    local buf, sel_end_line, sel_end_col, _ = unpack(vim.fn.getpos("'>"))

    local node = nil
    if parsers.has_parser() then
      local root = parsers.get_parser():parse():root()
      node = root:named_descendant_for_range(sel_start_line-1, sel_start_col-1, sel_end_line-1, sel_end_col)
      local node_start_row, node_start_col, node_end_row, node_end_col = node:range()

      if (sel_start_line-1) == node_start_row and (sel_start_col-1) == node_start_col
        and (sel_end_line-1) == node_end_row and sel_end_col == node_end_col then
        node = increment_func(node)
      end
    end

    return utils.node_range_to_vim(node)
  end
end

M.node_incremental = select_incremental(function(node)
  if node then
    return node:parent() or node
  end
end)

M.scope_incremental = select_incremental(function(node)
  if node then
    return utils.smallest_containing_scope(node:parent() or node)
  end
end)

function M.attach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = require'nvim-treesitter.configs'.get_module('incremental_selection')
  for funcname, mapping in pairs(config.keymaps) do
    api.nvim_buf_set_keymap(buf, 'v', mapping,
      string.format(":lua require'nvim-treesitter.incremental_selection'.%s()<CR>", funcname), { silent = true })
    api.nvim_buf_set_keymap(buf, 'o', mapping,
      string.format(":normal v%s<CR>", mapping), { silent = true })
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = require'nvim-treesitter.configs'.get_module('incremental_selection')
  for _, mapping in pairs(config.keymaps) do
    api.nvim_buf_del_keymap(buf, 'v', mapping)
    api.nvim_buf_del_keymap(buf, 'o', mapping)
  end
end

return M
