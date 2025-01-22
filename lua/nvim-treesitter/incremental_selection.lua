local api = vim.api

local configs = require "nvim-treesitter.configs"
local ts_utils = require "nvim-treesitter.ts_utils"
local locals = require "nvim-treesitter.locals"
local parsers = require "nvim-treesitter.parsers"
local queries = require "nvim-treesitter.query"
local utils = require "nvim-treesitter.utils"

local M = {}

---@type table<integer, table<TSNode|nil>>
local selections = {}

function M.init_selection()
  local buf = api.nvim_get_current_buf()
  parsers.get_parser():parse { vim.fn.line "w0" - 1, vim.fn.line "w$" }
  local node = ts_utils.get_node_at_cursor()
  selections[buf] = { [1] = node }
  ts_utils.update_selection(buf, node)
end

-- Get the range of the current visual selection.
--
-- The range starts with 1 and the ending is inclusive.
---@return integer, integer, integer, integer
local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos "v") ---@type integer, integer, integer, integer
  local _, cerow, cecol, _ = unpack(vim.fn.getpos ".") ---@type integer, integer, integer, integer

  local start_row, start_col, end_row, end_col ---@type integer, integer, integer, integer

  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    start_row = csrow
    start_col = cscol
    end_row = cerow
    end_col = cecol
  else
    start_row = cerow
    start_col = cecol
    end_row = csrow
    end_col = cscol
  end

  return start_row, start_col, end_row, end_col
end

---@param node TSNode
---@return boolean
local function range_matches(node)
  local csrow, cscol, cerow, cecol = visual_selection_range()
  local srow, scol, erow, ecol = ts_utils.get_vim_range { node:range() }
  return srow == csrow and scol == cscol and erow == cerow and ecol == cecol
end

---@param get_parent fun(node: TSNode): TSNode|nil
---@return fun():nil
local function select_incremental(get_parent)
  return function()
    local buf = api.nvim_get_current_buf()
    local nodes = selections[buf]

    local csrow, cscol, cerow, cecol = visual_selection_range()
    -- Initialize incremental selection with current selection
    if not nodes or #nodes == 0 or not range_matches(nodes[#nodes]) then
      local parser = parsers.get_parser()
      parser:parse { vim.fn.line "w0" - 1, vim.fn.line "w$" }
      local node = parser:named_node_for_range(
        { csrow - 1, cscol - 1, cerow - 1, cecol },
        { ignore_injections = false }
      )
      ts_utils.update_selection(buf, node)
      if nodes and #nodes > 0 then
        table.insert(selections[buf], node)
      else
        selections[buf] = { [1] = node }
      end
      return
    end

    -- Find a node that changes the current selection.
    local node = nodes[#nodes] ---@type TSNode
    while true do
      local parent = get_parent(node)
      if not parent or parent == node then
        -- Keep searching in the parent tree
        local root_parser = parsers.get_parser()
        root_parser:parse { vim.fn.line "w0" - 1, vim.fn.line "w$" }
        local current_parser = root_parser:language_for_range { csrow - 1, cscol - 1, cerow - 1, cecol }
        if root_parser == current_parser then
          node = root_parser:named_node_for_range { csrow - 1, cscol - 1, cerow - 1, cecol }
          ts_utils.update_selection(buf, node)
          return
        end
        -- NOTE: parent() method is private
        local parent_parser = current_parser:parent()
        parent = parent_parser:named_node_for_range { csrow - 1, cscol - 1, cerow - 1, cecol }
      end
      node = parent
      local srow, scol, erow, ecol = ts_utils.get_vim_range { node:range() }
      local same_range = (srow == csrow and scol == cscol and erow == cerow and ecol == cecol)
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
  local lang = parsers.get_buf_lang()
  if queries.has_locals(lang) then
    return locals.containing_scope(node:parent() or node)
  else
    return node
  end
end)

function M.node_decremental()
  local buf = api.nvim_get_current_buf()
  local nodes = selections[buf]
  if not nodes or #nodes < 2 then
    return
  end

  table.remove(selections[buf])
  local node = nodes[#nodes] ---@type TSNode
  ts_utils.update_selection(buf, node)
end

local FUNCTION_DESCRIPTIONS = {
  init_selection = "Start selecting nodes with nvim-treesitter",
  node_incremental = "Increment selection to named node",
  scope_incremental = "Increment selection to surrounding scope",
  node_decremental = "Shrink selection to previous named node",
}

---@param bufnr integer
function M.attach(bufnr)
  local config = configs.get_module "incremental_selection"
  for funcname, mapping in pairs(config.keymaps) do
    if mapping then
      local mode = funcname == "init_selection" and "n" or "x"
      local rhs = M[funcname] ---@type function

      if not rhs then
        utils.notify("Unknown keybinding: " .. funcname .. debug.traceback(), vim.log.levels.ERROR)
      else
        vim.keymap.set(mode, mapping, rhs, { buffer = bufnr, silent = true, desc = FUNCTION_DESCRIPTIONS[funcname] })
      end
    end
  end
end

function M.detach(bufnr)
  local config = configs.get_module "incremental_selection"
  for f, mapping in pairs(config.keymaps) do
    if mapping then
      local mode = f == "init_selection" and "n" or "x"
      local ok, err = pcall(vim.keymap.del, mode, mapping, { buffer = bufnr })
      if not ok then
        utils.notify(string.format('%s "%s" for mode %s', err, mapping, mode), vim.log.levels.ERROR)
      end
    end
  end
end

return M
