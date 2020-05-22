local api = vim.api

local state = require'nvim-treesitter.state'
local configs = require'nvim-treesitter.configs'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

local function update_selection(buf, node)
  local start_row, start_col, end_row, end_col = node:range()

  if end_row == vim.fn.line('$') then
    end_col = #vim.fn.getline('$')
  end

  vim.fn.setpos(".", { buf, start_row+1, start_col+1, 0 })
  vim.fn.nvim_exec("normal v", false)
  vim.fn.setpos(".", { buf, end_row+1, end_col+1, 0 })
end

local function select_incremental(get_parent)
  return function()
    local buf = api.nvim_get_current_buf()
    local buf_state = state.get_buf_state(buf)

    local node
    -- initialize incremental selection with current range
    if #buf_state.selection.nodes == 0 then
      local cur_range = buf_state.selection.range
      if not cur_range then
        local _, cursor_row, cursor_col, _ = unpack(vim.fn.getpos("."))
        cur_range = { cursor_row, cursor_col, cursor_row, cursor_col + 1 }
      end

      local root = buf_state.parser.tree:root()
      if not root then return end

      node = root:named_descendant_for_range(cur_range[1]-1, cur_range[2]-1, cur_range[3]-1, cur_range[4]-1)
    else
      node = get_parent(buf_state.selection.nodes[#buf_state.selection.nodes])
    end

    if not node then return end

    if node ~= buf_state.selection.nodes[#buf_state.selection.nodes] then
      state.insert_selection_node(buf, node)
    end

    update_selection(buf, node)
  end
end

M.node_incremental = select_incremental(function(node)
  return node:parent() or node
end)

M.scope_incremental = select_incremental(function(node)
  return ts_utils.containing_scope(node:parent() or node)
end)

function M.node_decremental()
  local buf = api.nvim_get_current_buf()
  local buf_state = state.get_buf_state(buf)

  local nodes = buf_state.selection.nodes
  if #nodes < 2 then return end

  state.pop_selection_node(buf)

  local node = nodes[#nodes]
  update_selection(buf, node)
end

function M.attach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = configs.get_module('incremental_selection')
  for funcname, mapping in pairs(config.keymaps) do

    if funcname == "init_selection" then
      local cmd = ":lua require'nvim-treesitter.incremental_selection'.node_incremental()<CR>"
      api.nvim_buf_set_keymap(buf, 'n', mapping, cmd, { silent = true })
    else
      local cmd = string.format(":lua require'nvim-treesitter.incremental_selection'.%s()<CR>", funcname)
      api.nvim_buf_set_keymap(buf, 'v', mapping, cmd, { silent = true })
    end
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = configs.get_module('incremental_selection')
  for f, mapping in pairs(config.keymaps) do
    if f == "init_selection" then
      api.nvim_buf_del_keymap(buf, 'n', mapping)
    else
      api.nvim_buf_del_keymap(buf, 'v', mapping)
    end
  end
end

return M
