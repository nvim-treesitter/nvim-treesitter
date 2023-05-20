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
  install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site'),
}

---Setup call for users to override configuration configurations.
---@param user_data TSConfig|nil user configuration table
function M.setup(user_data)
  if user_data then
    if user_data.install_dir then
      user_data.install_dir = vim.fs.normalize(user_data.install_dir)
      --TODO(clason): insert after/before site, or leave to user?
      vim.opt.runtimepath:append(user_data.install_dir)
    end
    config = vim.tbl_deep_extend('force', config, user_data)
  end

  if config.auto_install then
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if
          require('nvim-treesitter.parsers').configs[lang]
          and not vim.list_contains(M.installed_parsers(), lang)
          and not vim.list_contains(config.ignore_install, lang)
        then
          require('nvim-treesitter.install').install(lang)
        end
      end,
    })
  end

  if #config.ensure_install > 0 then
    local to_install = M.norm_languages(config.ensure_install, { ignored = true, installed = true })

    if #to_install > 0 then
      require('nvim-treesitter.install').install(to_install, {
        with_sync = config.sync_install,
      })
    end
  end
end

-- Returns the install path for parsers, parser info, and queries.
-- If the specified directory does not exist, it is created.
---@param dir_name string
---@return string
function M.get_install_dir(dir_name)
  local dir = vim.fs.joinpath(config.install_dir, dir_name)

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

---Normalize languages
---@param languages? string[]|string
---@param skip? table
---@return string[]
function M.norm_languages(languages, skip)
  if not languages then
    return {}
  end
  local parsers = require('nvim-treesitter.parsers')

  -- Turn into table
  if type(languages) == 'string' then
    languages = { languages }
  end

  if vim.list_contains(languages, 'all') then
    if skip and skip.missing then
      return M.installed_parsers()
    end
    languages = parsers.get_available()
  end

  for i, tier in ipairs(parsers.tiers) do
    if vim.list_contains(languages, tier) then
      languages = vim.iter.filter(function(l)
        return l ~= tier
      end, languages)
      vim.list_extend(languages, parsers.get_available(i))
    end
  end

  if skip and skip.ignored then
    local ignored = config.ignore_install
    languages = vim.iter.filter(function(v)
      return not vim.list_contains(ignored, v)
    end, languages)
  end

  if skip and skip.installed then
    local installed = M.installed_parsers()
    languages = vim.iter.filter(function(v)
      return not vim.list_contains(installed, v)
    end, languages)
  end

  if skip and skip.missing then
    local installed = M.installed_parsers()
    languages = vim.iter.filter(function(v)
      return vim.list_contains(installed, v)
    end, languages)
  end

  return languages
end

return M
