local api = vim.api
local ts = vim.treesitter

local parsers = require "nvim-treesitter.parsers"
local queries = require'nvim-treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

function M.textobject_at_point(query_string)
  local bufnr = vim.api.nvim_get_current_buf()
  local lang = parsers.get_buf_lang(bufnr)
  if not lang then return end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local matches = {}

  if string.match(query_string, '^@.*') then
    matches = queries.get_capture_matches(bufnr, query_string, 'textobjects')
  else
    local parser = parsers.get_parser(bufnr, lang)
    local root = parser:parse():root()

    local start_row, _, end_row, _ = root:range()

    local query = ts.parse_query(lang, query_string)
    for m in queries.iter_prepared_matches(query, root, bufnr, start_row, end_row) do
      for _, n in pairs(m) do
        if n.node then
          table.insert(matches, n)
        end
      end
    end
  end

  local match_length
  local smallest_range
  local earliest_start

  for _, m in pairs(matches) do
    if m.node and ts_utils.is_in_node_range(m.node, row, col) then
      local length = ts_utils.node_length(m.node)
      if not match_length or length < match_length then
        smallest_range = m
        match_length = length
      end
      -- for nodes with same length take the one with earliest start
      if match_length and length == smallest_range then
        local start = m.start
        if start then
          local _, _, start_byte = m.start.node:start()
          if not earliest_start or start_byte < earliest_start then
            smallest_range = m
            match_length = length
            earliest_start = start_byte
          end
        end
      end
    end
  end

  if smallest_range then
    if smallest_range.start then
      local start_range = {smallest_range.start.node:range()}
      local node_range = {smallest_range.node:range()}
      return bufnr, {start_range[1], start_range[2], node_range[3], node_range[4]}, smallest_range.node
    else
      return bufnr, {smallest_range.node:range()}, smallest_range.node
    end
  end
end

function M.get_adjacent(forward, node, query_string, same_parent, overlapping_range_ok, bufnr)
  local fn = forward and M.next_textobject or M.previous_textobject
  return fn(node,  query_string, same_parent, overlapping_range_ok, bufnr)
end

function M.next_textobject(node, query_string, same_parent, overlapping_range_ok, bufnr)
  local node = node or ts_utils.get_node_at_cursor()
  local bufnr = bufnr or api.nvim_get_current_buf()
  if not node then return end

  local _, _, node_end = node:end_()
  local search_start, _
  if overlapping_range_ok then
    _, _, search_start = node:start()
  else
    _, _, search_start = node:end_()
  end
  local function scoring_function(match)
    if match.node == node then return end
    if not same_parent or node:parent() == match.node:parent() then
      local _, _, start = match.node:start()
      local _, _, end_ = match.node:end_()
      return start > search_start and end_ >= node_end
    end
  end
  local function filter_function(match)
    local _, _, node_start = match.node:start()
    return -node_start
  end

  local next_node = queries.find_best_match(bufnr, query_string, 'textobjects', scoring_function, filter_function)

  return next_node and next_node.node
end

function M.previous_textobject(node, query_string, same_parent, overlapping_range_ok, bufnr)
  local node = node or ts_utils.get_node_at_cursor()
  local bufnr = bufnr or api.nvim_get_current_buf()
  if not node then return end

  local _, _, node_start = node:start()
  local search_end, _
  if overlapping_range_ok then
    _, _, search_end = node:end_()
    search_end = search_end + 1
  else
    _, _, search_end = node:start()
  end

  local function scoring_function(match)
    if not same_parent or node:parent() == match.node:parent() then
      local _, _, end_ = match.node:end_()
      local _, _, start = match.node:start()
      return end_ < search_end and start < node_start
    end
  end

  local function filter_function(match)
    local _, _, node_end = match.node:end_()
    return node_end
  end

  local previous_node = queries.find_best_match(bufnr, query_string, 'textobjects', scoring_function, filter_function)

  return previous_node and previous_node.node
end

return M
