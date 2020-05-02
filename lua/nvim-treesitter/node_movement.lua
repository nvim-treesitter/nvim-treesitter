local api = vim.api
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'
local M = {}


M.NodeMovementKind = {
  up = 'up',
  down = 'down',
  left = 'left',
  right = 'right',
}

M.current_node = {}

local function node_start_to_vim(node)
  if not node then return end

  local row, col = node:start()

  local mode = api.nvim_get_mode().mode
  print(vim.inspect(mode))
  --if mode == 'v' then
    --local _, current_line, current_col, _ = unpack(vim.fn.getpos("."))
    --local _, sel_start_line, sel_start_col, _ = unpack(vim.fn.getpos("'<"))
    --local _, sel_end_line, sel_end_col, _ = unpack(vim.fn.getpos("'>"))

    --if current_line == sel_start_line and current_col == sel_start_col then
      --sel_start_line = row + 1
      --sel_start_col = col + 1
      --vim.fn.setpos("'<", {row + 1, col + 1})
    --end
    --if current_line == sel_end_line and current_col == sel_end_col then
      --row, col = node:end_()
      --sel_end_line = row + 1
      --sel_end_col = col
      --vim.fn.setpos("'>", {row + 1, col + 1})
    --end
    --local exec_command = string.format(select_range,
      --sel_start_line, sel_start_col,
      --sel_end_line, sel_end_col)

  --api.nvim_exec(exec_command, false)
  --else
    api.nvim_exec('normal gv', false)
    api.nvim_exec('normal o', false)
    api.nvim_win_set_cursor(0, {row + 1, col})
  --end
end

M.do_node_movement = function(kind, move_node)
  local line, col = unpack(api.nvim_win_get_cursor(0))
  local buf = api.nvim_win_get_buf(0)

  local current_node = M.current_node[buf]

  if current_node then
    local node_line, node_col = current_node:start()
    if line-1 ~= node_line or  col-1 ~= node_col then
      current_node = nil
    end
  end
  local destination_node

  if parsers.has_parser() then
    local root = parsers.get_parser():parse():root()
    if not current_node then
      current_node = root:named_descendant_for_range(line-1, col-1, line-1, col)
    end

     --UP
    if kind == M.NodeMovementKind.up then
       destination_node = current_node:parent()
    -- DOWN
    elseif kind == M.NodeMovementKind.down then
      if current_node:named_child_count() > 0 then
        destination_node = current_node:named_child(0)
      else
        local next_node = utils.get_next_node(current_node)
        if next_node and next_node:named_child_count() > 0 then
          destination_node = next_node:named_child(0)
        end
      end
    -- LEFT
    elseif kind == M.NodeMovementKind.left then
      destination_node = utils.get_previous_node(current_node, true, true)
    -- RIGHT
    elseif kind == M.NodeMovementKind.right then
      destination_node = utils.get_next_node(current_node, true, true)
    end
    M.current_node[buf] = destination_node or current_node
  end

  if destination_node then
    node_start_to_vim(destination_node)
    if move_node then
      if kind ~= M.NodeMovementKind.down then
        local _, new_destination_range = utils.swap_nodes(buf, current_node, destination_node)

        local root = parsers.get_parser():parse():root()
        if new_destination_range then
          local new_destination_node = root:named_descendant_for_range(new_destination_range[0],
                                                                       new_destination_range[1],
                                                                       new_destination_range[2],
                                                                       new_destination_range[3])
          M.current_node[buf] = new_destination_node or current_node
        end
      end
    end
  end
end

M.move_up = function() M.do_node_movement(M.NodeMovementKind.up) end
M.move_down = function() M.do_node_movement(M.NodeMovementKind.down) end
M.move_left = function() M.do_node_movement(M.NodeMovementKind.left) end
M.move_right = function() M.do_node_movement(M.NodeMovementKind.right) end

M.node_move_up = function() M.do_node_movement(M.NodeMovementKind.up, true) end
M.node_move_down = function() M.do_node_movement(M.NodeMovementKind.down, true) end
M.node_move_left = function() M.do_node_movement(M.NodeMovementKind.left, true) end
M.node_move_right = function() M.do_node_movement(M.NodeMovementKind.right, true) end

function M.attach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = require'nvim-treesitter.configs'.get_module('node_movement')
  for funcname, mapping in pairs(config.keymaps) do
    api.nvim_buf_set_keymap(buf, 'n', mapping,
      string.format(":lua require'nvim-treesitter.node_movement'.%s()<CR>", funcname), { silent = true })
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = require'nvim-treesitter.configs'.get_module('node_movement')
  for _, mapping in pairs(config.keymaps) do
    api.nvim_buf_del_keymap(buf, 'n', mapping)
  end
end

return M
