local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/rescript', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

t.describe('indent ReScript:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {})
  end)

  t.describe('new line:', function()
    run:new_line('basic.res', { on_line = 5, text = 'x', indent = 0 })
    run:new_line('basic.res', { on_line = 9, text = '"another": here,', indent = 2 })
    run:new_line('basic.res', { on_line = 10, text = '}', indent = 0 })
    run:new_line('basic.res', { on_line = 14, text = '~test: test,', indent = 2 })
    run:new_line('basic.res', { on_line = 18, text = 'x', indent = 0 })

    run:new_line('complex.res', { on_line = 3, text = 'x', indent = 2 })
    run:new_line('complex.res', { on_line = 5, text = 'x', indent = 4 })
    run:new_line('complex.res', { on_line = 17, text = '|', indent = 10 })
    run:new_line('complex.res', { on_line = 25, text = 'x', indent = 2 })
    run:new_line('complex.res', { on_line = 60, text = 'x', indent = 6 })
    run:new_line('complex.res', { on_line = 120, text = 'x', indent = 14 })
    run:new_line('complex.res', { on_line = 136, text = 'x', indent = 2 })

    run:new_line('conditional.res', { on_line = 6, text = 'test: bool,', indent = 2 })
    run:new_line('conditional.res', { on_line = 95, text = 'x', indent = 10 })
  end)
end)
