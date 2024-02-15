local Base = require('fittencode.base')

local M = {}

M.FittenSuggestion = 'FittenSuggestion'

-- Define FittenCode colors
local colors = {}
colors.gray = '#808080'

function M.setup_highlight()
  Base.set_hi(M.FittenSuggestion, {
    fg = colors.gray,
    ctermfg = 'LightGrey',
  })
end

return M
