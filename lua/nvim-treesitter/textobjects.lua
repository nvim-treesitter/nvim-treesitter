local api = vim.api
local ts = vim.treesitter

local configs = require "nvim-treesitter.configs"
local parsers = require "nvim-treesitter.parsers"
local queries = require'nvim-treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

function M.select_textobject(query_string)
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
      ts_utils.update_selection(bufnr, {start_range[1], start_range[2], node_range[3], node_range[4]})
    else
      ts_utils.update_selection(bufnr, smallest_range.node)
    end
  end
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
      api.nvim_buf_set_keymap(buf, "o", mapping, cmd, {silent = true})
      api.nvim_buf_set_keymap(buf, "v", mapping, cmd, {silent = true})
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
end

return M
