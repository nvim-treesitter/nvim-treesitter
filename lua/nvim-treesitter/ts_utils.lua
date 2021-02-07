local api = vim.api

local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'

local M = {}

--- Gets the actual text content of a node
-- @param node the node to get the text from
-- @param bufnr the buffer containing the node
-- @return list of lines of text of the node
function M.get_node_text(node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  if not node then return {} end

  -- We have to remember that end_col is end-exclusive
  local start_row, start_col, end_row, end_col = M.get_node_range(node)

  if start_row ~= end_row then
    local lines = api.nvim_buf_get_lines(bufnr, start_row, end_row+1, false)
    lines[1] = string.sub(lines[1], start_col+1)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return lines
  else
    local line = api.nvim_buf_get_lines(bufnr, start_row, start_row+1, false)[1]
    -- If line is nil then the line is empty
    return line and { string.sub(line, start_col+1, end_col) } or {}
  end
end

--- Determines whether a node is the parent of another
-- @param dest the possible parent
-- @param source the possible child node
function M.is_parent(dest, source)
  if not (dest and source) then return false end

  local current = source
  while current ~= nil do
    if current == dest then
      return true
    end

    current = current:parent()
  end

  return false
end

--- Get next node with same parent
-- @param node                 node
-- @param allow_switch_parents allow switching parents if last node
-- @param allow_next_parent    allow next parent if last node and next parent without children
function M.get_next_node(node, allow_switch_parents, allow_next_parent)
  local destination_node
  local parent = node:parent()

  if not parent then return end
  local found_pos = 0
  for i = 0,parent:named_child_count()-1,1 do
    if parent:named_child(i) == node then
      found_pos = i
      break
    end
  end
  if parent:named_child_count() > found_pos + 1 then
    destination_node = parent:named_child(found_pos + 1)
  elseif allow_switch_parents then
    local next_node = M.get_next_node(node:parent())
    if next_node and next_node:named_child_count() > 0 then
      destination_node = next_node:named_child(0)
    elseif next_node and allow_next_parent then
      destination_node = next_node
    end
  end

  return destination_node
end

--- Get previous node with same parent
-- @param node                     node
-- @param allow_switch_parents     allow switching parents if first node
-- @param allow_previous_parent    allow previous parent if first node and previous parent without children
function M.get_previous_node(node, allow_switch_parents, allow_previous_parent)
  local destination_node
  local parent = node:parent()
  if not parent then return end

  local found_pos = 0
  for i = 0,parent:named_child_count()-1,1 do
    if parent:named_child(i) == node then
      found_pos = i
      break
    end
  end
  if 0 < found_pos then
    destination_node = parent:named_child(found_pos - 1)
  elseif allow_switch_parents then
    local previous_node = M.get_previous_node(node:parent())
    if previous_node and previous_node:named_child_count() > 0 then
      destination_node = previous_node:named_child(previous_node:named_child_count() - 1)
    elseif previous_node and allow_previous_parent then
      destination_node = previous_node
    end
  end
  return destination_node
end

function M.get_named_children(node)
  local nodes = {}
  for i=0,node:named_child_count() - 1,1 do
    nodes[i+1] = node:named_child(i)
  end
  return nodes
end

function M.get_node_at_cursor(winnr)
  if not parsers.has_parser() then return end
  local cursor = api.nvim_win_get_cursor(winnr or 0)
  local root = parsers.get_parser():parse()[1]:root()
  return root:named_descendant_for_range(cursor[1]-1,cursor[2],cursor[1]-1,cursor[2])
end

function M.highlight_node(node, buf, hl_namespace, hl_group)
  if not node then return end
  M.highlight_range({node:range()}, buf, hl_namespace, hl_group)
end

function M.highlight_range(range, buf, hl_namespace, hl_group)
  local start_row, start_col, end_row, end_col = unpack(range)
  vim.highlight.range(buf, hl_namespace, hl_group, {start_row, start_col}, {end_row, end_col})
end

-- Set visual selection to node
-- @param selection_mode One of "charwise" (default) or "v", "linewise" or "V",
--   "blockwise" or "<C-v>" (as a string with 5 characters or a single character)
function M.update_selection(buf, node, selection_mode)
  selection_mode = selection_mode or "charwise"
  local start_row, start_col, end_row, end_col = M.get_node_range(node)

  if end_row == vim.fn.line('$') then
    end_col = #vim.fn.getline('$')
  end

  -- Convert to 1-based indices
  start_row = start_row + 1
  start_col = start_col + 1
  end_row = end_row + 1
  end_col = end_col + 1

  vim.fn.setpos(".", { buf, start_row, start_col, 0 })

  -- Start visual selection in appropriate mode
  local v_table = {charwise = "v", linewise = "V", blockwise = "<C-v>"}
  ---- Call to `nvim_replace_termcodes()` is needed for sending appropriate
  ---- command to enter blockwise mode
  local mode_string = vim.api.nvim_replace_termcodes(
    v_table[selection_mode] or selection_mode, true, true, true
  )
  vim.cmd("normal! " .. mode_string)

  -- Convert exclusive end position to inclusive
  if end_col == 1 then
    vim.fn.setpos(".", { buf, end_row - 1, -1, 0 })
  else
    vim.fn.setpos(".", { buf, end_row, end_col - 1, 0 })
  end
end

-- Byte length of node range
function M.node_length(node)
  local _, _, start_byte = node:start()
  local _, _, end_byte = node:end_()
  return end_byte - start_byte
end

--- Determines whether (line, col) position is in node range
-- @param node Node defining the range
-- @param line A line (0-based)
-- @param col A column (0-based)
function M.is_in_node_range(node, line, col)
  local start_line, start_col, end_line, end_col = node:range()
  if line >= start_line and line <= end_line then
    if line == start_line and line == end_line then
      return col >= start_col and col < end_col
    elseif line == start_line then
      return col >= start_col
    elseif line == end_line then
      return col < end_col
    else
      return true
    end
  else
    return false
  end
end

function M.get_node_range(node_or_range)
  if type(node_or_range) == 'table' then
    return unpack(node_or_range)
  else
    return node_or_range:range()
  end
end

function M.node_to_lsp_range(node)
  local start_line, start_col, end_line, end_col = M.get_node_range(node)
  local rtn = {}
  rtn.start = { line = start_line, character = start_col }
  rtn['end'] = { line = end_line, character = end_col }
  return rtn
end

--- Memoizes a function based on the buffer tick of the provided bufnr.
-- The cache entry is cleared when the buffer is detached to avoid memory leaks.
-- @param fn: the fn to memoize, taking the bufnr as first argument
-- @returns a memoized function
function M.memoize_by_buf_tick(fn)
  local cache = {}

  return function(bufnr)
    if cache[bufnr] then
      return cache[bufnr]
    else
      cache[bufnr] = {}
      api.nvim_buf_attach(bufnr, false,
        {
          on_changedtick = function() cache[bufnr] = fn(bufnr) end,
          on_detach = function() cache[bufnr] = nil end
        }
      )
    end

    cache[bufnr] = fn(bufnr)
    return cache[bufnr]
  end
end

function M.swap_nodes(node_or_range1, node_or_range2, bufnr, cursor_to_second)
  if not node_or_range1 or not node_or_range2 then return end
  local range1 = M.node_to_lsp_range(node_or_range1)
  local range2 = M.node_to_lsp_range(node_or_range2)

  local text1 = M.get_node_text(node_or_range1)
  local text2 = M.get_node_text(node_or_range2)

  local edit1 = { range = range1, newText = table.concat(text2, '\n') }
  local edit2 = { range = range2, newText = table.concat(text1, '\n') }
  vim.lsp.util.apply_text_edits({edit1, edit2}, bufnr)

  if cursor_to_second then
    utils.set_jump()

    local char_delta = 0
    local line_delta = 0
    if range1["end"].line < range2.start.line
       or (range1["end"].line == range2.start.line and range1["end"].character < range2.start.character) then
      line_delta = #text2 - #text1
    end

    if range1["end"].line == range2.start.line and range1["end"].character < range2.start.character then
      if line_delta ~= 0 then
        --- why?
        --correction_after_line_change =  -range2.start.character
        --text_now_before_range2 = #(text2[#text2])
        --space_between_ranges = range2.start.character - range1["end"].character
        --char_delta = correction_after_line_change + text_now_before_range2 + space_between_ranges
        --- Equivalent to:
        char_delta = #(text2[#text2]) - range1["end"].character

        -- add range1.start.character if last line of range1 (now text2) does not start at 0
        if range1.start.line == range2.start.line + line_delta then
            char_delta = char_delta + range1.start.character
        end
      else
        char_delta = #(text2[#text2]) - #(text1[#text1])
      end
    end

    api.nvim_win_set_cursor(api.nvim_get_current_win(),
                            {range2.start.line + 1 + line_delta,
                             range2.start.character + char_delta})
  end
end

function M.goto_node(node, goto_end, avoid_set_jump)
  if not node then return end
  if not avoid_set_jump then
    utils.set_jump()
  end
  local range = {node:range()}
  local position
  if not goto_end then
    position = { range[1], range[2] }
  else
    -- ranges are exclusive: -1 character!
    if range[4] == 0 then
      position = { range[3] - 1, -1 }
    else
      position = { range[3], range[4] - 1 }
    end
  end
  api.nvim_win_set_cursor(0, { position[1] + 1, position[2] })
end

return M
