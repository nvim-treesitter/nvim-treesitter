local api = vim.api

local M = {}

M.FittenSuggestion = 'FittenSuggestion'

function M.setup_highlight()
  api.nvim_set_hl(0, M.FittenSuggestion, {
    link = 'Comment',
    default = true,
  })
end

return M
