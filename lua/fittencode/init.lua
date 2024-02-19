local M = {}

---@class FittencodeOptions @Options for fittencode.nvim
---@field log LogOptions @Options for logging

---@param opts FittencodeOptions
function M.setup(opts)
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

  opts = opts or {}

  -- Initialize modules
  Log.setup(opts.log)
  Engine.setup()
  Color.setup_highlight()
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()

  Sessions.request_load_last_session()
end

setmetatable(M, {
  __index = function(_, k)
    return function(...)
      return require('fittencode.api').api[k](...)
    end
  end,
})

return M
