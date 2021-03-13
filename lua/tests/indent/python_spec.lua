local whole_file = require('nvim-treesitter.test_utils').indent_whole_file

describe('indent python', function()
  local files = {
    'aligned_indent.py',
    'basic_blocks.py',
    'basic_collections.py',
    'branches.py',
    'comprehensions.py',
    'control_flow.py',
    'hanging_indent.py',
    'join_lines.py',
    'nested_collections.py',
    'strings.py',
  }
  for _, file in ipairs(files) do
    it(file, function() whole_file('lua/tests/indent/python/' .. file) end)
  end
end)
