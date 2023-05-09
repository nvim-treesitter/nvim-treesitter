local utils = require('nvim-treesitter.utils')

local M = {}

---@class TSConfig
---@field sync_install boolean
---@field ensure_installed string[]|string
---@field ignore_install string[]
---@field auto_install boolean
---@field install_dir string|nil

---@type TSConfig
local config = {
  sync_install = false,
  ensure_installed = {},
  auto_install = false,
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

  local ensure_installed = config.ensure_installed
  if #ensure_installed > 0 then
    if config.sync_install then
      require('nvim-treesitter.install').ensure_installed_sync(ensure_installed)
    else
      require('nvim-treesitter.install').ensure_installed(ensure_installed)
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

function M.get_ignored_parser_installs()
  return config.ignore_install or {}
end

function M.get_ensure_installed_parsers()
  if type(config.ensure_installed) == 'string' then
    return { config.ensure_installed }
  end
  return config.ensure_installed or {}
end

return M
