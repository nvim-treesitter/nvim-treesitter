-- Functions to handle locals
-- Locals are a generalization of definition and scopes
-- its the way nvim-treesitter uses to "understand" the code
local api = vim.api
local ts = vim.treesitter
local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'

local M = {
  locals={}
}

function M.collect_locals(bufnr)
  local ft = api.nvim_buf_get_option(bufnr, "ft")
  if not ft then return end

  local query = queries.get_query(ft, 'locals')
  if not query then return end

  local parser = parsers.get_parser(bufnr, ft)
  if not parser then return end

  local root = parser:parse():root()
  local start_row, _, end_row, _ = root:range()

  local locals = {}

  for prepared_match in queries.iter_prepared_matches(query, root, bufnr, start_row, end_row) do
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
  if not cached_local or api.nvim_buf_get_changedtick(bufnr) < cached_local.tick then
    update_cached_locals(bufnr,api.nvim_buf_get_changedtick(bufnr))
  end

  return M.locals[bufnr].cache
end

function M.get_definitions(bufnr)
  local locals = M.get_locals(bufnr)

  local defs = {}

  for _, loc in ipairs(locals) do
    if loc.definition then
      table.insert(defs, {definition=loc.definition, kind=loc.kind})
    end
  end

  return defs
end

function M.get_scopes(bufnr)
  local locals = M.get_locals(bufnr)

  local scopes = {}

  for _, loc in ipairs(locals) do
    if loc.scope then
      table.insert(scopes, loc.scope)
    end
  end

  return scopes
end

function M.get_references(bufnr)
  local locals = M.get_locals(bufnr)

  local refs = {}

  for _, loc in ipairs(locals) do
    if loc.reference then
      table.insert(refs, loc.reference)
    end
  end

  return refs
end

return M
