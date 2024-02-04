local Sessions = require('fittencode.sessions')
local Bindings = require('fittencode.bindings')

local M = {}

function M.setup()
  Sessions.load_last_session()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()
end

return M
