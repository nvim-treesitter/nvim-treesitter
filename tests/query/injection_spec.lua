local t = require('test.testutil')
local sut = require('tests.sut')

sut.setup()

t.describe('injections', function()
  local files = vim.fn.glob('tests/query/injections/**/*.*', false, true)
  for _, file in ipairs(files) do
    t.it(file, function()
      sut.exec_lua(function(f)
        require('tests.query.injections').check(f)
      end, file)
    end)
  end
end)
