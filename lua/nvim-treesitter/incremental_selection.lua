local api = vim.api

local configs = require'nvim-treesitter.configs'
local ts_utils = require'nvim-treesitter.ts_utils'
local parsers = require'nvim-treesitter.parsers'

local M = {}

local selections = {}

local function update_selection(buf, node)
  local start_row, start_col, end_row, end_col = node:range()

  if end_row == vim.fn.line('$') then
    end_col = #vim.fn.getline('$')
  end

  vim.fn.setpos(".", { buf, start_row+1, start_col+1, 0 })
  vim.fn.nvim_exec("normal v", false)
  vim.fn.setpos(".", { buf, end_row+1, end_col+1, 0 })
end

function M.init_selection()
  local buf = api.nvim_get_current_buf()
  local node = ts_utils.get_node_at_cursor()
  selections[buf] = { [1] = node }
  update_selection(buf, node)
end

local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow < cerow then
    return csrow-1, cscol-1, cerow-1, cecol-1
  else
    return cerow-1, cecol-1, csrow-1, cscol-1
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
      update_selection(buf, node)
      selections[buf] = { [1] = node }
      return
    end

    local node = get_parent(nodes[#nodes])
    if not node then return end

    if node ~= nodes[#nodes] then
      table.insert(nodes, node)
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
  local nodes = selections[buf]
  if not nodes or #nodes < 2 then return end

  table.remove(selections[buf])
  local node = nodes[#nodes]
  update_selection(buf, node)
end

function M.attach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()

  local config = configs.get_module('incremental_selection')
  for funcname, mapping in pairs(config.keymaps) do
    local mode
    if funcname == "init_selection" then
      mode = 'n'
    else
      mode = 'v'
    end
    local cmd = string.format(":lua require'nvim-treesitter.incremental_selection'.%s()<CR>", funcname)
    api.nvim_buf_set_keymap(buf, mode, mapping, cmd, { silent = true })
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
