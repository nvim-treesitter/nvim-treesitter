local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner
-- local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new('tests/indent/julia', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

t.describe('indent Julia:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)
end)
