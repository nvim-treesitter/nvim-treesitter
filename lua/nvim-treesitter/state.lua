local api = vim.api

local utils = require'nvim-treesitter.utils'

local M = {}

local buffers = {}

local g_mode = api.nvim_get_mode().mode

local function get_selection_range()
  local _, vstart_row, vstart_col, _ = unpack(vim.fn.getpos("v"))
  local _, cursor_row, cursor_col, _ = unpack(vim.fn.getpos("."))
  if vstart_row < cursor_row then
    return vstart_row, vstart_col, cursor_row, cursor_col
  else
    return cursor_row, cursor_col, vstart_row, vstart_col
  end
end

function M.update()
  local bufnr = api.nvim_get_current_buf()
  local buf_config = buffers[bufnr]
  if not buf_config then return end

  local mode = api.nvim_get_mode().mode
  local cursor = api.nvim_win_get_cursor(0)
  local row = cursor[1]
  local col = cursor[2]
  if row == buf_config.cursor_pos.row
    and col == buf_config.cursor_pos.col
    and mode == g_mode
    then
    return
  end

  local root = buf_config.parser.tree:root()
  if not root then return end

  local new_node = root:named_descendant_for_range(row - 1, col, row - 1, col)

  if new_node ~= buf_config.current_node then
    buf_config.current_node = new_node
  end

  -- We only want to update the range when the incremental selection has not started yet
  if mode == "v" and #buf_config.selection.nodes == 0 then
    local row_start, col_start, row_end, col_end = get_selection_range()
    buf_config.selection.range = { row_start, col_start, row_end, col_end }
  elseif mode ~= "v" then
    buf_config.selection.nodes = {}
    buf_config.selection.range = nil
  end

  g_mode = mode
  buf_config.cursor_pos.row = row
  buf_config.cursor_pos.col = col
end

function M.insert_selection_node(bufnr, range)
  local buf_config = buffers[bufnr]
  if not buf_config then return end

  table.insert(buffers[bufnr].selection.nodes, range)
end

function M.pop_selection_node(bufnr)
  local buf_config = buffers[bufnr]
  if not buf_config then return end

  table.remove(
    buffers[bufnr].selection.nodes,
    #buffers[bufnr].selection.nodes
    )
end

function M.run_update()
  local cmd = "lua require'nvim-treesitter.state'.update()"
  api.nvim_command('autocmd NvimTreesitter CursorMoved * '..cmd)
end

function M.attach_to_buffer(ft)
  local bufnr = api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(bufnr, 'ft')

  if buffers[bufnr] then return end

  local parser = utils.get_parser(bufnr, ft)
  if not parser then return end

  buffers[bufnr] = {
    cursor_pos = {},
    current_node = nil,
    selection = {
      range = nil,
      nodes = {}
    },
    parser = parser,
  }

  M.update()
  api.nvim_buf_attach(bufnr, false, {
      -- TODO(kyazdani): on lines should only parse the changed content
      -- TODO(kyazdani): add a timer to avoid too frequent updates
      on_lines = function(_, buf) buffers[buf].parser:parse() end,
      on_detach = function(bufnr) buffers[bufnr] = nil end,
    })
end

function M.get_buf_state(bufnr)
  return buffers[bufnr]
end

function M.exposed_state(bufnr)
  local buf_state = buffers[bufnr]
  return {
    cursor_pos = buf_state.cursor_pos,
    current_node = buf_state.current_node
  }
end

return M
