local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/usd', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

t.describe('indent USD:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('prim.usd', { on_line = 3, text = 'active = false', indent = 4 })
    run:new_line('prim.usd', { on_line = 5, text = 'custom int foo = 10', indent = 4 })
  end)
end)
