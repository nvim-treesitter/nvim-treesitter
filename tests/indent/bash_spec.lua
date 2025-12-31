local Runner = require('tests.indent.common').Runner
local XFAIL = require('tests.indent.common').XFAIL

local run = Runner:new(it, 'tests/indent/bash', {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
})

describe('indent Bash:', function()
  describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  describe('new line:', function()
    run:new_line('test.sh', { on_line = 1, text = 'echo test', indent = 4 }) -- in "for"
    run:new_line('test.sh', { on_line = 2, text = 'echo test', indent = 8 }) -- in "if"
    run:new_line('test.sh', { on_line = 4, text = 'echo test', indent = 8 }) -- in "elif"
    run:new_line('test.sh', { on_line = 6, text = 'echo test', indent = 8 }) -- in "else"
    run:new_line('test.sh', { on_line = 8, text = 'echo test', indent = 4 }) -- after "fi"
    run:new_line('test.sh', { on_line = 12, text = 'echo test', indent = 4 }) -- in "while"
    run:new_line('test.sh', { on_line = 18, text = 'c) echo test ;;', indent = 4 }) -- in "case"
    run:new_line('test.sh', { on_line = 21, text = 'echo test', indent = 4 }) -- in "function"
    run:new_line('test.sh', { on_line = 25, text = 'echo test', indent = 4 }) -- in "f() { ... }"
    run:new_line('test.sh', { on_line = 29, text = 'echo test', indent = 4 }) -- in "{ ... }"
    run:new_line('test.sh', { on_line = 33, text = 'echo test', indent = 4 }) -- in subshell
    run:new_line('test.sh', { on_line = 37, text = 'echo test', indent = 4 }) -- in command substitution
    run:new_line('test.sh', { on_line = 39, text = 'echo test', indent = 0 })
  end)
end)
