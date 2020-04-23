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

function M.checkhealth(lang)
  local health_start = vim.fn["health#report_start"]
  local health_ok = vim.fn['health#report_ok']
  local health_info = vim.fn['health#report_info']
  local health_warn = vim.fn['health#report_warn']
  local health_error = vim.fn['health#report_error']

  if not queries.get_query(lang, "locals") then
    health_warn("No `locals.scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`locals.scm` found.")
  end
end

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
    if loc.definition and loc.definition.node then
      table.insert(defs, {node=loc.definition.node, kind=loc.kind})
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

return M
