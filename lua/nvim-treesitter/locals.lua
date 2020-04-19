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

function M.is_supported(lang)
  return queries.get_query(lang, "locals") ~= nil
end

function M.collect_locals(bufnr)
  local ft = api.nvim_buf_get_option(bufnr, "ft")

  if not ft then return end

  local query = queries.get_query(ft, 'locals')
  local parser = parsers.get_parser(bufnr)

  if not parser then return end

  local root = parser:parse():root()
  local start_row, _, end_row, _ = root:range()

  local locals = {}

  for prepared_match in queries.iter_prepared_matches(query, root, bufnr, start_row, end_row) do
    table.insert(locals, prepared_match)
  end

  return locals
end

function M.on_lines(_, buf, _, firstline, lastline, new_lastline)
  M.locals[buf] = M.collect_locals(buf)
end

function M.get_locals(bufnr)
  return M.locals[bufnr or api.nvim_get_current_buf()] or {}
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
