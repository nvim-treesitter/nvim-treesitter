local M = {}

local EMPTY_ITER = function() end

---@class QueryInfo
---@field root TSNode
---@field source integer
---@field start integer
---@field stop integer

---@param bufnr integer
---@param query_name string
---@param root TSNode
---@param root_lang string|nil
---@return Query|nil, QueryInfo|nil
local function prepare_query(bufnr, query_name, root, root_lang)
  local ft = vim.bo[bufnr].filetype
  local buf_lang = vim.treesitter.language.get_lang(ft) or ft
  if not buf_lang then
    return
  end

  local parser = vim.treesitter.get_parser(bufnr, buf_lang)
  if not parser then
    return
  end

  if not root then
    local first_tree = parser:trees()[1]

    if first_tree then
      root = first_tree:root()
    end
  end

  if not root then
    return
  end

  local range = { root:range() }

  if not root_lang then
    local lang_tree = parser:language_for_range(range)

    if lang_tree then
      root_lang = lang_tree:lang()
    end
  end

  if not root_lang then
    return
  end

  local query = vim.treesitter.query.get(root_lang, query_name)
  if not query then
    return
  end

  return query,
    {
      root = root,
      source = bufnr,
      start = range[1],
      -- The end row is exclusive so we need to add 1 to it.
      stop = range[3] + 1,
    }
end

-- Given a path (i.e. a List(String)) this functions inserts value at path
---@param object any
---@param path string[]
---@param value any
function M.insert_to_path(object, path, value)
  local curr_obj = object

  for index = 1, (#path - 1) do
    if curr_obj[path[index]] == nil then
      curr_obj[path[index]] = {}
    end

    curr_obj = curr_obj[path[index]]
  end

  curr_obj[path[#path]] = value
end

---@param query Query
---@param bufnr integer
---@param start_row integer
---@param end_row integer
function M.iter_prepared_matches(query, qnode, bufnr, start_row, end_row)
  -- A function that splits  a string on '.'
  ---@param to_split string
  ---@return string[]
  local function split(to_split)
    local t = {}
    for str in string.gmatch(to_split, '([^.]+)') do
      table.insert(t, str)
    end

    return t
  end

  local matches = query:iter_matches(qnode, bufnr, start_row, end_row)

  local function iterator()
    local pattern, match, metadata = matches()
    if pattern ~= nil then
      local prepared_match = {}

      -- Extract capture names from each match
      for id, node in pairs(match) do
        local name = query.captures[id] -- name of the capture in the query
        if name ~= nil then
          local path = split(name .. '.node')
          M.insert_to_path(prepared_match, path, node)
          local metadata_path = split(name .. '.metadata')
          M.insert_to_path(prepared_match, metadata_path, metadata[id])
        end
      end

      -- Add some predicates for testing
      ---@type string[][] ( TODO: make pred type so this can be pred[])
      local preds = query.info.patterns[pattern]
      if preds then
        for _, pred in pairs(preds) do
          -- functions
          if pred[1] == 'set!' and type(pred[2]) == 'string' then
            M.insert_to_path(prepared_match, split(pred[2]), pred[3])
          end
        end
      end

      return prepared_match
    end
  end
  return iterator
end

---Iterates matches from a query file.
---@param bufnr integer the buffer
---@param query_group string the query file to use
---@param root TSNode the root node
---@param root_lang? string the root node lang, if known
function M.iter_group_results(bufnr, query_group, root, root_lang)
  local query, params = prepare_query(bufnr, query_group, root, root_lang)
  if not query then
    return EMPTY_ITER
  end
  assert(params)

  return M.iter_prepared_matches(query, params.root, params.source, params.start, params.stop)
end

function M.collect_group_results(bufnr, query_group, root, lang)
  local matches = {}

  for prepared_match in M.iter_group_results(bufnr, query_group, root, lang) do
    table.insert(matches, prepared_match)
  end

  return matches
end

return M
