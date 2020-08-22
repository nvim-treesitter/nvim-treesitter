-- Definition based navigation module

local ts_utils = require'nvim-treesitter.ts_utils'
local utils = require'nvim-treesitter.utils'
local locals = require'nvim-treesitter.locals'
local configs = require'nvim-treesitter.configs'
local api = vim.api

local M = {}

function M.goto_definition(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_at_point = ts_utils.get_node_at_cursor()

  utils.set_jump()

  if not node_at_point then return end

  local definition, _ = locals.find_definition(node_at_point, bufnr)
  local start_row, start_col, _ = definition:start()

  api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

function M.list_definitions(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local definitions = locals.get_definitions(bufnr)

  if #definitions < 1 then return end

  local qf_list = {}

  for _, def in ipairs(definitions) do
    locals.recurse_local_nodes(def, function(_, node, _, match)
      local lnum, col, _ = node:start()

      table.insert(qf_list, {
        bufnr = bufnr,
        lnum = lnum + 1,
        col = col + 1,
        text = ts_utils.get_node_text(node)[1] or "",
        kind = match and match:sub(1, 1) or ""
      })
    end)
  end

  vim.fn.setqflist(qf_list, 'r')
  api.nvim_command('copen')
end

function M.attach(bufnr)
  local config = configs.get_module('refactor.navigation')

  for fn_name, mapping in pairs(config.keymaps) do
    local cmd = string.format([[:lua require'nvim-treesitter.refactor.navigation'.%s(%d)<CR>]], fn_name, bufnr)

    api.nvim_buf_set_keymap(bufnr, 'n', mapping, cmd, { silent = true, noremap = true })
  end
end

function M.detach(bufnr)
  local config = configs.get_module('refactor.navigation')

  for _, mapping in pairs(config.keymaps) do
    api.nvim_buf_del_keymap(bufnr, 'n', mapping)
  end
end

return M
