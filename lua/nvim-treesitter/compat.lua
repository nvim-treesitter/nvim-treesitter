-- Shim module to address deprecations across nvim versions
local ts = vim.treesitter
local tsq = ts.query

local M = {}

function M.get_query_files(lang, query_group, is_included)
  return (tsq.get_files or tsq.get_query_files)(lang, query_group, is_included)
end

function M.get_query(lang, query_name)
  return (tsq.get or tsq.get_query)(lang, query_name)
end

function M.parse_query(lang, query)
  return (tsq.parse or tsq.parse_query)(lang, query)
end

function M.get_range(node, source, metadata)
  return (ts.get_range or tsq.get_range)(node, source, metadata)
end

function M.get_node_text(node, bufnr)
  return (ts.get_node_text or tsq.get_node_text)(node, bufnr)
end

function M.require_language(lang, opts)
  return (ts.language.add or ts.language.require_language)(lang, opts)
end

local insert = table.insert
---@param list any[]
---@return table Flattened
local function flatten(list, l)
  -- lua std does not using ipairs
  for i = 1, #l do
    local v = l[i]
    if type(v) == "table" then
      flatten(list, v)
    else
      insert(list, v)
    end
  end
  return list
end

function M.flatten(t)
  return flatten({}, t)
end

return M
