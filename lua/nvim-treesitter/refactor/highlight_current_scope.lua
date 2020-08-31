-- This module highlights the current scope of at the cursor position

local ts_utils = require'nvim-treesitter.ts_utils'
local locals = require'nvim-treesitter.locals'
local api = vim.api
local cmd = api.nvim_command

local M = {}

local current_scope_namespace = api.nvim_create_namespace('nvim-treesitter-current-scope')

function M.highlight_current_scope(bufnr)
  M.clear_highlights(bufnr)

  local node_at_point = ts_utils.get_node_at_cursor()
  local current_scope = locals.containing_scope(node_at_point, bufnr)

  local start_line = current_scope:start()

  if current_scope and start_line ~= 0 then
    ts_utils.highlight_node(current_scope, bufnr, current_scope_namespace, 'TSCurrentScope')
  end
end

function M.clear_highlights(bufnr)
  api.nvim_buf_clear_namespace(bufnr, current_scope_namespace, 0, -1)
end

function M.attach(bufnr)
  cmd(string.format('augroup NvimTreesitterCurrentScope_%d', bufnr))
  cmd 'au!'
  -- luacheck: push ignore 631
  cmd(string.format([[autocmd CursorMoved <buffer=%d> lua require'nvim-treesitter.refactor.highlight_current_scope'.highlight_current_scope(%d)]], bufnr, bufnr))
  cmd(string.format([[autocmd BufLeave <buffer=%d> lua require'nvim-treesitter.refactor.highlight_current_scope'.clear_highlights(%d)]], bufnr, bufnr))
  -- luacheck: pop
  cmd 'augroup END'
end

function M.detach(bufnr)
  M.clear_highlights(bufnr)
  cmd(string.format('autocmd! NvimTreesitterCurrentScope_%d CursorMoved', bufnr))
  cmd(string.format('autocmd! NvimTreesitterCurrentScope_%d BufLeave', bufnr))
end

return M
