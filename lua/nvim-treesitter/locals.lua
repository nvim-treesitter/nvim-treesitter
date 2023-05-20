-- Functions to handle locals
-- Locals are a generalization of definition and scopes
-- it's the way nvim-treesitter uses to "understand" the code

local api = vim.api
local ts = vim.treesitter

local M = {}

local function get_named_children(node)
  local nodes = {} ---@type TSNode[]
  for i = 0, node:named_child_count() - 1, 1 do
    nodes[i + 1] = node:named_child(i)
  end
  return nodes
end

---@param node TSNode
---@return TSNode result
local function get_root_for_node(node)
  local parent = node
  local result = node

  while parent ~= nil do
    result = parent
    parent = result:parent()
  end

  return result
end

-- Creates unique id for a node based on text and range
---@param scope TSNode: the scope node of the definition
---@param node_text string: the node text to use
---@return string: a string id
function M.get_definition_id(scope, node_text)
  -- Add a valid starting character in case node text doesn't start with a valid one.
  return table.concat({ 'k', node_text or '', scope:range() }, '_')
end

-- Gets a table with all the scopes containing a node
-- The order is from most specific to least (bottom up)
---@param node TSNode
---@param bufnr integer
---@return TSNode[]
function M.get_scope_tree(node, bufnr)
  local scopes = {} ---@type TSNode[]

  for scope in M.iter_scope_tree(node, bufnr) do
    table.insert(scopes, scope)
  end

  return scopes
end

-- Iterates over a nodes scopes moving from the bottom up
---@param node TSNode
---@param bufnr integer
---@return fun(): TSNode|nil
function M.iter_scope_tree(node, bufnr)
  local last_node = node
  return function()
    if not last_node then
      return
    end

    local scope = M.containing_scope(last_node, bufnr, false) or get_root_for_node(node)

    last_node = scope:parent()

    return scope
  end
end

-- Gets a table of all nodes and their 'kinds' from a locals list
---@param local_def TSLocal[] the local list result
---@return TSLocal[] a list of node entries
function M.get_local_nodes(local_def)
  local result = {}

  M.recurse_local_nodes(local_def, function(def, _, kind)
    table.insert(result, vim.tbl_extend('keep', { kind = kind }, def))
  end)

  return result
end

-- Recurse locals results until a node is found.
-- The accumulator function is given
-- * The table of the node
-- * The node
-- * The full definition match `@local.definition.var.something` -> 'var.something'
-- * The last definition match `@local.definition.var.something` -> 'something'
---@param local_def TSLocal The locals result
---@param accumulator function The accumulator function
---@param full_match? string The full match path to append to
---@param last_match? string The last match
function M.recurse_local_nodes(local_def, accumulator, full_match, last_match)
  if type(local_def) ~= 'table' then
    return
  end

  if local_def.node then
    accumulator(local_def, local_def.node, full_match, last_match)
  else
    for match_key, def in pairs(local_def) do
      M.recurse_local_nodes(
        def,
        accumulator,
        full_match and (full_match .. '.' .. match_key) or match_key,
        match_key
      )
    end
  end
end

---Memoize a function using hash_fn to hash the arguments.
---@generic F: function
---@param fn F
---@param hash_fn fun(...): any
---@return F
local function memoize(fn, hash_fn)
  local cache = setmetatable({}, { __mode = 'kv' }) ---@type table<any,any>

  return function(...)
    local key = hash_fn(...)
    if cache[key] == nil then
      local v = { fn(...) } ---@type any

      for k, value in pairs(v) do
        if value == nil then
          value[k] = vim.NIL
        end
      end

      cache[key] = v
    end

    local v = cache[key]

    for k, value in pairs(v) do
      if value == vim.NIL then
        value[k] = nil
      end
    end

    return unpack(v)
  end
end
---@param bufnr integer: the buffer
---@return TSNode|nil root: root node of the buffer
local function get_root(bufnr)
  local parser = assert(ts.get_parser(bufnr))
  if not parser then
    return
  end
  parser:parse()
  return parser:trees()[1]:root()
