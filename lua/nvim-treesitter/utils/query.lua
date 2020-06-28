local api = vim.api
local fn = vim.fn
local luv = vim.loop
local ts = vim.treesitter

local M = {}

local function read_query_files(filenames)
  local contents = {}

  for _,filename in ipairs(filenames) do
    vim.list_extend(contents, vim.fn.readfile(filename))
  end

  return table.concat(contents, '\n')
end

-- Some treesitter grammars extend others.
-- We can use that to import the queries of the base language
M.base_language_map = {
  cpp = {'c'},
  typescript = {'javascript'},
  tsx = {'typescript', 'javascript'},
}

function M.get_query(lang, query_name)
  local query_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', lang, query_name), true)
  local query_string = ''

  if #query_files > 0 then
    query_string = read_query_files(query_files)..query_string
  end

  for _, base_lang in ipairs(M.base_language_map[lang] or {}) do
    local base_files = api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', base_lang, query_name), true)
    if base_files and #base_files > 0 then
        query_string = read_query_files(base_files)..query_string
    end
  end

  if #query_string > 0 then
    return ts.parse_query(lang, query_string)
  end
end

-- Given a path (i.e. a List(String)) this functions inserts value at path
function M.insert_to_path(object, path, value)
  local curr_obj = object

  for index=1,(#path -1) do
    if curr_obj[path[index]] == nil then
      curr_obj[path[index]] = {}
    end

    curr_obj = curr_obj[path[index]]
  end

  curr_obj[path[#path]] = value
end


function M.iter_prepared_matches(match_func, query, qnode, bufnr, start_row, end_row)
  -- A function that splits  a string on '.'
  local function split(string)
    local t = {}
    for str in string.gmatch(string, "([^.]+)") do
      table.insert(t, str)
    end

    return t
  end


  local matches = query:iter_matches(qnode, bufnr, start_row, end_row)

  local function iter()
    local pattern, match = matches()
    if pattern ~= nil then
      local prepared_match = {}

      -- Extract capture names from each match
      for id, node in pairs(match) do
        local name = query.captures[id] -- name of the capture in the query
        if name ~= nil then
          local path = split(name)
          M.insert_to_path(prepared_match, path, { node=node })
        end
      end

      -- Add some predicates for testing
      local preds = query.info.patterns[pattern]
      if preds then
        for _, pred in pairs(preds) do
          if not match_func(pred) then
            return iter()
          end
        end
      end

      return prepared_match
    end
  end

  return iter
end

return M
