local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/dot', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

t.describe('indent dot:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('test.dot', { on_line = 1, text = 'node [', indent = 2 })
    run:new_line('test.dot', { on_line = 2, text = 'shape=ellipse,', indent = 4 })
    run:new_line('test.dot', { on_line = 4, text = 'subgraph sub {', indent = 2 })
    run:new_line('test.dot', { on_line = 5, text = 'a1 -> a2 -> a3;', indent = 4 })
    run:new_line('test.dot', { on_line = 6, text = '}', indent = 2 })
    run:new_line('test.dot', { on_line = 7, text = '}', indent = 0 })
  end)
end)
