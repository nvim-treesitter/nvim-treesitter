-- Utils collection for nvim-treesitter
local api = vim.api
local parsers = require'nvim-treesitter.parsers'
local locals = require'nvim-treesitter.locals'

local M = {}

--- Gets the smallest expression containing the current cursor position
function M.expression_at_point(bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or api.nvim_buf_get_option(bufnr, 'ft')

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then return end

  local tsroot = parser:parse():root()
  if not tsroot then return end

  local curwin = api.nvim_get_current_win()

  if api.nvim_win_get_buf(curwin) == bufnr then
    local cursor = vim.api.nvim_win_get_cursor(curwin)
    local current_node = tsroot:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
    return current_node
  end
end

--- Gets the actual text content of a node
-- @param node the node to get the text from
-- @param bufnr the buffer containing the node
-- @return list of lines of text of the node
function M.get_node_text(node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  if not node then return {} end

  -- We have to remember that end_col is end-exclusive
  local start_row, start_col, end_row, end_col = node:range()
  if start_row ~= end_row then
    local lines = api.nvim_buf_get_lines(bufnr, start_row, end_row+1, false)
    lines[1] = string.sub(lines[1], start_col+1)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    return lines
  else
    local line = api.nvim_buf_get_lines(bufnr, start_row, start_row+1, true)[1]
    return { string.sub(line, start_col+1, end_col) }
  end
end

--- Determines wether a node is the parent of another
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

function M.string_to_lines(str)
  local t={}
  local line_breaks = 0
  for line in str:gmatch("(.-[\n(\r\n)\r])") do
    table.insert(t, line)
    line_breaks = line_breaks + 1
  end
  if #t == 0 then
    return {str}, 0
  --for line in str:gmatch("[^\n(\r\n)\r]+$") do
    --table.insert(t, line)
  end

  return t, line_breaks
end

function M.node_to_lsp_range(node)
  local start_line, start_col, end_line, end_col = node:range()
  local rtn = {}
  rtn.start = { line = start_line, character = start_col }
  rtn['end'] = { line = end_line, character = end_col }
  return rtn
end

function M.node_to_start_pos(node)
  local line, col = unpack(node:start())
  return { line = line, character = col }
end

function M.node_to_end_pos(node)
  local line, col = unpack(node:end_())
  return { line = line, character = col }
end

function M.replace_node(buf, source, destination)
  local replacement_lines = M.get_node_text(source)
  return M.replace_node_text(buf, destination, replacement_lines)
end

function M.range_lines(lsp_range)
  return lsp_range['end'].line - lsp_range['start'].line
end

--- Replace node text and return new range (LSP range)
-- @param buf         buffer number
-- @param node        node to replace
-- @param new lines   new lines to use
function M.replace_node_text(buf, node, replacement_lines)
  -- apply_text_edits splits at '\n'
  local new_text = table.concat(replacement_lines, '\n')

  local text_edit = { range = M.node_to_lsp_range(node), newText = new_text }
  vim.lsp.util.apply_text_edits({text_edit}, buf)

  local range = text_edit.range

  local end_char = #replacement_lines[#replacement_lines]
  if #replacement_lines == 1 then
    end_char = end_char + range.start.character
  end

  range['end'] = { line = range.start.line + #replacement_lines - 1,
                   character =  end_char }
end


--- Swaps the contents of two nodes returning new ranges (LSP ranges)
-- @param buf           buffer number
-- @param source        first node
-- @param destination   second node
function M.swap_nodes(buf, source, destination)
    local _, _, dst_start = destination:start()
    local _, _, dst_end = destination:end_()
    local _, _, src_start = source:start()
    local _, _, src_end = source:end_()

    if dst_start <= src_start and dst_end >= src_end then
        local src_range = M.replace_node(buf, source, destination)
        return src_range
    end

    local source_text = M.get_node_text(source)
    local destination_text = M.get_node_text(destination)

    local src_range, dst_range

    if dst_end <= src_start then
       src_range = M.replace_node_text(buf, source, destination_text)
       dst_range = M.replace_node_text(buf, destination, source_text)
       return
    elseif src_end <= dst_start then
       dst_range = M.replace_node_text(buf, destination, source_text)
       src_range = M.replace_node_text(buf, source, destination_text)
    end
    return src_range, dst_range
end


--- Get tree sitter node in LSP range
-- root Root of parsed tree
-- lsp_range A LSP range
function M.node_from_lsp_range(root, lsp_range)
  return root:named_descendant_for_range(lsp_range.start.line,
                                         lsp_range.start.character,
                                         lsp_range['end'].line,
                                         lsp_range['end'].character)
end

function M.setup_commands(mod, commands)
  for command_name, def in pairs(commands) do
    local call_fn = string.format("lua require'nvim-treesitter.%s'.commands.%s.run(<f-args>)", mod, command_name)
    local parts = vim.tbl_flatten({
        "command!",
        def.args,
        command_name,
        call_fn,
      })
    api.nvim_command(table.concat(parts, " "))
  end
end

--- Gets the smallest scope which contains @param node
function M.smallest_containing_scope(node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  local root = parsers.get_parser(bufnr):parse():root()
  if not node then return root end

  local scopes = locals.get_scopes(bufnr)
  local current = node
  while current ~= nil and not vim.tbl_contains(scopes, current) do
    current = current:parent()
  end

  return current or root
end

--- Get next node with same parent
-- @param node                 node
-- @param allow_switch_parents allow switching parents if last node
-- @param allow_next_parent    allow next parent if last node and next parent without children
function M.get_next_node(node, allow_switch_parents, allow_next_parent)
  local destination_node
  local parent = node:parent()

  if parent then
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
  if parent then
    local found_pos = 0
    for i = 0,parent:named_child_count()-1,1 do
      if parent:named_child(i) == node then
        found_pos = i
        break
      end
    end
    if 0 <= found_pos - 1 then
      destination_node = parent:named_child(found_pos - 1)
    elseif allow_switch_parents then
        local previous_node = M.get_previous_node(node:parent())
        if previous_node and previous_node:named_child_count() > 0 then
          destination_node = previous_node:named_child(previous_node:named_child_count() - 1)
        elseif previous_node and allow_previous_parent then
          destination_node = previous_node
        end
      end
  end
  return destination_node
end

return M
