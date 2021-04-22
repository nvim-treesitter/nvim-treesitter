local whole_file = require('nvim-treesitter.test_utils').indent_whole_file
local new_line = require('nvim-treesitter.test_utils').indent_new_line
local scan_dir = require('plenary.scandir').scan_dir
local Path = require('plenary.path')

local opts = {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
  filetype = 'cpp',
}

local get_name = function(file)
  return Path:new(file):make_relative('tests/indent')
end

describe('indent C++:', function()
  describe('whole file:', function()
    local files = scan_dir('tests/indent/c');
    vim.list_extend(files, scan_dir('tests/indent/cpp'))

    for _, file in ipairs(files) do
      it(get_name(file), function()
        whole_file(file, opts)
      end)
    end
  end)

  describe('new line:', function()
    local run = function(file, spec, title)
      title = title and title or tostring(spec.on_line)
      it(string.format('%s[%s]', get_name(file), title), function()
        new_line(file, spec, opts)
      end)
    end

    run('tests/indent/cpp/access.cpp', { on_line = 3, text = 'protected:', indent = 0 })
    run('tests/indent/cpp/class.cpp', { on_line = 2, text = 'using T = int;', indent = 4 })
    run('tests/indent/cpp/stream.cpp', { on_line = 5, text = '<< x + 3', indent = 8 })

    -- TODO: find a clean way to import these from c_spec.lua
    run('tests/indent/c/array.c', { on_line = 2, text = '0,', indent = 4 })
    run('tests/indent/c/cond.c', { on_line = 3, text = 'x++;', indent = 8 })
    run('tests/indent/c/cond.c', { on_line = 8, text = 'x++;', indent = 8 })
    run('tests/indent/c/expr.c', { on_line = 10, text = '2 *', indent = 8 })
    run('tests/indent/c/func.c', { on_line = 17, text = 'int z,', indent = 4 })
    run('tests/indent/c/label.c', { on_line = 3, text = 'normal:', indent = 0 })
    run('tests/indent/c/loop.c', { on_line = 3, text = 'x++;', indent = 8 })
    run('tests/indent/c/preproc_cond.c', { on_line = 5, text = 'x++;', indent = 4 })
    run('tests/indent/c/preproc_func.c', { on_line = 3, text = 'x++; \\', indent = 8 })
    run('tests/indent/c/string.c', { on_line = 1, text = 'brave new \\', indent = 0 })
    run('tests/indent/c/string.c', { on_line = 4, text = '"brave new "', indent = 4 })
    run('tests/indent/c/struct.c', { on_line = 4, text = 'int y;', indent = 8 })
    run('tests/indent/c/switch.c', { on_line = 3, text = 'x++;', indent = 12 })
    run('tests/indent/c/ternary.c', { on_line = 4, text = ': (x == 0) : 0', indent = 8 })
    -- the line after inserted one will be left with wrong indent but we only care about the inserted one
    run('tests/indent/c/no_braces.c', { on_line = 4, text = 'x++;', indent = 8 })
    run('tests/indent/c/no_braces.c', { on_line = 7, text = 'x++;', indent = 8 })
    run('tests/indent/c/no_braces.c', { on_line = 10, text = 'x++;', indent = 8 })
  end)
end)
