local api = vim.api
local tsq = require'vim.treesitter.query'
local tsrange = require'nvim-treesitter.tsrange'
local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local caching = require'nvim-treesitter.caching'

local M = {}

local query_cache = caching.create_buffer_cache()

M.built_in_query_groups = {'highlights', 'locals', 'folds', 'indents'}

-- Creates a function that checks whether a given query exists
-- for a specific language.
local function get_query_guard(query)
  return function(lang)
    return M.has_query_files(lang, query)
  end
end

for _, query in ipairs(M.built_in_query_groups) do
  M["has_" .. query] = get_query_guard(query)
end

local function update_cached_matches(bufnr, changed_tick, query_group)
  query_cache.set(query_group, bufnr, {tick=changed_tick, cache=( M.collect_group_results(bufnr, query_group) or {} )})
end

function M.get_matches(bufnr, query_group)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local cached_local = query_cache.get(query_group, bufnr)
  if not cached_local or api.nvim_buf_get_changedtick(bufnr) > cached_local.tick then
    update_cached_matches(bufnr,api.nvim_buf_get_changedtick(bufnr), query_group)
  end

  return query_cache.get(query_group, bufnr).cache
end

local function runtime_queries(lang, query_name)
  return api.nvim_get_runtime_file(string.format('queries/%s/%s.scm', lang, query_name), true) or {}
end

function M.has_query_files(lang, query_name)
  local files = runtime_queries(lang, query_name)
  return files and #files > 0
end

function M.get_query(lang, query_name)
  return tsq.get_query(lang, query_name)
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

  local function iterator()
    local pattern, match = matches()
    if pattern ~= nil then
      local prepared_match = {}

      -- Extract capture names from each match
      for id, node in pairs(match) do
        local name = query.captures[id] -- name of the capture in the query
        if name ~= nil then
          local path = split(name..'.node')
          insert_to_path(prepared_match, path, node)
        end
      end

      -- Add some predicates for testing
      local preds = query.info.patterns[pattern]
      if preds then
        for _, pred in pairs(preds) do
          -- functions
          if pred[1] == "set!" and type(pred[2]) == "string" then
            insert_to_path(prepared_match, split(pred[2]), pred[3])
          end
          if pred[1] == "make-range!" and type(pred[2]) == "string" and #pred == 4 then
            insert_to_path(prepared_match, split(pred[2]..'.node'),
                           tsrange.TSRange.from_nodes(bufnr, match[pred[3]], match[pred[4]]))
          end
        end
      end

      return prepared_match
    end
  end
  return iterator
end

--- Return all nodes corresponding to a specific capture path (like @definition.var, @reference.type)
-- Works like M.get_references or M.get_scopes except you can choose the capture
-- Can also be a nested capture like @definition.function to get all nodes defining a function
function M.get_capture_matches(bufnr, capture_string, query_group)
    if not string.sub(capture_string, 1,2) == '@' then
      print('capture_string must start with "@"')
      return
    end

    --remove leading "@"
    capture_string = string.sub(capture_string, 2)

    local matches = {}
    for match in M.iter_group_results(bufnr, query_group) do
      local insert = utils.get_at_path(match, capture_string)

      if insert then
        table.insert(matches, insert)
      end
    end
    return matches
end

function M.find_best_match(bufnr, capture_string, query_group, filter_predicate, scoring_function)
    if not string.sub(capture_string, 1,2) == '@' then
      api.nvim_err_writeln('capture_string must start with "@"')
      return
    end

    --remove leading "@"
    capture_string = string.sub(capture_string, 2)

    local best
    local best_score

    for maybe_match in M.iter_group_results(bufnr, query_group) do
      local match = utils.get_at_path(maybe_match, capture_string)

      if match and filter_predicate(match) then
        local current_score = scoring_function(match)
        if not best then
          best = match
          best_score = current_score
        end
        if current_score > best_score then
          best = match
          best_score = current_score
        end
      end
    end
    return best
end

-- Iterates matches from a query file.
-- @param bufnr the buffer
-- @param query_group the query file to use
-- @param root the root node
function M.iter_group_results(bufnr, query_group, root)
  local lang = parsers.get_buf_lang(bufnr)
  if not lang then return function() end end

  local query = M.get_query(lang, query_group)
  if not query then return function() end end

  local parser = parsers.get_parser(bufnr, lang)
  if not parser then return function() end end

  local root = root or parser:parse():root()
  local start_row, _, end_row, _ = root:range()

  -- The end row is exclusive so we need to add 1 to it.
  return M.iter_prepared_matches(query, root, bufnr, start_row, end_row + 1)
end

function M.collect_group_results(bufnr, query_group, root)
  local matches = {}

  for prepared_match in M.iter_group_results(bufnr, query_group, root) do
    table.insert(matches, prepared_match)
  end

  return matches
end

return M
