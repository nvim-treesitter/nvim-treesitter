-- Functions to handle locals
-- Locals are a generalization of definition and scopes
-- its the way nvim-treesitter uses to "understand" the code
local api = vim.api

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'

local default_dict = {
  __index = function(table, key)
    local exists = rawget(table, key)
    if not exists then
      table[key] = {}
    end
    return rawget(table, key)
  end
}

local query_cache = {}
setmetatable(query_cache, default_dict)

local M = {}

function M.collect_locals(bufnr, query_kind)
  local locals = {}

  for prepared_match in M.iter_locals(bufnr, nil, query_kind) do
    table.insert(locals, prepared_match)
  end

  return locals
end

local function update_cached_locals(bufnr, changed_tick, query_kind)
  query_cache[query_kind][bufnr] = {tick=changed_tick, cache=( M.collect_locals(bufnr, query_kind) or {} )}
end

-- Iterates matches from a locals query file.
-- @param bufnr the buffer
-- @param root the root node
-- @param query_kind the query file to use
function M.iter_locals(bufnr, root, query_kind)
  query_kind = query_kind or 'locals'

  local lang = parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, "ft"))
  if not lang then return end

  local query = queries.get_query(lang, query_kind)
  if not query then return end

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then return end

  local root = root or parser:parse():root()
  local start_row, _, end_row, _ = root:range()

  return queries.iter_prepared_matches(query, root, bufnr, start_row, end_row)
end

function M.get_locals(bufnr, query_kind)
  query_kind = query_kind or 'locals'

  local bufnr = bufnr or api.nvim_get_current_buf()
  local cached_local = query_cache[query_kind][bufnr]
  if not cached_local or api.nvim_buf_get_changedtick(bufnr) > cached_local.tick then
    update_cached_locals(bufnr,api.nvim_buf_get_changedtick(bufnr), query_kind)
  end

  return query_cache[query_kind][bufnr].cache
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

--- Return all nodes in locals corresponding to a specific capture (like @scope, @reference)
-- Works like M.get_references or M.get_scopes except you can choose the capture
-- Can also be a nested capture like @definition.function to get all nodes defining a function
function M.get_capture_matches(bufnr, capture_string, query_kind)
    if not string.sub(capture_string, 1,2) == '@' then
      print('capture_string must start with "@"')
      return
    end

    --remove leading "@"
    capture_string = string.sub(capture_string, 2)

    local matches = {}
    for _, match in pairs(M.get_locals(bufnr, query_kind)) do
      local insert = utils.get_at_path(match, capture_string)

      if insert then
        table.insert(matches, insert)
      end
    end
    return matches
end

return M
