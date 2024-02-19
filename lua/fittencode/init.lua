local M = {}

---@class FittencodeOptions @Options for fittencode.nvim
---@field log? LogOptions @Options for logging

---@param opts? FittencodeOptions
function M.setup(opts)
  -- Check if Neovim >= 0.10.0 is installed
  if vim.fn.has('nvim-0.10') == 0 then
    local msg = 'fittencode.nvim requires Neovim >= 0.10.0 with support for inline virtual text.'
    vim.api.nvim_err_writeln(msg)
    return
  end

  opts = opts or {}

  -- Initialize modules
  require('fittencode.log').setup(opts.log)
  require('fittencode.engine').setup()
  require('fittencode.color').setup_highlight()
  local Bindings = require('fittencode.bindings')
  Bindings.setup_autocmds()
  Bindings.setup_commands()
  Bindings.setup_keymaps()

  -- Defer loading last session to avoid blocking initialization
  vim.defer_fn(function()
    require('fittencode.sessions').request_load_last_session()
  end, 100)
end

setmetatable(M, {
  __index = function(_, k)
    return function(...)
      return require('fittencode.api').api[k](...)
    end
  end,
})

return M
