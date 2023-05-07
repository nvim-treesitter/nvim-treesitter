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
  parser_install_dir = nil,
}

---Setup call for users to override module configurations.
---@param user_data TSConfig module overrides
function M.setup(user_data)
  config.ignore_install = user_data.ignore_install or {}
  config.parser_install_dir = user_data.parser_install_dir or nil
  if config.parser_install_dir then
    config.parser_install_dir = vim.fn.expand(config.parser_install_dir, ':p')
  end

  config.auto_install = user_data.auto_install or false
  if config.auto_install then
    require('nvim-treesitter.install').setup_auto_install()
  end

  local ensure_installed = user_data.ensure_installed or {}
  if #ensure_installed > 0 then
    if user_data.sync_install then
      require('nvim-treesitter.install').ensure_installed_sync(ensure_installed)
    else
      require('nvim-treesitter.install').ensure_installed(ensure_installed)
    end
  end

  config.ensure_installed = ensure_installed
end

-- If parser_install_dir is not nil is used or created.
-- If parser_install_dir is nil try the package dir of the nvim-treesitter
-- plugin first, followed by the "site" dir from "runtimepath". "site" dir will
-- be created if it doesn't exist. Using only the package dir won't work when
-- the plugin is installed with Nix, since the "/nix/store" is read-only.
---@param folder_name string|nil
---@return string|nil, string|nil
function M.get_parser_install_dir(folder_name)
  folder_name = folder_name or 'parser'

  local install_dir = config.parser_install_dir or utils.get_package_path()
  local parser_dir = utils.join_path(install_dir, folder_name)

  return utils.create_or_reuse_writable_dir(
    parser_dir,
    utils.join_space("Could not create parser dir '", parser_dir, "': "),
    utils.join_space(
      "Parser dir '",
      parser_dir,
      "' should be read/write (see README on how to configure an alternative install location)"
    )
  )
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
