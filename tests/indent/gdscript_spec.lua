local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/gdscript', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = false,
})

t.describe('indent GDScript:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('basic_blocks.gd', { on_line = 1, text = 'var member := 0', indent = 0 })
  end)
end)
