local api = vim.api

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'

-- @enable can be true or false
-- @disable is a list of languages, only relevant if enable is true
-- @keymaps list of user mappings for a given module if relevant
-- @is_supported function which, given a ft, will return true if the ft works on the module
local config = {
  modules = {
    highlight = {
      enable = false,
      disable = {},
      is_supported = function(lang)
        return queries.get_query(lang, 'highlights') ~= nil
      end
    },
    incremental_selection = {
      enable = false,
      disable = {},
      keymaps = {
        init_selection="gnn",
        node_incremental="grn",
        scope_incremental="grc",
        node_decremental="grm"
      },
      is_supported = function(lang)
        return queries.get_query(lang, 'locals')
      end
    }
  },
  ensure_installed = nil
}

local M = {}

local function enable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, 'ft'))
  if not parsers.list[lang] or not config.modules[mod] then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.attach(bufnr, lang)
end

local function enable_mod_conf_autocmd(mod, lang)
  if not config.modules[mod] or M.is_enabled(mod, lang) then return end

  local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
  for _, ft in pairs(parsers.lang_to_ft(lang)) do
    api.nvim_command(string.format("autocmd NvimTreesitter FileType %s %s", ft, cmd))
  end
  for i, parser in pairs(config.modules[mod].disable) do
    if parser == lang then
      table.remove(config.modules[mod].disable, i)
      break
    end
  end
end

local function enable_all(mod, lang)
  if not config.modules[mod] then return end

  for _, bufnr in pairs(api.nvim_list_bufs()) do
    local ft = api.nvim_buf_get_option(bufnr, 'ft')
    if not lang or parsers.lang_match_ft(lang, ft) then
      enable_module(mod, bufnr, lang)
    end
  end
  if lang then
    if parsers.has_parser(lang) then
      enable_mod_conf_autocmd(mod, lang)
    end
  else
    for _, lang in pairs(parsers.available_parsers()) do
      if parsers.has_parser(lang) then
        enable_mod_conf_autocmd(mod, lang)
      end
    end
  end
  config.modules[mod].enable = true
end

local function disable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, 'ft'))
  if not lang then
    return
  end

  if not parsers.list[lang] or not config.modules[mod] then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.detach(bufnr)
end

local function disable_mod_conf_autocmd(mod, lang)
  if not config.modules[mod] or not M.is_enabled(mod, lang) then return end

  local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
  -- TODO(kyazdani): detach the correct autocmd... doesn't work when using %s, cmd
  for _, ft in pairs(parsers.lang_to_ft(lang)) do
    api.nvim_command(string.format("autocmd! NvimTreesitter FileType %s", ft))
  end
  table.insert(config.modules[mod].disable, lang)
end

local function disable_all(mod, lang)
  for _, bufnr in pairs(api.nvim_list_bufs()) do
    local ft = api.nvim_buf_get_option(bufnr, 'ft')
    if not lang or parsers.lang_match_ft(lang, ft) then
      disable_module(mod, bufnr, lang)
    end
  end
  if lang then
    disable_mod_conf_autocmd(mod, lang)
  else
    for _, lang in pairs(parsers.available_parsers()) do
      disable_mod_conf_autocmd(mod, lang)
    end
    config.modules[mod].enable = false
  end
end

M.commands = {
  TSBufEnable = {
    run = enable_module,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSBufEnable module_name` enable a specified module on the current buffer'
  },
  TSBufDisable = {
    run = disable_module,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSBufDisable module_name` disable a specified module on the current buffer'
  },
  TSEnableAll = {
    run = enable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSEnableAll module_name (filetype)` enables a specified module on all buffers. If filetype is specified, enable only for specified filetype'
  },
  TSDisableAll = {
    run = disable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSDisableAll module_name (filetype)` disables a specified module on all buffers. If filetype is specified, disable only for specified filetype'
  },
}

-- @param mod: module (string)
-- @param ft: filetype (string)
function M.is_enabled(mod, lang)
  if not parsers.list[lang] or not parsers.has_parser(lang) then
    return false
  end

  local module_config = config.modules[mod]
  if not module_config then return false end

  if not module_config.enable or not module_config.is_supported(lang) then
    return false
  end

  for _, parser in pairs(module_config.disable) do
    if lang == parser then return false end
  end

  return true
end

function M.setup(user_data)
  if not user_data then return end

  for mod, data in pairs(user_data) do
    if config.modules[mod] then
      if type(data.enable) == 'boolean' then
        config.modules[mod].enable = data.enable
      end
      if type(data.disable) == 'table' then
        config.modules[mod].disable = data.disable
      end
      if config.modules[mod].keymaps and type(data.keymaps) == 'table' then
        for f, map in pairs(data.keymaps) do
          if config.modules[mod].keymaps[f] then
            config.modules[mod].keymaps[f] = map
          end
        end
      end
    elseif mod == 'ensure_installed' then
      config.ensure_installed = data
      require'nvim-treesitter.install'.ensure_installed(data)
    end
  end
end

function M.available_modules()
  return vim.tbl_keys(config.modules)
end

function M.get_module(mod)
  return config.modules[mod]
end

return M
