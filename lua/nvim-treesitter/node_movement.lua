local api = vim.api

local configs = require'nvim-treesitter.configs'
local state = require'nvim-treesitter.state'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

local NodeMovementKind = {
  parent_scope = 'parent',
  child_scope = 'child',
  next_scope = 'next',
  previous_scope = 'previous',
}

local get_node_fn = {
  [NodeMovementKind.parent_scope] = function(node, curpos)
    return ts_utils.parent_scope(node, curpos)
  end,
  [NodeMovementKind.child_scope] = function(node, curpos)
    return ts_utils.nested_scope(node, curpos)
  end,
  [NodeMovementKind.next_scope] = function(node)
    return ts_utils.next_scope(node)
  end,
  [NodeMovementKind.previous_scope] = function(node)
    return ts_utils.previous_scope(node)
  end,
}

M.do_node_movement = function(kind)
  local buf = api.nvim_get_current_buf()

  local buf_state = state.get_buf_state(buf)
  if not buf_state then return end

  local current_node = buf_state.current_node
  if not current_node then return end

  local destination_node = get_node_fn[kind](current_node, buf_state.cursor_pos)

  if destination_node then
    local row, col = destination_node:start()
    vim.fn.setpos(".", { buf, row+1, col+1, 0 })
  end
end

function M.parent_scope() M.do_node_movement(NodeMovementKind.parent_scope) end
function M.child_scope() M.do_node_movement(NodeMovementKind.child_scope) end
function M.next_scope() M.do_node_movement(NodeMovementKind.next_scope) end
function M.previous_scope() M.do_node_movement(NodeMovementKind.previous_scope) end

function M.attach(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  local config = configs.get_module('node_movement')
  for funcname, mapping in pairs(config.keymaps) do
    local cmd = string.format(":lua require'nvim-treesitter.node_movement'.%s()<CR>", funcname)
    api.nvim_buf_set_keymap(bufnr, 'n', mapping, cmd, { silent = true })
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = configs.get_module('node_movement')
  for _, mapping in pairs(config.keymaps) do
    api.nvim_buf_del_keymap(buf, 'n', mapping)
  end
end

return M
