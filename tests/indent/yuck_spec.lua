local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner
local run = Runner:new('tests/indent/yuck', {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
})

t.describe('indent yuck', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('indent.yuck', { on_line = 13, text = ':box1 parameter', indent = 4 })
    run:new_line('indent.yuck', { on_line = 17, text = ')', indent = 0 })
  end)
end)
