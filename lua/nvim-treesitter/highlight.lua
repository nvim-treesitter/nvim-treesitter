local api = vim.api
local ts = vim.treesitter
local queries = require'nvim-treesitter.query'
local utils = require'nvim-treesitter.utils'
local configs = require'nvim-treesitter.configs'

local M = {
  highlighters = {},
  registered_autocmd = {}
}

local function detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  if not M.highlighters[buf] then return end

  M.highlighters[buf]:set_query("")
  M.highlighters[buf] = nil
  api.nvim_buf_set_option(buf, 'syntax', 'on')
end

local function disable_hl()
  for _, ft in pairs(configs.available_parsers()) do 
    if M.registered_autocmd[ft] then
      api.nvim_command(string.format("autocmd! NvimTreesitter FileType %s", ft))
      M.registered_autocmd[ft] = nil
    end
  end
  for _, buf in pairs(api.nvim_list_bufs()) do
    detach(buf)
  end
end

function M.attach(bufnr, ft)
  local buf = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(buf, 'ft')

  local query = queries.get_query(ft, "highlights")
  if not query then return end

  M.highlighters[buf] = ts.TSHighlighter.new(query, buf, ft)
end

local function enable_hl()
  M.setup()
  for _, buf in pairs(api.nvim_list_bufs()) do
    M.attach(buf)
  end
end

function M.setup()
  for _, ft in pairs(configs.available_parsers()) do
    if utils.has_parser(ft)
      and queries.get_query(ft, 'highlights')
      and not M.registered_autocmd[ft] then
      local cmd = "lua require'nvim-treesitter.highlight'.attach()"
      local autocmd = string.format('autocmd NvimTreesitter Filetype %s %s', ft, cmd)
      M.registered_autocmd[ft] = autocmd
      api.nvim_command(autocmd)
    end
  end
end

M.commands = {
  TSDisableHl = {
    run = disable_hl,
    args = { "-nargs=0" },
    description = '`:TSDisableHl` disable treesitter highlight for the current session'
  },
  TSEnableHl = {
    run = enable_hl,
    args = { "-nargs=0" },
    description = '`:TSEnableHl` enable treesitter highlight for the current session'
  }
}

return M