end

---@param bufnr integer: the buffer
---@return Query|nil query: `locals` query
---@return TSNode|nil root: root node of the bufferocal function get_query(bufnr)
local function get_query(bufnr)
  local root = get_root(bufnr)

  local ft = vim.bo[bufnr].filetype
  local lang = ts.language.get_lang(ft) or ft

  local query = (ts.query.get(lang, 'locals'))

  return query, root
end

---@alias TSScope "parent"|"local"|"global"

---@class TSLocal
---@field kind string
---@field node TSNode
---@field scope TSScope

-- Return all locals for the buffer
--
-- memoized by buffer tick
--
---@param bufnr integer buffer
---@return TSLocal[] definitions
---@return TSLocal[] references
---@return TSNode[] scopes
M.get = memoize(function(bufnr)
  local query, root = get_query(bufnr)
  if not query or not root then
    return {}, {}, {}
  end

  local definitions = {}
  local scopes = {}
  local references = {}
  for id, node, metadata in query:iter_captures(root, bufnr) do
    local kind = query.captures[id]

    local scope = 'local' ---@type string
    for k, v in pairs(metadata) do
      if type(k) == 'string' and vim.endswith(k, 'local.scope') then
        scope = v
      end
    end

    if node and vim.startswith(kind, 'local.definition') then
      table.insert(definitions, { kind = kind, node = node, scope = scope })
    end

    if node and kind == 'local.scope' then
      table.insert(scopes, node)
    end

    if node and kind == 'local.reference' then
      table.insert(references, { kind = kind, node = node, scope = scope })
    end
  end

  return definitions, references, scopes
end, function(bufnr)
  local root = get_root(bufnr)
  if not root then
    return tostring(bufnr)
  end
  return tostring(root:id())
end)

