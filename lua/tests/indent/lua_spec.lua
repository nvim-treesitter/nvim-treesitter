local whole_file = require('nvim-treesitter.test_utils').indent_whole_file
local new_line = require('nvim-treesitter.test_utils').indent_new_line
local scan_dir = require('plenary.scandir').scan_dir

local opts = {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
}

describe('indent Lua:', function()
  describe('whole file:', function()
    local files = scan_dir('lua/tests/indent/lua');
    for _, file in ipairs(files) do
      it(vim.fn.fnamemodify(file, ':t'), function()
        whole_file(file, opts)
      end)
    end
  end)

  describe('new line:', function()
    local run = function(file, spec, title)
      title = title and title or tostring(spec.on_line)
      it(string.format('%s[%s]', file, title), function()
        new_line('lua/tests/indent/lua/' .. file, spec, opts)
      end)
    end

    run('comment.lua', { on_line = 1, text = 'line', indent = '-- ' })
    run('comment.lua', { on_line = 5, text = 'multiline', indent = '  ' })
    run('func.lua', { on_line = 1, text = 'x = x + 1', indent = 2 })
    run('func.lua', { on_line = 2, text = 'y = y + 1', indent = 4 })
    run('func.lua', { on_line = 5, text = '3,', indent = 4 })
    run('string.lua', { on_line = 1, text = 'x', indent = 0 })
    run('string.lua', { on_line = 2, text = 'x', indent = 0 })
    run('string.lua', { on_line = 3, text = 'x', indent = 2 })
    run('string.lua', { on_line = 4, text = 'x', indent = 4 })
    run('table.lua', { on_line = 1, text = 'b = 0,', indent = 2 })
    run('table.lua', { on_line = 5, text = '4,', indent = 4 })
    run('table.lua', { on_line = 7, text = '4,', indent = 4 })
    run('loop.lua', { on_line = 4, text = 'x = x + 1', indent = 2 })
    run('cond.lua', { on_line = 5, text = 'x = x + 1', indent = 2 })
    run('cond.lua', { on_line = 7, text = 'x = x + 1', indent = 2 })
    run('cond.lua', { on_line = 8, text = 'x = x + 1', indent = 4 })
  end)
end)

