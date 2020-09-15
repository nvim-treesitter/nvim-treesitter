-- Definition based navigation module

local ts_utils = require'nvim-treesitter.ts_utils'
local utils = require'nvim-treesitter.utils'
local locals = require'nvim-treesitter.locals'
local configs = require'nvim-treesitter.configs'
local api = vim.api

local M = {}

function M.goto_definition(bufnr, fallback_function)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_at_point = ts_utils.get_node_at_cursor()

  if not node_at_point then return end

  local definition = locals.find_definition(node_at_point, bufnr)

  if fallback_function and definition.id == node_at_point.id then
    fallback_function()
  else
    ts_utils.goto_node(definition)
  end
end

function M.goto_definition_lsp_fallback(bufnr) M.goto_definition(bufnr, vim.lsp.buf.definition) end

function M.list_definitions(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local definitions = locals.get_definitions(bufnr)

  if #definitions < 1 then return end

  local qf_list = {}

  for _, node in ipairs(definitions) do
    local lnum, col, _ = node.node:start()
    local type = string.upper(node.type:sub(1, 1))
    local text = ts_utils.get_node_text(node.node)[1] or ""
    table.insert(qf_list, {
      bufnr = bufnr,
      lnum = lnum + 1,
      col = col + 1,
      text = text,
      type = type,
    })
  end

  vim.fn.setqflist(qf_list, 'r')
  api.nvim_command('copen')
end

function M.list_definitions_toc(bufnr)
  local winnr = api.nvim_get_current_win()
  local bufnr = api.nvim_win_get_buf(winnr)
  local definitions = locals.get_definitions(bufnr)

  if #definitions < 1 then return end

  local loc_list = {}

  -- Force some types to act like they are parents
  -- instead of neighbors of the next nodes.
  local containers = {
    ['function'] = true,
    ['type'] = true,
    ['method'] = true,
  }
  local parents = {}

  for _, def in ipairs(definitions) do
    -- Get indentation level by putting all parents in a stack.
    -- The length of the stack minus one is the current level of indentation.
    local n = #parents
    for i=1, n do
      local index = n + 1 - i
      local parent_def = parents[index]
      if ts_utils.is_parent(parent_def.node, def.node)
          or (containers[parent_def.type] and ts_utils.is_parent(parent_def.node:parent(), def.node)) then
        break
      else
        parents[index] = nil
      end
    end
    parents[#parents + 1] = def

    local lnum, col, _ = def.node:start()
    local type = string.upper(def.type:sub(1, 1))
    local text = ts_utils.get_node_text(def.node)[1] or ""
    table.insert(loc_list, {
      bufnr = bufnr,
      lnum = lnum + 1,
      col = col + 1,
      text = string.rep('  ', #parents - 1) .. text,
      type = type,
    })
  end

  vim.fn.setloclist(winnr, loc_list, 'r')
  -- The title needs to end with `TOC`,
  -- so Neovim displays it like a TOC instead of an error list.
  vim.fn.setloclist(winnr, {}, 'a', {title = 'Definitions TOC'})
  api.nvim_command('lopen')
end

function M.goto_adjacent_usage(bufnr, delta)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local node_at_point = ts_utils.get_node_at_cursor()
  if not node_at_point then return end

  local def_node, scope = locals.find_definition(node_at_point, bufnr)
  local usages = locals.find_usages(def_node, scope, bufnr)

  local index = utils.index_of(usages, node_at_point)
  if not index then return end

  local target_index = (index + delta + #usages - 1) % #usages + 1
  ts_utils.goto_node(usages[target_index])
end

function M.goto_next_usage(bufnr) return M.goto_adjacent_usage(bufnr, 1) end
function M.goto_previous_usage(bufnr) return M.goto_adjacent_usage(bufnr, -1) end

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
