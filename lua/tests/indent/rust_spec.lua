local whole_file = require('nvim-treesitter.test_utils').indent_whole_file

describe('indent rust', function()
  local files = {
    'basic.rs',
  }
  for _, file in ipairs(files) do
    it(file, function()
      whole_file('lua/tests/indent/rust/' .. file, {
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 0,
        expandtab = true,
      })
    end)
  end
end)
