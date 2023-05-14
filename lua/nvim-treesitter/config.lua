local utils = require('nvim-treesitter.utils')

local M = {}

---@class TSConfig
---@field sync_install boolean
---@field ensure_install string[]|string
---@field ignore_install string[]
---@field auto_install boolean
---@field install_dir string|nil

---@type TSConfig
local config = {
  sync_install = false,
  auto_install = false,
  ensure_install = {},
  ignore_install = {},
  install_dir = utils.join_path(vim.fn.stdpath('data'), 'site'),
}

---Setup call for users to override configuration configurations.
---@param user_data TSConfig|nil user configuration table
function M.setup(user_data)
  if user_data then
    if user_data.install_dir then
      user_data.install_dir = vim.fn.expand(user_data.install_dir, ':p')
    end
    config = vim.tbl_deep_extend('force', config, user_data)
  end
  vim.opt.runtimepath:append(config.install_dir)

  if config.auto_install then
    require('nvim-treesitter.install').setup_auto_install()
  end

  local ensure_install = config.ensure_install
  if #ensure_install > 0 then
    if config.sync_install then
      require('nvim-treesitter.install').install({ exclude_configured_parsers = true })(
        ensure_install
      )
    else
      require('nvim-treesitter.install').install({
        with_sync = true,
        exclude_configured_parsers = true,
      })(ensure_install)
    end
  end
end

-- Returns the install path for parsers, parser info, and queries.
-- If the specified directory does not exist, it is created.
---@param dir_name string
---@return string
function M.get_install_dir(dir_name)
  local dir = utils.join_path(config.install_dir, dir_name)

  if not vim.loop.fs_stat(dir) then
    local ok, error = pcall(vim.fn.mkdir, dir, 'p', '0755')
    if not ok then
      vim.notify(error, vim.log.levels.ERROR)
    end
  end
  return dir
end

function M.get_ignore_install()
  if type(config.ignore_install) == 'string' then
    return { config.ignore_install }
  end
  return config.ignore_install or {}
end

function M.get_ensure_install()
  if type(config.ensure_install) == 'string' then
    return { config.ensure_install }
  end
  return config.ensure_install or {}
end

return M
