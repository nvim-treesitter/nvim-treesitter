local api = vim.api

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'
local caching = require'nvim-treesitter.caching'

local M = {}

local function has_some_textobject_mapping(lang)
  for _, v in pairs(M.get_module('textobjects.select').keymaps) do
    if type(v) == 'table' then
      if v[lang] then
        return true
      end
    end
  end
  return false
end

local config = {
  modules = {},
  ensure_installed = {}
}
-- List of modules that need to be setup on initialization.
local queued_modules_defs = {}
-- Whether we've initialized the plugin yet.
local is_initialized = false
local builtin_modules = {
  highlight = {
    module_path = 'nvim-treesitter.highlight',
    enable = false,
    disable = {},
    custom_captures = {},
    is_supported = queries.has_highlights
  },
  incremental_selection = {
    module_path = 'nvim-treesitter.incremental_selection',
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
      module_path = 'nvim-treesitter.refactor.highlight_definitions',
      enable = false,
      disable = {},
      is_supported = queries.has_locals
    },
    highlight_current_scope = {
      module_path = 'nvim-treesitter.refactor.highlight_current_scope',
      enable = false,
      disable = {},
      is_supported = queries.has_locals,
    },
    smart_rename = {
      module_path = 'nvim-treesitter.refactor.smart_rename',
      enable = false,
      disable = {},
      is_supported = queries.has_locals,
      keymaps = {
        smart_rename = "grr"
      }
    },
    navigation = {
      module_path = 'nvim-treesitter.refactor.navigation',
      enable = false,
      disable = {},
      is_supported = queries.has_locals,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD"
      }
    }
  },
  textobjects = {
    select = {
      module_path = 'nvim-treesitter.textobjects.select',
      enable = false,
      disable = {},
      is_supported = function(lang)
        return has_some_textobject_mapping(lang) or queries.has_textobjects(lang)
      end,
      keymaps = {},
    },
    move = {
      module_path = 'nvim-treesitter.textobjects.move',
      enable = false,
      disable = {},
      is_supported = queries.has_textobjects,
      goto_next_start = {},
      goto_next_end = {},
      goto_previous_start = {},
      goto_previous_end = {},
    },
    swap = {
      module_path = 'nvim-treesitter.textobjects.swap',
      enable = false,
      disable = {},
      is_supported = queries.has_textobjects,
      swap_next = {},
      swap_previous = {},
    },
  }
}

local attached_buffers_by_module = caching.create_buffer_cache()

-- Resolves a module by requiring the `module_path` or using the module definition.
local function resolve_module(mod_name)
  local config_mod = M.get_module(mod_name)

  if not config_mod then return end

  if type(config_mod.attach) == 'function' and type(config_mod.detach) == 'function' then
    return config_mod
  elseif type(config_mod.module_path) == 'string' then
    return require(config_mod.module_path)
  end
end

local function enable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.get_buf_lang(bufnr)

  M.attach_module(mod, bufnr, lang)
end

local function enable_mod_conf_autocmd(mod, lang)
  local config_mod = M.get_module(mod)

  if not config_mod or not M.is_enabled(mod, lang) then return end

  local cmd = string.format("lua require'nvim-treesitter.configs'.attach_module('%s')", mod)
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
  local lang = lang or parsers.get_buf_lang(bufnr)
  if not lang then
    return
  end

  if not parsers.list[lang] then
    return
  end

  M.detach_module(mod, bufnr)
end

local function disable_mod_conf_autocmd(mod, lang)
  local config_mod = M.get_module(mod)

  if not config_mod or not M.is_enabled(mod, lang) then return end

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

-- Recurses through all modules including submodules
-- @param accumulator function called for each module
-- @param root root configuration table to start at
-- @param path prefix path
local function recurse_modules(accumulator, root, path)
  local root = root or config.modules

  for name, module in pairs(root) do
    local new_path = path and (path..'.'..name) or name

    if M.is_module(module) then
      accumulator(name, module, new_path, root)
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
    }
  },
  TSBufDisable = {
    run = disable_module,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_available_modules"
    }
  },
  TSEnableAll = {
    run = enable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    }
  },
  TSDisableAll = {
    run = disable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    }
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

