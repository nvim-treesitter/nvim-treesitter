local M = {}

---@param opts? FittencodeOptions
function M.setup(opts)
  -- Check if Neovim >= 0.8.0 is installed
  if vim.fn.has('nvim-0.8.0') == 0 then
    local msg = 'fittencode.nvim requires Neovim >= 0.8.0.'
    vim.api.nvim_err_writeln(msg)
    return
  end

  local Config = require('fittencode.config')
  Config.setup(opts)

  -- Initialize modules
  require('fittencode.log').setup(Config.options.log)
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
