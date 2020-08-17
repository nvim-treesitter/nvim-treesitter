local configs = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local api = vim.api
local M = {}

function M.make_attach(normal_mode_functions, submodule)
  return function(bufnr, lang)
    local buf = bufnr or api.nvim_get_current_buf()
    local config = configs.get_module("textobjects."..submodule)
    local lang = lang or parsers.get_buf_lang(buf)

    for _, function_call in pairs(normal_mode_functions) do
      for mapping, query in pairs(config[function_call] or {}) do
        if type(query) == 'table' then
          query = query[lang]
        elseif not queries.get_query(lang, 'textobjects') then
          query = nil
        end
        if query then
          local cmd = ":lua require'nvim-treesitter.textobjects."..submodule.."'."..function_call.."('"..query.."')<CR>"
          api.nvim_buf_set_keymap(buf, "n", mapping, cmd, {silent = true, noremap = true })
        end
      end
    end
  end
end

function M.make_detach(normal_mode_functions, submodule)
  return function(bufnr)
    local buf = bufnr or api.nvim_get_current_buf()
    local config = configs.get_module("textobjects."..submodule)
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
end

return M
