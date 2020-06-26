local api = vim.api

local locals = require'nvim-treesitter.locals'
local parsers = require'nvim-treesitter.parsers'

local M = {}

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
    local line = api.nvim_buf_get_lines(bufnr, start_row, start_row+1, false)[1]
    -- If line is nil then the line is empty
    return line and { string.sub(line, start_col+1, end_col) } or {}
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

function M.parent_scope(node, cursor_pos)
  local bufnr = api.nvim_get_current_buf()

  local scopes = locals.get_scopes(bufnr)
  if not node or not scopes then return end

  local row = cursor_pos.row
  local col = cursor_pos.col
  local iter_node = node

  while iter_node ~= nil do
    local row_, col_ = iter_node:start()
    if vim.tbl_contains(scopes, iter_node) and (row_+1 ~= row or col_ ~= col) then
      return iter_node
    end
    iter_node = iter_node:parent()
  end
end

function M.containing_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local scopes = locals.get_scopes(bufnr)
  if not node or not scopes then return end

  local iter_node = node

  while iter_node ~= nil and not vim.tbl_contains(scopes, iter_node) do
    iter_node = iter_node:parent()
  end

  return iter_node or node
end

function M.get_named_children(node)
  local nodes = {}
  for i=0,node:named_child_count() - 1,1 do
    nodes[i+1] = node:named_child(i)
  end
  return nodes
end

function M.nested_scope(node, cursor_pos)
  local bufnr = api.nvim_get_current_buf()

  local scopes = locals.get_scopes(bufnr)
  if not node or not scopes then return end

  local row = cursor_pos.row
  local col = cursor_pos.col
  local scope = M.containing_scope(node)

  for _, child in ipairs(M.get_named_children(scope)) do
    local row_, col_ = child:start()
    if vim.tbl_contains(scopes, child) and ((row_+1 == row and col_ > col) or row_+1 > row) then
      return child
    end
  end
end

function M.next_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local scopes = locals.get_scopes(bufnr)
  if not node or not scopes then return end

  local scope = M.containing_scope(node)

  local parent = scope:parent()
  if not parent then return end

  local is_prev = true
  for _, child in ipairs(M.get_named_children(parent)) do
    if child == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, child) then
      return child
    end
  end
end

function M.previous_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local scopes = locals.get_scopes(bufnr)
  if not node or not scopes then return end

  local scope = M.containing_scope(node)

  local parent = scope:parent()
  if not parent then return end

  local is_prev = true
  local children = M.get_named_children(parent)
  for i=#children,1,-1 do
    if children[i] == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, children[i]) then
      return children[i]
    end
  end
end

function M.get_node_at_cursor(winnr)
  local cursor = api.nvim_win_get_cursor(winnr or 0)
  local root = parsers.get_parser().tree:root()
  return root:named_descendant_for_range(cursor[1]-1,cursor[2],cursor[1]-1,cursor[2])
end

-- Finds the definition node and it's scope node of a node
-- @param node starting node
-- @param bufnr buffer
-- @returns the definition node and the definition nodes scope node
function M.find_definition(node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()  
  local node_text = M.get_node_text(node)[1]
  local current_scope = M.containing_scope(node)
  local _, _, node_start = node:start()

  -- If a scope wasn't found then use the root node
  if current_scope == node then
    current_scope = parsers.get_parser(bufnr).tree:root()
  end
  
  while current_scope ~= nil and current_scope ~= node do
    for _, def in ipairs(locals.collect_locals(bufnr, current_scope)) do
      if def.definition then
        for _, def_node in ipairs(M.get_local_nodes(def.definition)) do
          local _, _, def_start = def_node:start()

          if M.get_node_text(def_node)[1] == node_text and def_start < node_start then
            return def_node, current_scope
          end
        end
      end
    end

    current_scope = M.containing_scope(current_scope:parent())
  end

  return nil, nil
end

-- Gets all nodes from a local list result.
-- @param local_def the local list result
-- @returns a list of nodes
function M.get_local_nodes(local_def)
  if local_def.node then
    return { local_def.node }
  else
    local result = {}

    for _, def in pairs(local_def) do
      vim.list_extend(result, M.get_local_nodes(def))
    end

    return result
  end
end

-- Finds usages of a node in a particula scope
-- @param node the node to find usages for
-- @param scope_node the node to look within
-- @returns a list of nodes
function M.find_usages(node, scope_node)
  local usages = {}
  local node_text = M.get_node_text(node)[1]

  if not node_text or #node_text < 1 then return {} end

  for _, def in ipairs(locals.collect_locals(bufnr, scope_node)) do
    if def.reference 
      and def.reference.node 
      and M.get_node_text(def.reference.node)[1] == node_text then
      
      table.insert(usages, def.reference.node)
    end
  end

  return usages
end

return M
