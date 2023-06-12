local Runner = require('tests.indent.common').Runner
-- local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, 'tests/indent/julia', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

describe('indent Julia:', function()
  describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)
end)
