local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/typst', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = false,
})

t.describe('indent typst:', function()
  run:whole_file('.')
end)
