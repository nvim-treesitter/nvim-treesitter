local whole_file = require('nvim-treesitter.test_utils').indent_whole_file
local scan_dir = require('plenary.scandir').scan_dir

describe('indent Python:', function()
  describe('whole file:', function()
    local files = scan_dir('lua/tests/indent/python');
    for _, file in ipairs(files) do
      it(vim.fn.fnamemodify(file, ':t'), function()
        whole_file(file, {
          tabstop = 4,
          shiftwidth = 4,
          softtabstop = 0,
          expandtab = true,
        })
      end)
    end
  end)
end)
