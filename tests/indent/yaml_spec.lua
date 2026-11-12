local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new('tests/indent/yaml', {
  shiftwidth = 2,
  expandtab = true,
})

t.describe('indent YAML:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('indent-sequence-items.yaml', { on_line = 2, text = 'key3: value3', indent = 2 })
    run:new_line('autoindent-mapping-pair.yaml', { on_line = 1, text = 'key3: value3', indent = 2 })
  end)
end)
