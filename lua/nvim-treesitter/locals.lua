-- Functions to handle locals
-- Locals are a generalization of definition and scopes
-- its the way nvim-treesitter uses to "understand" the code

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local ts_utils = require'nvim-treesitter.ts_utils'
local api = vim.api

local M = {}

function M.collect_locals(bufnr)
  return queries.collect_group_results(bufnr, 'locals')
end

-- Iterates matches from a locals query file.
-- @param bufnr the buffer
-- @param root the root node
function M.iter_locals(bufnr, root)
  return queries.iter_group_results(bufnr, 'locals', root)
end

function M.get_locals(bufnr)
  return queries.get_matches(bufnr, 'locals')
end

function M.get_definitions(bufnr)
  local locals = M.get_locals(bufnr)

  local defs = {}

  for _, loc in ipairs(locals) do
    if loc.definition then
      table.insert(defs, loc.definition)
    end
  end

  return defs
end

function M.get_scopes(bufnr)
  local locals = M.get_locals(bufnr)

  local scopes = {}

  for _, loc in ipairs(locals) do
    if loc.scope and loc.scope.node then
      table.insert(scopes, loc.scope.node)
    end
  end

  return scopes
end

function M.get_references(bufnr)
  local locals = M.get_locals(bufnr)

  local refs = {}

  for _, loc in ipairs(locals) do
    if loc.reference and loc.reference.node then
      table.insert(refs, loc.reference.node)
    end
  end

  return refs
end

--- Gets a table with all the scopes containing a node
-- The order is from most specific to least (bottom up)
function M.get_scope_tree(node, bufnr)
  local current_scope = M.containing_scope(node, bufnr, false) or parsers.get_tree_root(bufnr)
  local scopes = {}

  while current_scope do
    table.insert(scopes, current_scope)
    current_scope = current_scope:parent()
      and (M.containing_scope(current_scope:parent(), bufnr, false) or parsers.get_tree_root(bufnr))
      or nil
  end

  return scopes
end

-- Finds the definition node and it's scope node of a node
-- @param node starting node
-- @param bufnr buffer
-- @returns the definition node and the definition nodes scope node
function M.find_definition(node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_text = ts_utils.get_node_text(node, bufnr)[1]
  local scope_tree = M.get_scope_tree(node, bufnr)
  local match
  local last_scope_index

  -- Loop over every definition
  for _, definition in ipairs(M.get_definitions(bufnr)) do
    for _, node_entry in ipairs(M.get_local_nodes(definition)) do
      local def_scope = M.containing_scope(node_entry.node, bufnr, false) or parsers.get_tree_root(bufnr)

      -- Only match definitions that match the text of the node
      -- Look for the most specific definition in the tree
      -- The lower the index, the more specific the definition is
      if ts_utils.get_node_text(node_entry.node, bufnr)[1] == node_text then
	for i, scope_node in ipairs(scope_tree) do
	  -- If we already found a close definition in scope, just skip checking
	  if last_scope_index and i >= last_scope_index then break end
	  if scope_node == def_scope then
	    last_scope_index = i
	    match = node_entry
	  end
	end
      end
    end
  end

  if match and last_scope_index then
    return match.node, scope_tree[last_scope_index], match.kind
  end

  return node, parsers.get_parser(bufnr).tree:root(), nil
end

-- Gets a table of all nodes and their 'kinds' from a locals list
-- @param local_def the local list result
-- @returns a list of node entries
function M.get_local_nodes(local_def)
  local result = {}

  M.recurse_local_nodes(local_def, function(_, node, kind)
    table.insert(result, { node = node, kind = kind })
  end)

  return result
end

-- Recurse locals results until a node is found.
-- The accumulator function is given
-- * The table of the node
-- * The node
-- * The full definition match `@definition.var.something` -> 'var.something'
-- * The last definition match `@definition.var.something` -> 'something'
-- @param The locals result
-- @param The accumulator function
-- @param The full match path to append to
-- @param The last match
function M.recurse_local_nodes(local_def, accumulator, full_match, last_match)
  if local_def.node then
    accumulator(local_def, local_def.node, full_match, last_match)
  else
    for match_key, def in pairs(local_def) do
      M.recurse_local_nodes(
        def,
        accumulator,
        full_match and (full_match..'.'..match_key) or match_key,
        match_key)
    end
  end
end

-- Finds usages of a node in a given scope
-- @param node the node to find usages for
-- @param scope_node the node to look within
-- @returns a list of nodes
function M.find_usages(node, scope_node, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_text = ts_utils.get_node_text(node, bufnr)[1]

  if not node_text or #node_text < 1 then return {} end

  local scope_node = scope_node or parsers.get_parser(bufnr).tree:root()
  local usages = {}

  for match in M.iter_locals(bufnr, scope_node) do
    if match.reference
      and match.reference.node
      and ts_utils.get_node_text(match.reference.node, bufnr)[1] == node_text
    then
      table.insert(usages, match.reference.node)
    end
  end

  return usages
end

function M.containing_scope(node, bufnr, allow_scope)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local allow_scope = allow_scope == nil or allow_scope == true

  local scopes = M.get_scopes(bufnr)
  if not node or not scopes then return end

  local iter_node = node

  while iter_node ~= nil and not vim.tbl_contains(scopes, iter_node) do
    iter_node = iter_node:parent()
  end

  return iter_node or (allow_scope and node or nil)
end

function M.nested_scope(node, cursor_pos)
  local bufnr = api.nvim_get_current_buf()

  local scopes = M.get_scopes(bufnr)
  if not node or not scopes then return end

  local row = cursor_pos.row
  local col = cursor_pos.col
  local scope = M.containing_scope(node)

  for _, child in ipairs(ts_utils.get_named_children(scope)) do
    local row_, col_ = child:start()
    if vim.tbl_contains(scopes, child) and ((row_+1 == row and col_ > col) or row_+1 > row) then
      return child
    end
  end
end

function M.next_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local scopes = M.get_scopes(bufnr)
  if not node or not scopes then return end

  local scope = M.containing_scope(node)

  local parent = scope:parent()
  if not parent then return end

  local is_prev = true
  for _, child in ipairs(ts_utils.get_named_children(parent)) do
    if child == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, child) then
      return child
    end
  end
end

function M.previous_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local scopes = M.get_scopes(bufnr)
  if not node or not scopes then return end

  local scope = M.containing_scope(node)

  local parent = scope:parent()
  if not parent then return end

  local is_prev = true
  local children = ts_utils.get_named_children(parent)
  for i=#children,1,-1 do
    if children[i] == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, children[i]) then
      return children[i]
    end
  end
end

return M
