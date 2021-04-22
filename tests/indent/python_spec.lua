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
    new_line('tests/indent/python/' .. file, spec, opts)
  end)
end

describe('indent Python:', function()
  describe('whole file:', function()
    local files = scan_dir('tests/indent/python');
    for _, file in ipairs(files) do
      it(vim.fn.fnamemodify(file, ':t'), function()
        whole_file(file, opts)
      end)
    end
  end)

  describe('new line:', function()
    run('aligned_indent.py', { on_line = 1, text = 'arg3,', indent = 19 })
    run('basic_blocks.py', { on_line = 1, text = 'wait,', indent = 4 })
    run('basic_blocks.py', { on_line = 6, text = 'x += 1', indent = 4 })
    run('basic_blocks.py', { on_line = 10, text = 'x += 1', indent = 8 })
    run('basic_blocks.py', { on_line = 7, text = 'x += 1', indent = 4 }, '7, after last line of a block')
    run('basic_blocks.py', { on_line = 11, text = 'x += 1', indent = 8 }, '11, after last line of a block')
    run('basic_collections.py', { on_line = 3, text = '4,', indent = 4 })
    run('comprehensions.py', { on_line = 8, text = 'if x != 2', indent = 4 })
    run('control_flow.py', { on_line = 23, text = 'x = 4', indent = 4 })
    run('hanging_indent.py', { on_line = 1, text = 'arg0,', indent = 8 })
    run('hanging_indent.py', { on_line = 5, text = '0,', indent = 4 })
    run('join_lines.py', { on_line = 1, text = '+ 1 \\', indent = 4 })
    run('join_lines.py', { on_line = 4, text = '+ 1 \\', indent = 4 })
    run('join_lines.py', { on_line = 7, text = '+ 1 \\', indent = 4 })
    run('nested_collections.py', { on_line = 5, text = '0,', indent = 12 })
    run('nested_collections.py', { on_line = 6, text = ',0', indent = 12 })
    run('nested_collections.py', { on_line = 29, text = '[1, 2],', indent = 12 })
    run('nested_collections.py', { on_line = 39, text = '0,', indent = 5 })
    run('strings.py', { on_line = 14, text = 'x', indent = 4 })
    run('strings.py', { on_line = 15, text = 'x', indent = 0 })
    run('strings.py', { on_line = 16, text = 'x', indent = 8 })
  end)
end)
