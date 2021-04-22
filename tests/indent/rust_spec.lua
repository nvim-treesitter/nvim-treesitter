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
    new_line('tests/indent/rust/' .. file, spec, opts)
  end)
end

describe('indent Rust:', function()
  describe('whole file:', function()
    local files = scan_dir('tests/indent/rust');
    for _, file in ipairs(files) do
      it(vim.fn.fnamemodify(file, ':t'), function()
        whole_file(file, opts)
      end)
    end
  end)

  describe('new line:', function()
    run('array.rs', { on_line = 2, text = '0,', indent = 4 })
    run('array.rs', { on_line = 8, text = '0,', indent = 8 })
    run('comment.rs', { on_line = 3, text = 'a', indent = '/// ' })
    run('cond.rs', { on_line = 11, text = 'x += 1;', indent = 12 })
    run('cond.rs', { on_line = 2, text = 'x += 1;', indent = 8 })
    run('cond.rs', { on_line = 4, text = 'x += 1;', indent = 8 })
    run('cond.rs', { on_line = 6, text = 'x += 1;', indent = 8 })
    run('enum.rs', { on_line = 2, text = 'Q,', indent = 4 })
    run('enum.rs', { on_line = 4, text = 'i32,', indent = 8 })
    run('enum.rs', { on_line = 8, text = 'z: u32,', indent = 8 })
    run('func.rs', { on_line = 1, text = 'let _x = 1;', indent = 4 })
    run('func.rs', { on_line = 6, text = 'z: i32,', indent = 4 })
    run('impl.rs', { on_line = 3, text = 'const FOO: u32 = 1;', indent = 4 })
    run('impl.rs', { on_line = 4, text = 'let _x = 1;', indent = 8 })
    run('loop.rs', { on_line = 10, text = 'x += 1;', indent = 8 })
    run('loop.rs', { on_line = 2, text = 'x += 1;', indent = 8 })
    run('loop.rs', { on_line = 6, text = 'x += 1;', indent = 8 })
    run('macro.rs', { on_line = 1, text = '() => {},', indent = 4 })
    run('macro.rs', { on_line = 12, text = 'B C', indent = 4 })
    run('macro.rs', { on_line = 2, text = 'struct $c;', indent = 8 })
    run('match.rs', { on_line = 2, text = '-1 => -1,', indent = 8 })
    run('match.rs', { on_line = 7, text = 'let y = 1;', indent = 12 })
    run('mod.rs', { on_line = 1, text = 'const Z: i32 = 1;', indent = 4 })
    run('mod.rs', { on_line = 2, text = 'const Z: i32 = 1;', indent = 4 })
    run('mod.rs', { on_line = 6, text = 'const Z: i32 = 1;', indent = 8 })
    run('string.rs', { on_line = 2, text = 'brave new', indent = 0 })
    run('string.rs', { on_line = 5, text = 'brave new \\', indent = 8 })
    run('string.rs', { on_line = 9, text = 'brave new \\', indent = 8 })
    run('struct.rs', { on_line = 1, text = 'z: i32,', indent = 4 })
    run('struct.rs', { on_line = 2, text = 'z: i32,', indent = 4 })
    run('trait.rs', { on_line = 4, text = 'fn baz();', indent = 4 })
    run('trait.rs', { on_line = 7, text = 'fn baz();', indent = 4 })
    run('trait.rs', { on_line = 8, text = '()', indent = 8 })
    run('where.rs', { on_line = 17, text = 'T: Debug,', indent = 4 })
    run('where.rs', { on_line = 2, text = 'T: Debug,', indent = 4 })
    run('where.rs', { on_line = 9, text = 'T: Debug,', indent = 4 })
  end)
end)
