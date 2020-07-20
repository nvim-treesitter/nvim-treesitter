local api = vim.api
local ts = vim.treesitter

local configs = require "nvim-treesitter.configs"
local parsers = require "nvim-treesitter.parsers"
local queries = require'nvim-treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

local function get_textobject_at_point(query_string)
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
  local bufnr, textobject = get_textobject_at_point(query_string)
  if textobject then
    ts_utils.update_selection(bufnr, textobject)
  end
end

local function swap_textobject(query_string, direction)
  local bufnr, textobject_range, node = get_textobject_at_point(query_string)
  local step = direction > 0 and 1 or -1
  if not node then return end
  for _ = 1, math.abs(direction), step do
      if direction > 0 then
        ts_utils.swap_nodes(textobject_range, M.next_textobject(node, query_string, true, bufnr), bufnr, "yes, set cursor!")
      else
        ts_utils.swap_nodes(textobject_range, M.previous_textobject(node, query_string, true, bufnr), bufnr, "yes, set cursor!")
      end
  end
end

function M.swap_textobject_next(query_string)
  swap_textobject(query_string, 1)
end

function M.swap_textobject_previous(query_string)
  swap_textobject(query_string, -1)
end

function M.next_textobject(node, query_string, same_parent, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  local matches = queries.get_capture_matches(bufnr, query_string, 'textobjects')
  local _, _ , node_end = node:end_()
  local next_node
  local next_node_start

  for _, m in pairs(matches) do
    local _, _, other_end = m.node:start()
    if other_end > node_end then
      if not same_parent or node:parent() == m.node:parent() then
        if not next_node then
          next_node = m
          _, _, next_node_start = next_node.node:start()
        end
        if other_end < next_node_start then
          next_node = m
          _, _, next_node_start = next_node.node:start()
        end
      end
    end
  end

  return next_node and next_node.node
end

function M.previous_textobject(node, query_string, same_parent, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  local matches = queries.get_capture_matches(bufnr, query_string, 'textobjects')
  local _, _ , node_start = node:start()
  local previous_node
  local previous_node_end

  for _, m in pairs(matches) do
    local _, _, other_end = m.node:end_()
    if other_end < node_start then
      if not same_parent or node:parent() == m.node:parent() then
        if not previous_node then
          previous_node = m
          _, _, previous_node_end = previous_node.node:end_()
        end
        if other_end > previous_node_end then
          previous_node = m
          _, _, previous_node_end = previous_node.node:end_()
        end
      end
    end
  end

  return previous_node and previous_node.node
end

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
  for mapping, query in pairs(config.swap_next_keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      local cmd = ":lua require'nvim-treesitter.textobjects'.swap_textobject_next('"..query.."')<CR>"
      api.nvim_buf_set_keymap(buf, "n", mapping, cmd, {silent = true})
    end
  end
  for mapping, query in pairs(config.swap_previous_keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      local cmd = ":lua require'nvim-treesitter.textobjects'.swap_textobject_previous('"..query.."')<CR>"
      api.nvim_buf_set_keymap(buf, "n", mapping, cmd, {silent = true})
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
  for mapping, query in pairs(config.swap_next_keymaps) or pairs(config.swap_previous_keymaps) do
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

return M
