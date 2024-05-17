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

function M.flatten(t)
  if vim.fn.has "nvim-0.11" == 1 then
    return vim.iter(t):flatten():totable()
  else
    return vim.tbl_flatten(t)
  end
end

return M
