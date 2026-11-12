local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new('tests/indent/graphql', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

t.describe('indent GraphQL:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function() end)
end)