-- Get a single dimension table to look definition nodes.
-- Keys are generated by using the range of the containing scope and the text of the definition node.
-- This makes looking up a definition for a given scope a simple key lookup.
--
-- This is memoized by buffer tick. If the function is called in succession
-- without the buffer tick changing, then the previous result will be used
-- since the syntax tree hasn't changed.
--
-- Usage lookups require finding the definition of the node, so `find_definition`
-- is called very frequently, which is why this lookup must be fast as possible.
--
---@param bufnr integer: the buffer
---@return TSLocal[] result: a table for looking up definitions
M.get_definitions_lookup_table = memoize(function(bufnr)
  local definitions, _, _ = M.get(bufnr)
  if not definitions then
    return {}
  end

  local result = {}
  for _, definition in ipairs(definitions) do
    for _, node_entry in ipairs(M.get_local_nodes(definition)) do
      local scopes = M.get_definition_scopes(node_entry.node, bufnr, node_entry.scope)
      -- Always use the highest valid scope
      local scope = scopes[#scopes]
      local node_text = ts.get_node_text(node_entry.node, bufnr)
      local id = M.get_definition_id(scope, node_text)

      result[id] = node_entry
    end
  end

  return result
end, function(bufnr)
  local root = get_root(bufnr)
  if not root then
    return tostring(bufnr)
  end
  return tostring(root:id())
end)

-- Gets all the scopes of a definition based on the scope type
-- Scope types can be
--
-- "parent": Uses the parent of the containing scope, basically, skipping a scope
-- "global": Uses the top most scope
-- "local": Uses the containing scope of the definition. This is the default
--
---@param node TSNode: the definition node
---@param bufnr integer: the buffer
---@param scope_type TSScope: the scope type
function M.get_definition_scopes(node, bufnr, scope_type)
  local scopes = {}
  local scope_count = 1 ---@type integer|nil

  -- Definition is valid for the containing scope
  -- and the containing scope of that scope
  if scope_type == 'parent' then
    scope_count = 2
    -- Definition is valid in all parent scopes
  elseif scope_type == 'global' then
    scope_count = nil
  end

  local i = 0
  for scope_node in M.iter_scope_tree(node, bufnr) do
    table.insert(scopes, scope_node)
    i = i + 1

    if scope_count and i >= scope_count then
      break
    end
  end

  return scopes
end

---@param node TSNode
---@param bufnr integer
---@return TSNode node
---@return TSNode scope
---@return string|nil kind
function M.find_definition(node, bufnr)
  local def_lookup = M.get_definitions_lookup_table(bufnr)
  local node_text = ts.get_node_text(node, bufnr)

  for scope in M.iter_scope_tree(node, bufnr) do
    local id = M.get_definition_id(scope, node_text)

    if def_lookup[id] then
      local entry = def_lookup[id]

      return entry.node, scope, entry.kind
    end
  end

  return node, get_root_for_node(node), nil
end

-- Finds usages of a node in a given scope.
---@param node TSNode the node to find usages for
---@param scope_node TSNode|nil the node to look within
---@param bufnr integer|nil the bufnr to look into
---@return TSNode[]: a list of nodes
function M.find_usages(node, scope_node, bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  local node_text = ts.get_node_text(node, bufnr)

  if not node_text or #node_text < 1 then
    return {}
  end

  scope_node = scope_node or get_root_for_node(node)
  local usages = {}

  local query, _ = get_query(bufnr)
  if not query then
    return {}
  end

  for id, node_capture in query:iter_captures(scope_node, bufnr) do
    local kind = query.captures[id]
    if
      node_capture
      and kind == 'local.reference'
      and ts.get_node_text(node_capture, bufnr) == node_text
    then
      table.insert(usages, node_capture)
    end
  end

  return usages
end

---@param node TSNode
---@param bufnr? integer
---@param allow_scope? boolean
---@return TSNode|nil
function M.containing_scope(node, bufnr, allow_scope)
  bufnr = bufnr or api.nvim_get_current_buf()
  allow_scope = allow_scope == nil or allow_scope == true

  local _, _, scopes = M.get(bufnr)
  if not node or not scopes then
    return
  end

  local iter_node = node

  while iter_node ~= nil and not vim.tbl_contains(scopes, iter_node) do
    iter_node = iter_node:parent()
  end

  return iter_node or (allow_scope and node or nil)
end

function M.nested_scope(node, cursor_pos)
  local bufnr = api.nvim_get_current_buf()

  local _, _, scopes = M.get(bufnr)
  if not node or not scopes then
    return
  end

  local row = cursor_pos.row ---@type integer
  local col = cursor_pos.col ---@type integer
  local scope = M.containing_scope(node)

  for _, child in ipairs(get_named_children(scope)) do
    local row_, col_ = child:start()
    if vim.tbl_contains(scopes, child) and ((row_ + 1 == row and col_ > col) or row_ + 1 > row) then
      return child
    end
  end
end

function M.next_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local _, _, scopes = M.get(bufnr)
  if not node or not scopes then
    return
  end

  local scope = M.containing_scope(node)
  if not scope then
    return
  end

  local parent = scope:parent()
  if not parent then
    return
  end

  local is_prev = true
  for _, child in ipairs(get_named_children(parent)) do
    if child == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, child) then
      return child
    end
  end
end

---@param node TSNode
---@return TSNode|nil
function M.previous_scope(node)
  local bufnr = api.nvim_get_current_buf()

  local _, _, scopes = M.get(bufnr)
  if not node or not scopes then
    return
  end

  local scope = M.containing_scope(node)
  if not scope then
    return
  end

  local parent = scope:parent()
  if not parent then
    return
  end

  local is_prev = true
  local children = get_named_children(parent)
  for i = #children, 1, -1 do
    if children[i] == scope then
      is_prev = false
    elseif not is_prev and vim.tbl_contains(scopes, children[i]) then
      return children[i]
    end
  end
end

return M
