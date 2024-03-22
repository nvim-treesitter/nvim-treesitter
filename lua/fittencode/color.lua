local Base = require('fittencode.base')

local M = {}

M.FittenSuggestion = 'FittenSuggestion'
M.FittenSuggestionWhitespace = 'FittenSuggestionWhitespace'

-- Define FittenCode colors
local colors = {}
colors.gray = '#808080'

function M.setup_highlight()
  Base.set_hi(M.FittenSuggestion, {
    fg = colors.gray,
    ctermfg = 'LightGrey',
  })
  Base.set_hi(M.FittenSuggestionWhitespace, {
    bg = colors.gray,
    ctermbg = 'LightGrey',
  })
end

return M
