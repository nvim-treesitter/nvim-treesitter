-- Binds a keybinding to smart rename definitions and usages.
-- Can be used directly using the `smart_rename` function.

local ts_utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'
local configs = require'nvim-treesitter.configs'
local utils = require'nvim-treesitter.utils'
local api = vim.api

local M = {}

function M.smart_rename(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_at_point = ts_utils.get_node_at_cursor()

  if not node_at_point then
    utils.print_warning("No node to rename!")
    return
  end

  local node_text = ts_utils.get_node_text(node_at_point)[1]
  local new_name = vim.fn.input('New name: ', node_text or '')

  -- Empty name cancels the interaction or ESC
  if not new_name or #new_name < 1 then return end

  local definition, scope = locals.find_definition(node_at_point, bufnr)
  local nodes_to_rename = locals.find_usages(definition, scope, bufnr)

  if not vim.tbl_contains(nodes_to_rename, node_at_point) then
    table.insert(nodes_to_rename, node_at_point)
  end

  if not vim.tbl_contains(nodes_to_rename, definition) then
    table.insert(nodes_to_rename, definition)
  end

  local edits = {}

  for _, node in ipairs(nodes_to_rename) do
    local lsp_range = ts_utils.node_to_lsp_range(node)
    local text_edit = { range = lsp_range, newText = new_name }
    table.insert(edits, text_edit)
  end
  vim.lsp.util.apply_text_edits(edits, bufnr)
end

function M.attach(bufnr)
  local config = configs.get_module('refactor.smart_rename')

  for fn_name, mapping in pairs(config.keymaps) do
    local cmd = string.format([[:lua require'nvim-treesitter.refactor.smart_rename'.%s(%d)<CR>]], fn_name, bufnr)
    api.nvim_buf_set_keymap(bufnr, 'n', mapping, cmd, { silent = true, noremap = true })
  end
end

function M.detach(bufnr)
  local config = configs.get_module('refactor.smart_rename')

  for _, mapping in pairs(config.keymaps) do
    api.nvim_buf_del_keymap(bufnr, 'n', mapping)
  end
end

return M
