-- Treesitter utils

local api = vim.api
local ts = vim.treesitter

local M = {}

local function read_query_file(fname)
  return table.concat(vim.fn.readfile(fname), '\n')
end

function M.get_query(ft, query_name)
  local query_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', ft, query_name), false)
  if #query_files > 0 then
    return ts.parse_query(ft, read_query_file(query_files[1]))
  end
end

return M
