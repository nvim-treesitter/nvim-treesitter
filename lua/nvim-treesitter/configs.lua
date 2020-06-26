local api = vim.api

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'

-- @enable can be true or false
-- @disable is a list of languages, only relevant if enable is true
-- @keymaps list of user mappings for a given module if relevant
-- @is_supported function which, given a ft, will return true if the ft works on the module
local config = {
  modules = {
    highlight = {
      enable = false,
      disable = {},
      is_supported = queries.has_highlights
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
      is_supported = queries.has_locals
    },
    refactor = {
      highlight_definitions = {
        enable = false,
        disable = {},
        is_supported = queries.has_locals
      },
      smart_rename = {
        enable = false,
        disable = {},
        is_supported = queries.has_locals,
        keymaps = {
          smart_rename = "grr"
        }
      },
      navigation = {
        enable = false,
        disable = {},
        is_supported = queries.has_locals,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD"
        }
      }
    }
  },
  ensure_installed = nil
}

local M = {}

local function enable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, 'ft'))

  if not parsers.list[lang] or not M.get_module(mod) then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.attach(bufnr, lang)
end

local function enable_mod_conf_autocmd(mod, lang)
  local config_mod = M.get_module(mod)

  if not config_mod or M.is_enabled(mod, lang) then return end

  local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
  for _, ft in pairs(parsers.lang_to_ft(lang)) do
    api.nvim_command(string.format("autocmd NvimTreesitter FileType %s %s", ft, cmd))
  end
  for i, parser in pairs(config_mod.disable) do
    if parser == lang then
      table.remove(config_mod.disable, i)
      break
    end
  end
end

local function enable_all(mod, lang)
  local config_mod = M.get_module(mod)

  if not config_mod then return end

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
  config_mod.enable = true
end

local function disable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.ft_to_lang(api.nvim_buf_get_option(bufnr, 'ft'))
  if not lang then
    return
  end

  if not parsers.list[lang] or not M.get_module(mod) then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.detach(bufnr)
end

local function disable_mod_conf_autocmd(mod, lang)
  local config_mod = M.get_module(mod)

  if not config_mod or not M.is_enabled(mod, lang) then return end

  local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
  -- TODO(kyazdani): detach the correct autocmd... doesn't work when using %s, cmd
  for _, ft in pairs(parsers.lang_to_ft(lang)) do
    api.nvim_command(string.format("autocmd! NvimTreesitter FileType %s", ft))
  end
  table.insert(config_mod.disable, lang)
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

    local config_mod = M.get_module(mod)

    if config_mod then
      config_mod.enable = false
    end
  end
end

-- Recurses trough all modules including submodules
-- @param accumulator function called for each module
-- @param root root configuration table to start at
-- @param path prefix path
local function recurse_modules(accumulator, root, path)
  local root = root or config.modules

  for name, module in pairs(root) do
    local new_path = path and (path..'.'..name) or name

    if M.is_module(module) then
      accumulator(name, module, new_path)
    elseif type(module) == 'table' then
      recurse_modules(accumulator, module, new_path)
    end
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

  local module_config = M.get_module(mod)
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
      M.setup_module(config.modules[mod], data)
    elseif mod == 'ensure_installed' then
      config.ensure_installed = data
      require'nvim-treesitter.install'.ensure_installed(data)
    end
  end
end

--- Sets up a single module or all submodules of a group
-- @param mod the module or group of modules
-- @param data user defined configuration for the module
function M.setup_module(mod, data)
  if M.is_module(mod) then
    if type(data.enable) == 'boolean' then
      mod.enable = data.enable
    end
    if type(data.disable) == 'table' then
      mod.disable = data.disable
    end
    if mod.keymaps and type(data.keymaps) == 'table' then
      for f, map in pairs(data.keymaps) do
        if mod.keymaps[f] then
          mod.keymaps[f] = map
        end
      end
    end
  elseif type(data) == 'table' and type(mod) == 'table' then
    for key, value in pairs(data) do 
      M.setup_module(mod[key], value)
    end
  end
end

function M.available_modules()
  local modules = {}

  recurse_modules(function(_, _, path)
    table.insert(modules, path)
  end)

  return modules
end

-- Gets a module config by path
-- @param mod_path path to the module
-- @returns the module or nil
function M.get_module(mod_path)
  local mod = utils.get_at_path(config.modules, mod_path)

  return M.is_module(mod) and mod or nil
end

-- Determines whether the provided table is a module.
-- A module should contain an 'is_supported' function.
-- @param mod the module table
function M.is_module(mod)
  return type(mod) == 'table' and type(mod.is_supported) == 'function' 
end

return M
