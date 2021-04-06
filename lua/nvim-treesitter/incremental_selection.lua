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

--- Get a ts compatible range of the current visual selection.
--
-- The range of ts nodes start with 0 and the ending range is exclusive.
local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

  local start_row, start_col, end_row, end_col

  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    start_row = csrow - 1
    start_col = cscol - 1
    end_row = cerow - 1
    end_col = cecol
  else
    start_row = cerow - 1
    start_col = cecol - 1
    end_row = csrow - 1
    end_col = cscol
  end

  -- The last char in ts is equivalent to the EOF in another line.
  local last_row = vim.fn.line("$")
  local last_col = vim.fn.col({last_row, "$"})
  last_row = last_row - 1
  last_col = last_col - 1
  if end_row == last_row and end_col == last_col then
    end_row = end_row + 1
    end_col = 0
  end

  return start_row, start_col, end_row, end_col
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

    local csrow, cscol, cerow, cecol = visual_selection_range()
    -- Initialize incremental selection with current selection
    if not nodes or #nodes == 0 or not range_matches(nodes[#nodes]) then
      local root = parsers.get_parser():parse()[1]:root()
      local node = root:named_descendant_for_range(csrow, cscol, cerow, cecol)
      ts_utils.update_selection(buf, node)
      if nodes and #nodes > 0 then
        table.insert(selections[buf], node)
      else
        selections[buf] = { [1] = node }
      end
      return
    end

    -- Find a node that changes the current selection.
    local node = nodes[#nodes]
    while true do
      local parent = get_parent(node)
      if not parent or parent == node then
        -- Keep searching in the main tree
        -- TODO: we should search on the parent tree of the current node.
        local root = parsers.get_parser():parse()[1]:root()
        parent = root:named_descendant_for_range(csrow, cscol, cerow, cecol)
        if not parent or parent == node then
          ts_utils.update_selection(buf, node)
          return
        end
      end
      node = parent
      local srow, scol, erow, ecol = node:range()
      local same_range = (
        srow == csrow
        and scol == cscol
        and erow == cerow
        and ecol == cecol
      )
      if not same_range then
        table.insert(selections[buf], node)
        if node ~= nodes[#nodes] then
          table.insert(nodes, node)
        end
        ts_utils.update_selection(buf, node)
        return
      end
    end
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
      mode = 'x'
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
      api.nvim_buf_del_keymap(bufnr, 'x', mapping)
    end
  end
end

return M
