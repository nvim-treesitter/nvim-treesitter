local whole_file = require('tests.indent.common').indent_whole_file
local new_line = require('tests.indent.common').indent_new_line
local scan_dir = require('plenary.scandir').scan_dir

local opts = {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
}

local run = function(file, spec, title)
  title = title and title or tostring(spec.on_line)
  it(string.format('%s[%s]', file, title), function()
    new_line('tests/indent/c/' .. file, spec, opts)
  end)
end

describe('indent C:', function()
  describe('whole file:', function()
    local files = scan_dir('tests/indent/c');
    for _, file in ipairs(files) do
      it(vim.fn.fnamemodify(file, ':t'), function()
        whole_file(file, opts)
      end)
    end
  end)

  describe('new line:', function()
    run('array.c', { on_line = 2, text = '0,', indent = 4 })
    run('cond.c', { on_line = 3, text = 'x++;', indent = 8 })
    run('cond.c', { on_line = 8, text = 'x++;', indent = 8 })
    run('expr.c', { on_line = 10, text = '2 *', indent = 8 })
    run('func.c', { on_line = 17, text = 'int z,', indent = 4 })
    run('label.c', { on_line = 3, text = 'normal:', indent = 0 })
    run('loop.c', { on_line = 3, text = 'x++;', indent = 8 })
    run('preproc_cond.c', { on_line = 5, text = 'x++;', indent = 4 })
    run('preproc_func.c', { on_line = 3, text = 'x++; \\', indent = 8 })
    run('string.c', { on_line = 1, text = 'brave new \\', indent = 0 })
    run('string.c', { on_line = 4, text = '"brave new "', indent = 4 })
    run('struct.c', { on_line = 4, text = 'int y;', indent = 8 })
    run('switch.c', { on_line = 3, text = 'x++;', indent = 12 })
    run('ternary.c', { on_line = 4, text = ': (x == 0) : 0', indent = 8 })
    -- the line after inserted one will be left with wrong indent but we only care about the inserted one
    run('no_braces.c', { on_line = 4, text = 'x++;', indent = 8 })
    run('no_braces.c', { on_line = 7, text = 'x++;', indent = 8 })
    run('no_braces.c', { on_line = 10, text = 'x++;', indent = 8 })
  end)
end)
