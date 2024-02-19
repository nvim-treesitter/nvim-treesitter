local M = {}

function M.setup()
  -- Check if Neovim >= 0.10.0 is installed
  if vim.fn.has('nvim-0.10') == 0 then
    local msg = 'fittencode.nvim requires Neovim >= 0.10.0 with support for inline virtual text.'
    vim.api.nvim_err_writeln(msg)
    return
  end

  local Log = require('fittencode.log')
  local Engine = require('fittencode.engine')
  local Sessions = require('fittencode.sessions')
  local Bindings = require('fittencode.bindings')
  local Color = require('fittencode.color')

  -- Initialize modules
  Log.setup()
  Engine.setup()
  Color.setup_highlight()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()

  Sessions.request_load_last_session()
end

return M
