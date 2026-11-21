local t = require('test.testutil')
local sut = require('tests.sut')

sut.setup()

t.describe('highlight queries', function()
  local files = vim.fn.glob('tests/query/highlights/**/*.*', false, true)
  for _, file in ipairs(files) do
    t.it(file, function()
      sut.exec_lua(function(f)
        require('tests.query.highlights').check(f)
      end, file)
    end)
  end
end)
