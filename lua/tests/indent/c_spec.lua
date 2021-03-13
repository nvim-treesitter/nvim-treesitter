local whole_file = require('nvim-treesitter.test_utils').indent_whole_file

describe('indent C', function()
  local files = {
    'basic.c',
    'no_braces.c',
  }
  for _, file in ipairs(files) do
    it(file, function()
      whole_file('lua/tests/indent/c/' .. file, {
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 0,
        expandtab = true,
      })
    end)
  end
end)
