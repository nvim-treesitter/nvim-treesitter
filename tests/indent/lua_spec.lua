local Runner = require('tests.indent.common').Runner

local run = Runner:new(it, 'tests/indent/lua', {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})


describe('indent Lua:', function()
  describe('whole file:', function()
    run:whole_file('.')
  end)

  describe('new line:', function()
    run:new_line('comment.lua', { on_line = 1, text = 'line', indent = '-- ' })
    run:new_line('comment.lua', { on_line = 5, text = 'multiline', indent = '  ' })
    run:new_line('func.lua', { on_line = 1, text = 'x = x + 1', indent = 2 })
    run:new_line('func.lua', { on_line = 2, text = 'y = y + 1', indent = 4 })
    run:new_line('func.lua', { on_line = 5, text = '3,', indent = 4 })
    run:new_line('string.lua', { on_line = 1, text = 'x', indent = 0 })
    run:new_line('string.lua', { on_line = 2, text = 'x', indent = 0 })
    run:new_line('string.lua', { on_line = 3, text = 'x', indent = 2 })
    run:new_line('string.lua', { on_line = 4, text = 'x', indent = 4 })
    run:new_line('table.lua', { on_line = 1, text = 'b = 0,', indent = 2 })
    run:new_line('table.lua', { on_line = 5, text = '4,', indent = 4 })
    run:new_line('table.lua', { on_line = 7, text = '4,', indent = 4 })
    run:new_line('loop.lua', { on_line = 4, text = 'x = x + 1', indent = 2 })
    run:new_line('cond.lua', { on_line = 5, text = 'x = x + 1', indent = 2 })
    run:new_line('cond.lua', { on_line = 7, text = 'x = x + 1', indent = 2 })
    run:new_line('cond.lua', { on_line = 8, text = 'x = x + 1', indent = 4 })
  end)
end)

