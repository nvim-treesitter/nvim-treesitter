local utils = require('nvim-treesitter.utils')

local M = {}

---@class TSConfig
---@field sync_install boolean
---@field ensure_installed string[]|string
---@field ignore_install string[]
---@field auto_install boolean
---@field parser_install_dir string|nil

---@type TSConfig
local config = {
  sync_install = false,
  ensure_installed = {},
  auto_install = false,
  ignore_install = {},
  parser_install_dir = utils.join_path(vim.fn.stdpath('data'), 'nvim-treesitter'),
}

---Setup call for users to override module configurations.
---@param user_data TSConfig module overrides
function M.setup(user_data)
  if user_data and user_data.parser_install_dir then
    config.parser_install_dir = vim.fn.expand(user_data.parser_install_dir, ':p')
  end
  vim.opt.runtimepath:append(config.parser_install_dir)

  config.auto_install = user_data and user_data.auto_install or false
  if config.auto_install then
    require('nvim-treesitter.install').setup_auto_install()
  end

  local ensure_installed = user_data and user_data.ensure_installed or {}
  if #ensure_installed > 0 then
    if user_data and user_data.sync_install then
      require('nvim-treesitter.install').ensure_installed_sync(ensure_installed)
    else
      require('nvim-treesitter.install').ensure_installed(ensure_installed)
    end
  end
  config.ensure_installed = ensure_installed

  config.ignore_install = user_data and user_data.ignore_install or {}
end

-- If parser_install_dir is not nil it is used or created.
-- If parser_install_dir is nil, use "site" dir from "runtimepath"
---@param folder_name string|nil
---@return string|nil, string|nil
function M.get_parser_install_dir(folder_name)
  folder_name = folder_name or 'parser'

  local dir = utils.join_path(config.parser_install_dir, folder_name)

  if not vim.loop.fs_stat(dir) then
    local ok, error = pcall(vim.fn.mkdir, dir, 'p', '0755')
    if not ok then
      vim.notify(error, vim.log.levels.ERROR)
      return
    end
  end
  return dir
end

function M.get_parser_info_dir()
  return M.get_parser_install_dir('parser-info')
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
