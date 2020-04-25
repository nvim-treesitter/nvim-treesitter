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

function M.iter_prepared_matches(query, qnode, bufnr, start_row, end_row)
  -- A function that splits  a string on '.'
  local function split(string)
    local t = {}
    for str in string.gmatch(string, "([^.]+)") do
      table.insert(t, str)
    end

    return t
  end

  -- Given a path (i.e. a List(String)) this functions inserts value at path
  local function insert_to_path(object, path, value)
    local curr_obj = object

    for index=1,(#path -1) do
      if curr_obj[path[index]] == nil then
        curr_obj[path[index]] = {}
      end

      curr_obj = curr_obj[path[index]]
    end

    curr_obj[path[#path]] = value
  end

  local matches = query:iter_matches(qnode, bufnr, start_row, end_row)

  return function()
    local pattern, match = matches()
    if pattern ~= nil then
      local prepared_match = {}

      -- Extract capture names from each match
      for id, node in pairs(match) do
        local name = query.captures[id] -- name of the capture in the query
        if name ~= nil then
          local path = split(name)
          insert_to_path(prepared_match, path, { node=node })
        end
      end

      -- Add some predicates for testing
      local preds = query.info.patterns[pattern]
      if preds then
        for _, pred in pairs(preds) do
          if pred[1] == "set!" and type(pred[2]) == "string" then
            insert_to_path(prepared_match, split(pred[2]), pred[3])
          end
        end
      end

      return prepared_match
    end
  end
end

return M
