local M = {}

---@param opts? FittenCodeOptions
function M.setup(opts)
  -- Check if Neovim >= 0.8.0 is installed
  if vim.fn.has('nvim-0.8.0') == 0 then
    local msg = 'fittencode.nvim requires Neovim >= 0.8.0.'
    vim.api.nvim_err_writeln(msg)
    return
  end

  local Config = require('fittencode.config')
  Config.setup(opts)

  -- Initialize common modules
  require('fittencode.log').setup(Config.options.log)
  require('fittencode.engine').setup()
  require('fittencode.source_providers').setup()
  require('fittencode.color').setup_highlight()
  local Bindings = require('fittencode.bindings')
  Bindings.setup_commands()

  if Config.options.completion_mode == 'inline' then
    Bindings.setup_autocmds()
    if Config.options.use_default_keymaps then
      Bindings.setup_keymaps()
    end
    if Config.options.inline_completion.disable_completion_when_delete then
      Bindings.setup_onkey()
    end
  elseif Config.options.completion_mode == 'source' then
    require('fittencode.sources.cmp').register_source()
  end

  require('fittencode.sessions').request_load_last_session()
end

setmetatable(M, {
  __index = function(_, k)
    return function(...)
      return require('fittencode.api').api[k](...)
    end
  end,
})

return M
