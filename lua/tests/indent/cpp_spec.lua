local whole_file = require('nvim-treesitter.test_utils').indent_whole_file
local scan_dir = require('plenary.scandir').scan_dir
local Path = require('plenary.path')

describe('indent C++:', function()
  describe('whole file:', function()
    local files = scan_dir('lua/tests/indent/c');
    vim.list_extend(files, scan_dir('lua/tests/indent/cpp'))

    for _, file in ipairs(files) do
      local name = Path:new(file):make_relative('lua/tests/indent')
      it(name, function()
        whole_file(file, {
          tabstop = 4,
          shiftwidth = 4,
          softtabstop = 0,
          expandtab = true,
          filetype = 'cpp',
        })
      end)
    end
  end)
end)
