local M = {}

M.tiers = { 'stable', 'unstable', 'unmaintained', 'unsupported' }

---@class TSConfig
---@field install_dir string

---@type TSConfig
local config = {
  install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site'),
}

---Setup call for users to override configuration configurations.
---@param user_data TSConfig? user configuration table
function M.setup(user_data)
  if user_data then
    if user_data.install_dir then
      user_data.install_dir = vim.fs.normalize(user_data.install_dir)
      vim.opt.runtimepath:prepend(user_data.install_dir)
    end
    config = vim.tbl_deep_extend('force', config, user_data)
  end
end

-- Returns the install path for parsers, parser info, and queries.
-- If the specified directory does not exist, it is created.
---@param dir_name string
---@return string
function M.get_install_dir(dir_name)
  local dir = vim.fs.joinpath(config.install_dir, dir_name)

  if not vim.uv.fs_stat(dir) then
    local ok, err = pcall(vim.fn.mkdir, dir, 'p', '0755')
    if not ok then
      local log = require('nvim-treesitter.log')
      log.error(err --[[@as string]])
    end
  end
  return dir
end

---@param type 'queries'|'parsers'?
---@return string[]
function M.get_installed(type)
  local installed = {} --- @type table<string, boolean>
  if not (type and type == 'parsers') then
    for f in vim.fs.dir(M.get_install_dir('queries')) do
      installed[f] = true
    end
  end
  if not (type and type == 'queries') then
    for f in vim.fs.dir(M.get_install_dir('parser')) do
      installed[vim.fn.fnamemodify(f, ':r')] = true
    end
  end
  return vim.tbl_keys(installed)
end

-- Get a list of all available parsers
---@param tier integer? only get parsers of specified tier
---@return string[]
function M.get_available(tier)
  vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
  local parsers = require('nvim-treesitter.parsers')
  --- @type string[]
  local languages = vim.tbl_keys(parsers)
  table.sort(languages)
  if tier then
    languages = vim.tbl_filter(
      --- @param p string
      function(p)
        return parsers[p] ~= nil and parsers[p].tier == tier
      end,
      languages
    )
  end
  return languages
end

local function expand_tiers(list)
  for i, tier in ipairs(M.tiers) do
    if vim.list_contains(list, tier) then
      list = vim.tbl_filter(
        --- @param l string
        function(l)
          return l ~= tier
        end,
        list
      )
      vim.list_extend(list, M.get_available(i))
    end
  end

  return list
end

---Normalize languages
---@param languages? string[]|string
---@param skip? { missing: boolean?, unsupported: boolean?, installed: boolean?, dependencies: boolean? }
---@return string[]
function M.norm_languages(languages, skip)
  if not languages then
    return {}
  elseif type(languages) == 'string' then
    languages = { languages }
  end

  if vim.list_contains(languages, 'all') then
    if skip and skip.missing then
      return M.get_installed()
    end
    languages = M.get_available()
  end

  languages = expand_tiers(languages)

  if skip and skip.installed then
    local installed = M.get_installed()
    languages = vim.tbl_filter(
      --- @param v string
      function(v)
        return not vim.list_contains(installed, v)
      end,
      languages
    )
  end

  if skip and skip.missing then
    local installed = M.get_installed()
    languages = vim.tbl_filter(
      --- @param v string
      function(v)
        return vim.list_contains(installed, v)
      end,
      languages
    )
  end

  local parsers = require('nvim-treesitter.parsers')
  languages = vim.tbl_filter(
    --- @param v string
    function(v)
      -- TODO(lewis6991): warn of any unknown parsers?
      return parsers[v] ~= nil
    end,
    languages
  )

  if skip and skip.unsupported then
    languages = vim.tbl_filter(
      --- @param v string
      function(v)
        return not (parsers[v] and parsers[v].tier and parsers[v].tier == 4)
      end,
      languages
    )
  end

  if not (skip and skip.dependencies) then
    for _, lang in pairs(languages) do
      if parsers[lang] and parsers[lang].requires then
        vim.list_extend(languages, parsers[lang].requires)
      end
    end
  end

  -- TODO(clason): remove Nvim 0.11 compat
  if vim.list then
    return vim.list.unique(languages)
  else
    table.sort(languages)
    return vim.fn.uniq(languages) --[=[@as string[] ]=]
  end
end

return M
