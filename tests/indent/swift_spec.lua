local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/swift', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

t.describe('indent Swift:', function()
  t.describe('whole file:', function()
    run:whole_file('.', {})
  end)
  t.describe('new line:', function()
    run:new_line('declarations.swift', { on_line = 6, text = 'var x = 1', indent = 2 })
    run:new_line(
      'declarations.swift',
      { on_line = 12, text = 'var textInsideInit = true', indent = 4 }
    )
    run:new_line(
      'declarations.swift',
      { on_line = 19, text = 'var textInsideWillSet = 1', indent = 6 }
    )
    run:new_line(
      'declarations.swift',
      { on_line = 22, text = 'var textInsideDidSet = 1', indent = 6 }
    )
    run:new_line(
      'declarations.swift',
      { on_line = 27, text = 'var textInsideOverrideFunc', indent = 4 }
    )
    run:new_line(
      'declarations.swift',
      { on_line = 33, text = 'var InsideProtocol: String { get }', indent = 2 }
    )
  end)
end)
