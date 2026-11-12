local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/sway', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

t.describe('indent Sway:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {})
  end)
  t.describe('new line:', function()
    run:new_line('main.sw', { on_line = 12, text = 'const CONST: u32 = 2;', indent = 0 })
    run:new_line('main.sw', { on_line = 14, text = 'let hi = 5;', indent = 4 })
    run:new_line('main.sw', { on_line = 15, text = 'let hi = 5;', indent = 8 })
    run:new_line('main.sw', { on_line = 92, text = 'let hi = 5;', indent = 12 })
  end)
end)
