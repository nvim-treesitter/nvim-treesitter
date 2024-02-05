local Sessions = require('fittencode.sessions')
local Bindings = require('fittencode.bindings')
local Log = require('fittencode.log')
local Tasks = require('fittencode.tasks')

local M = {}

function M.setup()
  if not vim.fn.has('nvim-0.10') then
    Log.error('fittencode.nvim need version of Neovim >= 0.10.0 with support for inline virtual text.')
    return
  end
  Tasks.setup()
  Sessions.load_last_session()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()
end

return M
