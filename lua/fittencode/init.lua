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
  Bindings.setup_commands()

  if Config.options.completion_mode == 'inline' then
    Bindings.setup_autocmds()
    if Config.options.use_default_keymaps then
      Bindings.setup_keymaps()
    end
  else
    require('fittencode.lsp').resiter_source()
  end

  -- Defer loading last session to avoid blocking initialization
  local DEFER_LOAD_TIME = 100
  vim.defer_fn(function()
    require('fittencode.sessions').request_load_last_session()
  end, DEFER_LOAD_TIME)
end

setmetatable(M, {
  __index = function(_, k)
    return function(...)
      return require('fittencode.api').api[k](...)
    end
  end,
})

return M
