local api = vim.api
local ts = vim.treesitter
local queries = require'nvim-treesitter.query'

local M = {
  highlighters = {}
}

function M.attach(bufnr, ft)
  local buf = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(buf, 'ft')

  local query = queries.get_query(ft, "highlights")
  if not query then return end

  M.highlighters[buf] = ts.TSHighlighter.new(query, buf, ft)
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  if M.highlighters[buf] then
    M.highlighters[buf]:set_query("")
    M.highlighters[buf] = nil
  end
  api.nvim_buf_set_option(buf, 'syntax', 'on')
end

function M.checkhealth(lang)
  local health_start = vim.fn["health#report_start"]
  local health_ok = vim.fn['health#report_ok']
  local health_info = vim.fn['health#report_info']
  local health_warn = vim.fn['health#report_warn']
  local health_error = vim.fn['health#report_error']

  if not queries.get_query(lang, "highlights") then
    health_warn("No `highlights.scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`highlights.scm` found.")
  end
end

return M
