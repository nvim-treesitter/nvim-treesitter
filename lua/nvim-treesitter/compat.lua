-- Shim module to address deprecations across nvim versions
local tsq = vim.treesitter.query

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

return M
