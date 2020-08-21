local api = vim.api

local configs = require'nvim-treesitter.configs'
local ts_utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'
local parsers = require'nvim-treesitter.parsers'

local M = {}

local selections = {}

function M.init_selection()
  local buf = api.nvim_get_current_buf()
  local node = ts_utils.get_node_at_cursor()
  selections[buf] = { [1] = node }
  ts_utils.update_selection(buf, node)
end

-- moves 0-based node position by one character
local function inclusive_pos_to_exclusive(row, col)
  local line = vim.fn.getline(row + 1)

  -- move by one character changes row?
  if #line == col + 1  then
    return row + 1, 0
  else
    return row, col + 1
  end
end

local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow < cerow or (csrow == cerow  and cscol <= cecol) then
    return csrow-1, cscol-1, inclusive_pos_to_exclusive(cerow-1, cecol-1)
  else
    return cerow-1, cecol-1, inclusive_pos_to_exclusive(csrow-1, cscol-1)
  end
end

local function range_matches(node)
  local csrow, cscol, cerow, cecol = visual_selection_range()
  local srow, scol, erow, ecol = node:range()
  return srow == csrow and scol == cscol and erow == cerow and ecol == cecol
end

local function select_incremental(get_parent)
  return function()
    local buf = api.nvim_get_current_buf()
    local nodes = selections[buf]

    -- initialize incremental selection with current selection
    if not nodes or #nodes == 0 or not range_matches(nodes[#nodes]) then
      local csrow, cscol, cerow, cecol = visual_selection_range()
      local root = parsers.get_parser().tree:root()
      local node = root:named_descendant_for_range(csrow, cscol, cerow, cecol)
      ts_utils.update_selection(buf, node)
      if nodes and #nodes > 0 then
        table.insert(selections[buf], node)
      else
        selections[buf] = { [1] = node }
      end
      return
    end

    local node = get_parent(nodes[#nodes])
    if not node then return end

    table.insert(selections[buf], node)
    if node ~= nodes[#nodes] then
      table.insert(nodes, node)
    end

    ts_utils.update_selection(buf, node)
  end
end

M.node_incremental = select_incremental(function(node)
  return node:parent() or node
end)

M.scope_incremental = select_incremental(function(node)
  return locals.containing_scope(node:parent() or node)
end)

function M.node_decremental()
  local buf = api.nvim_get_current_buf()
  local nodes = selections[buf]
  if not nodes or #nodes < 2 then return end

  table.remove(selections[buf])
  local node = nodes[#nodes]
  ts_utils.update_selection(buf, node)
end

function M.attach(bufnr)
  local config = configs.get_module('incremental_selection')
  for funcname, mapping in pairs(config.keymaps) do
    local mode
    if funcname == "init_selection" then
      mode = 'n'
    else
      mode = 'v'
    end
    local cmd = string.format(":lua require'nvim-treesitter.incremental_selection'.%s()<CR>", funcname)
    api.nvim_buf_set_keymap(bufnr, mode, mapping, cmd, { silent = true, noremap = true })
  end
end

function M.detach(bufnr)
  local config = configs.get_module('incremental_selection')
  for f, mapping in pairs(config.keymaps) do
    if f == "init_selection" then
      api.nvim_buf_del_keymap(bufnr, 'n', mapping)
    else
      api.nvim_buf_del_keymap(bufnr, 'v', mapping)
    end
  end
end

return M
