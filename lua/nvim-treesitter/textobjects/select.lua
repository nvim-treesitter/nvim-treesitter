local api = vim.api
local configs = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'

local shared = require'nvim-treesitter.textobjects.shared'
local ts_utils = require'nvim-treesitter.ts_utils'

local M = {}

function M.select_textobject(query_string)
  local bufnr, textobject = shared.textobject_at_point(query_string)
  if textobject then
    ts_utils.update_selection(bufnr, textobject)
  end
end

function M.attach(bufnr, lang)
  local buf = bufnr or api.nvim_get_current_buf()
  local config = configs.get_module("textobjects.select")
  local lang = lang or parsers.get_buf_lang(buf)

  for mapping, query in pairs(config.keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      local cmd = ":lua require'nvim-treesitter.textobjects.select'.select_textobject('"..query.."')<CR>"
      api.nvim_buf_set_keymap(buf, "o", mapping, cmd, {silent = true, noremap = true })
      api.nvim_buf_set_keymap(buf, "x", mapping, cmd, {silent = true, noremap = true })
    end
  end
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  local config = configs.get_module("textobjects.select")
  local lang = parsers.get_buf_lang(bufnr)

  for mapping, query in pairs(config.keymaps) do
    if type(query) == 'table' then
      query = query[lang]
    elseif not queries.get_query(lang, 'textobjects') then
      query = nil
    end
    if query then
      api.nvim_buf_del_keymap(buf, "o", mapping)
      api.nvim_buf_del_keymap(buf, "x", mapping)
    end
  end
end

return M