-- Setup call for users to override module configurations.
-- @param user_data module overrides
function M.setup(user_data)
  for name, data in pairs(user_data) do
    if name == 'ensure_installed' then
      config.ensure_installed = data
      require'nvim-treesitter.install'.ensure_installed(data)
    else
      config.modules[name] = vim.tbl_deep_extend('force', config.modules[name] or {}, data)

      recurse_modules(function(_, _, new_path)
        if data.enable then
          enable_all(new_path)
        end

        for _, lang in ipairs(data.disable or {}) do
          disable_mod_conf_autocmd(new_path, lang)
        end
      end, config.modules)
    end
  end
end

-- Defines a table of modules that can be attached/detached to buffers
-- based on language support. A module consist of the following properties:
-- * @enable Whether the modules is enabled. Can be true or false.
-- * @disable A list of languages to disable the module for. Only relevant if enable is true.
-- * @keymaps A list of user mappings for a given module if relevant.
-- * @is_supported A function which, given a ft, will return true if the ft works on the module.
-- * @module_path A string path to a module file using `require`. The exported module must contain
--                an `attach` and `detach` function. This path is not required if `attach` and `detach`
--                functions are provided directly on the module definition.
-- * @attach An attach function that is called for each buffer that the module is enabled for. This is required
--           if a `module_path` is not specified.
-- * @detach A detach function that is called for each buffer that the module is enabled for. This is required
--           if a `module_path` is not specified.
-- Modules are not setup until `init` is invoked by the plugin. This allows modules to be defined in any order
-- and can be loaded lazily.
-- @example
-- require"nvim-treesitter".define_modules {
--   my_cool_module = {
--     attach = function()
--       do_some_cool_setup()
--     end,
--     detach = function()
--       do_some_cool_teardown()
--     end
--   }
-- }
function M.define_modules(mod_defs)
  if not is_initialized then
    table.insert(queued_modules_defs, mod_defs)
    return
  end

  recurse_modules(function(key, mod, _, group)
    group[key] = vim.tbl_extend("keep", mod, {
      enable = false,
      disable = {},
      is_supported = function() return true end
    })
  end, mod_defs)

  config.modules = vim.tbl_deep_extend("keep", config.modules, mod_defs)

  for _, lang in pairs(parsers.available_parsers()) do
    for _, mod in ipairs(M.available_modules(mod_defs)) do
      enable_mod_conf_autocmd(mod, lang)
    end
  end
end

-- Attaches a module to a buffer
-- @param mod_name the module name
-- @param bufnr the bufnr
-- @param lang the language of the buffer
function M.attach_module(mod_name, bufnr, lang)
  local resolved_mod = resolve_module(mod_name)
  local bufnr = bufnr or api.nvim_get_current_buf()

  if resolved_mod
    and parsers.has_parser(lang)
    and not attached_buffers_by_module.has(mod_name, bufnr)
  then
    attached_buffers_by_module.set(mod_name, bufnr, true)
    resolved_mod.attach(bufnr, lang)
  end
end

-- Detaches a module to a buffer
-- @param mod_name the module name
-- @param bufnr the bufnr
function M.detach_module(mod_name, bufnr)
  local resolved_mod = resolve_module(mod_name)
  local bufnr = bufnr or api.nvim_get_current_buf()

  if resolved_mod then
    attached_buffers_by_module.remove(mod_name, bufnr)
    resolved_mod.detach(bufnr)
  end
end

-- Gets available modules
-- @param root root table to find modules
function M.available_modules(root)
  local modules = {}

  recurse_modules(function(_, _, path)
    table.insert(modules, path)
  end, root)

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
-- A module should contain an attach and detach function.
-- @param mod the module table
function M.is_module(mod)
  return type(mod) == 'table'
    and ((type(mod.attach) == 'function' and type(mod.detach) == 'function')
      or type(mod.module_path) == 'string')
end

-- Initializes built-in modules and any queued modules
-- registered by plugins or the user.
function M.init()
  is_initialized = true
  M.define_modules(builtin_modules)

  for _, mod_def in ipairs(queued_modules_defs) do
    M.define_modules(mod_def)
  end
end

return M
