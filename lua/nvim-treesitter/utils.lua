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

return M
