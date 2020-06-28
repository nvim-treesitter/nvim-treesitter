-- Functions to handle locals
-- Locals are a generalization of definition and scopes
-- its the way nvim-treesitter uses to "understand" the code
local api = vim.api
local ts = vim.treesitter

local parsers = require'nvim-treesitter.parsers'
local qutils = require'nvim-treesitter.utils.query'
local tutils = require'nvim-treesitter.ts_utils'

local M = {
  locals = {}
}

function M.collect_locals(bufnr)
  local lang = parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, "ft"))
  if not lang then return end

  local query = qutils.get_query(lang, 'locals')
  if not query then return end

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then return end

  local root = parser:parse():root()
  local start_row, _, end_row, _ = root:range()

  local locals = {}

  for prepared_match in qutils.iter_prepared_matches(function(_) return true end, query, root, bufnr, start_row, end_row) do
    table.insert(locals, prepared_match)
  end

  return locals
end

local function update_cached_locals(bufnr, changed_tick)
  M.locals[bufnr] = {tick=changed_tick, cache=( M.collect_locals(bufnr) or {} )}
end

function M.get_locals(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local cached_local = M.locals[bufnr]
  if not cached_local or api.nvim_buf_get_changedtick(bufnr) > cached_local.tick then
    update_cached_locals(bufnr,api.nvim_buf_get_changedtick(bufnr))
  end

  return M.locals[bufnr].cache
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

-- Is and is not predicates
function M.is(node, deftype, bufnr)
  for def in M.get_definitions(bufnr) do
    if def[deftype]
      and tutils.get_node_text(def[deftype].node, bufnr) == tutils.get_node_text(node, bufnr)
      then
      return true
    end
  end

  return false
end

-- Some utils
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

return M
