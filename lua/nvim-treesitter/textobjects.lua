local api = vim.api
local ts = vim.treesitter

local configs = require "nvim-treesitter.configs"
local parsers = require "nvim-treesitter.parsers"
local queries = require'nvim-treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

local function textobject_at_point(query_string)
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

function M.select_textobject(query_string)
  local bufnr, textobject = textobject_at_point(query_string)
  if textobject then
    ts_utils.update_selection(bufnr, textobject)
  end
end

local function swap_textobject(query_string, direction)
  local bufnr, textobject_range, node = textobject_at_point(query_string)
  local step = direction > 0 and 1 or -1
  if not node then return end
  local overlapping_range_ok = false
  local same_parent = true
  for _ = 1, math.abs(direction), step do
      if direction > 0 then
        ts_utils.swap_nodes(textobject_range,
                            M.next_textobject(node, query_string, same_parent, overlapping_range_ok, bufnr),
                            bufnr,
                            "yes, set cursor!")
      else
        ts_utils.swap_nodes(textobject_range,
                            M.previous_textobject(node, query_string, same_parent, overlapping_range_ok, bufnr),
                            bufnr,
                            "yes, set cursor!")
      end
  end
end

function M.swap_next(query_string)
  swap_textobject(query_string, 1)
end

function M.swap_previous(query_string)
  swap_textobject(query_string, -1)
end

function M.goto_adjacent(query_string, forward, start, same_parent, overlapping_range_ok)
  local bufnr, _, node = textobject_at_point(query_string)
  local adjacent_textobject
  if forward then
    adjacent_textobject = M.next_textobject(node,  query_string, same_parent, overlapping_range_ok, bufnr)
  else
    adjacent_textobject = M.previous_textobject(node,  query_string, same_parent, overlapping_range_ok, bufnr)
  end

  if adjacent_textobject then
    local adjacent_textobject_range = {adjacent_textobject:range()}
    if start then
      api.nvim_win_set_cursor(api.nvim_get_current_win(),
                              { adjacent_textobject_range[1] + 1, adjacent_textobject_range[2] })
    else
      api.nvim_win_set_cursor(api.nvim_get_current_win(),
                              { adjacent_textobject_range[3] + 1, adjacent_textobject_range[4] })
    end
  end
end

-- luacheck: push ignore 631
M.goto_next_start = function(query_string) M.goto_adjacent(query_string, 'forward', 'start', not 'same_parent', 'overlap ok') end
M.goto_next_end = function(query_string) M.goto_adjacent(query_string, 'forward', not 'start', not 'same_parent', 'overlap ok') end
M.goto_previous_start = function(query_string) M.goto_adjacent(query_string, not 'forward', 'start', not 'same_parent', 'overlap ok') end
M.goto_previous_end = function(query_string) M.goto_adjacent(query_string, not 'forward', not 'start', not 'same_parent', 'overlap ok') end
-- luacheck: pop

function M.next_textobject(node, query_string, same_parent, overlapping_range_ok, bufnr)
  local node = node or ts_utils.get_node_at_cursor()
  local bufnr = bufnr or api.nvim_get_current_buf()
  if not node then return end

  local _, _, node_end = node:end_()
  local search_start, _
  if overlapping_range_ok then
    _, _, search_start = node:start()
    search_start = search_start - 1
  else
    _, _, search_start = node:end_()
  end

  local next_node = queries.find_best_match(bufnr,
                                            query_string,
                                            'textobjects',
                                            function(match)
                                              if match.node == node then return end
                                              if not same_parent or node:parent() == match.node:parent() then
                                                local _, _, start = match.node:start()
                                                local _, _, end_ = match.node:end_()
                                                return start > search_start and end_ > node_end
                                              end
                                            end,
                                            function(match)
                                              local _, _, node_start = match.node:start()
                                              return -node_start
                                            end)

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
  local previous_node = queries.find_best_match(bufnr,
                                                query_string,
                                                'textobjects',
                                                function(match)
                                                  if not same_parent or node:parent() == match.node:parent() then
                                                    local _, _, end_ = match.node:end_()
                                                    local _, _, start = match.node:start()
                                                    return end_ < search_end and start < node_start
                                                  end
                                                end,
                                                function(match)
                                                  local _, _, node_end = match.node:end_()
                                                  return node_end
                                                end)

  return previous_node and previous_node.node
end

local normal_mode_functions = { "swap_next",
                                "swap_previous",
                                "goto_next_start",
                                "goto_next_end",
                                "goto_previous_start",
                                "goto_previous_end"}

function M.attach(bufnr, lang)
  local buf = bufnr or api.nvim_get_current_buf()
  local config = configs.get_module("textobjects")
  local lang = lang or parsers.get_buf_lang(buf)

  for mapping, query in pairs(config.keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      local cmd = ":lua require'nvim-treesitter.textobjects'.select_textobject('"..query.."')<CR>"
      api.nvim_buf_set_keymap(buf, "o", mapping, cmd, {silent = true, noremap = true })
      api.nvim_buf_set_keymap(buf, "v", mapping, cmd, {silent = true, noremap = true })
    end
  end
  for _, function_call in pairs(normal_mode_functions) do
    for mapping, query in pairs(config[function_call] or {}) do
      if type(query) == 'table' then
        query = query[lang]
      elseif not queries.get_query(lang, 'textobjects') then
        query = nil
      end
      if query then
        local cmd = ":lua require'nvim-treesitter.textobjects'."..function_call.."('"..query.."')<CR>"
        api.nvim_buf_set_keymap(buf, "n", mapping, cmd, {silent = true, noremap = true })
      end
    end
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  local config = configs.get_module("textobjects")
  local lang = parsers.get_buf_lang(bufnr)

  for mapping, query in pairs(config.keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      api.nvim_buf_del_keymap(buf, "o", mapping)
      api.nvim_buf_del_keymap(buf, "v", mapping)
    end
  end
  for _, function_call in pairs(normal_mode_functions) do
    for mapping, query in pairs(config[function_call] or {}) do
      if type(query) == 'table' then
        query = query[lang]
      elseif not queries.get_query(lang, 'textobjects') then
        query = nil
      end
      if query then
        api.nvim_buf_del_keymap(buf, "n", mapping)
      end
    end
  end
end

return M
