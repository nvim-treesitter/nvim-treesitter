local api = vim.api
local qutils = require'nvim-treesitter.utils.query'
local ts = vim.treesitter
local locals = require'nvim-treesitter.locals'

local M = {}

local function read_query_files(filenames)
  local contents = {}

  for _,filename in ipairs(filenames) do
    vim.list_extend(contents, vim.fn.readfile(filename))
  end

  return table.concat(contents, '\n')
end

-- Creates a function that checks whether a certain query exists
-- for a specific language.
local function get_query_guard(query)
  return function(lang)
    return M.get_query(lang, query) ~= nil
  end
end

-- Some treesitter grammars extend others.
-- We can use that to import the queries of the base language
M.base_language_map = {
  cpp = {'c'},
  typescript = {'javascript'},
  tsx = {'typescript', 'javascript'},
}

M.query_extensions = {
  javascript = { 'jsx' },
  tsx = {'javascript.jsx'}
}

M.has_locals = get_query_guard('locals')
M.has_highlights = get_query_guard('highlights')

function M.get_query(lang, query_name)
  local query_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', lang, query_name), true)
  local query_string = ''

  if #query_files > 0 then
    query_string = read_query_files(query_files) .. "\n" .. query_string
  end

  for _, base_lang in ipairs(M.base_language_map[lang] or {}) do
    local base_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', base_lang, query_name), true)
    if base_files and #base_files > 0 then
        query_string = read_query_files(base_files) .. "\n" .. query_string
    end
  end

  local extensions = M.query_extensions[lang]
  for _, ext in ipairs(extensions or {}) do
    local l = lang
    local e = ext
    if e:match('%.') ~= nil then
       l = e:match('.*%.'):sub(0, -2)
       e = e:match('%..*'):sub(2, -1)
    end
    local ext_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', l, e), true)
    if ext_files and #ext_files > 0 then
      query_string = read_query_files(ext_files) .. "\n" .. query_string
    end
  end

  if #query_string > 0 then
    return ts.parse_query(lang, query_string)
  end
end

function M.iter_prepared_matches(query, qnode, bufnr, start_row, end_row)
  return qutils.iter_prepared_matches(match_pred, query, qnode, bufnr, start_row, end_row)
end

return M
