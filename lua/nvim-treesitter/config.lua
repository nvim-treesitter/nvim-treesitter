local utils = require('nvim-treesitter.utils')

local M = {}

---@class TSConfig
---@field sync_install boolean
---@field auto_install boolean
---@field ensure_install string[]
---@field ignore_install string[]
---@field install_dir string

---@type TSConfig
local config = {
  sync_install = false,
  auto_install = false,
  ensure_install = {},
  ignore_install = {},
  install_dir = vim.fn.stdpath('data') .. 'site',
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
  --TODO(clason): move to plugin/ or user config? only if non-default?
  vim.opt.runtimepath:append(config.install_dir)

  if config.auto_install then
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buffer].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if
          require('nvim-treesitter.parsers').configs[lang]
          and not vim.list_contains(M.installed_parsers(), lang)
          and not vim.list_contains(M.ignored_parsers(), lang)
        then
          require('nvim-treesitter.install').install()({ lang })
        end
      end,
    })
  end

  local to_install = config.ensure_install

  if #to_install > 0 then
    local installed = M.installed_parsers()
    to_install = vim.iter.filter(function(v)
      return not vim.list_contains(installed, v)
    end, to_install)
  end

  if #to_install > 0 then
    require('nvim-treesitter.install').install({
      with_sync = config.sync_install,
      exclude_configured_parsers = true,
    })(to_install)
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

---@return string[]
function M.installed_parsers()
  local install_dir = M.get_install_dir('parser')

  local installed = {} --- @type string[]
  for f in vim.fs.dir(install_dir) do
    local lang = assert(f:match('(.*)%..*'))
    installed[#installed + 1] = lang
  end

  return installed
end

function M.ignored_parsers()
  return config.ignore_install
end

return M
