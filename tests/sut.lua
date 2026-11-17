-- Starts the Nvim under test for the specs of a file and runs code in it.
local t = require('test.testutil')
local n = require('test.functional.testnvim')()

local M = {}

--- Start the Nvim under test before the first test of the current spec file.
function M.setup()
  t.setup(function()
    n.clear({
      merge = false,
      args = { '--clean', '-u', 'tests/minimal_init.lua', '--embed', '--headless' },
    })
  end)
end

--- Run a function in the Nvim under test, see `exec_lua()` in test/functional/testnvim.lua.
M.exec_lua = n.exec_lua

return M
