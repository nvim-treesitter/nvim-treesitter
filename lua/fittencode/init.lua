local Sessions = require('fittencode.sessions')
local Bindings = require('fittencode.bindings')
local Log = require('fittencode.log')
local Tasks = require('fittencode.tasks')
local View = require('fittencode.view')
local Color = require('fittencode.color')

local M = {}

function M.setup()
  if not vim.fn.has('nvim-0.10') then
    Log.error('fittencode.nvim need version of Neovim >= 0.10.0 with support for inline virtual text.')
    return
  end

  Tasks.setup()
  Color.setup_highlight()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()

  Sessions.load_last_session()
end

return M
