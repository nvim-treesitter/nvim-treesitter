local M = {}

function M.setup()
  if vim.fn.has('nvim-0.10') == 0 then
    vim.api.nvim_echo({
      { 'fittencode.nvim requires Neovim >= 0.10.0 with support for inline virtual text.', 'ErrorMsg' },
    }, true, {})
    return
  end

  local Log = require('fittencode.log')
  local Engine = require('fittencode.engine')
  local Sessions = require('fittencode.sessions')
  local Bindings = require('fittencode.bindings')
  local Color = require('fittencode.color')

  Log.setup()
  Engine.setup()
  Color.setup_highlight()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()

  Sessions.request_load_last_session()
end

return M
