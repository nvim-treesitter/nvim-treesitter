local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/ql', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

t.describe('indent Lua:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)
end)

t.describe('new line:', function()
  run:new_line('module.ql', { on_line = 1, text = 'predicate foo() {}', indent = 2 })
end)

t.describe('new line:', function()
  run:new_line('module.ql', { on_line = 2, text = 'predicate foo() {}', indent = 2 })
end)
