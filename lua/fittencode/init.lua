local Sessions = require('fittencode.sessions')
local Bindings = require('fittencode.bindings')

local M = {}

M.config = {}

function M.setup(cfg)
  Sessions.load_last_session()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()
end

return M
