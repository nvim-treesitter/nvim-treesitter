local api = vim.api

local queries = require'nvim-treesitter.query'
local ts_query = require'vim.treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local utils = require'nvim-treesitter.utils'
local caching = require'nvim-treesitter.caching'

local M = {}

local config = {
  modules = {},
  ensure_installed = {},
  ignore_install = {},
  update_strategy = 'lockfile',
}
-- List of modules that need to be setup on initialization.
local queued_modules_defs = {}
-- Whether we've initialized the plugin yet.
local is_initialized = false
local builtin_modules = {
  highlight = {
    module_path = 'nvim-treesitter.highlight',
    enable = false,
    disable = {'markdown'}, -- FIXME(vigoux): markdown highlighting breaks everything for now
    custom_captures = {},
    is_supported = queries.has_highlights,
    additional_vim_regex_highlighting = false,
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
  indent = {
    module_path = 'nvim-treesitter.indent',
    enable = false,
    disable = {},
    is_supported = queries.has_indents
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

-- Enables and attaches the module to a buffer for lang.
-- @param mod path to module
-- @param bufnr buffer number, defaults to current buffer
-- @param lang language, defaults to current language
local function enable_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.get_buf_lang(bufnr)
  M.attach_module(mod, bufnr, lang)
end

-- Enables autocomands for the module.
-- After the module is loaded `loaded` will be set to true for the module.
-- @param mod path to module
local function enable_mod_conf_autocmd(mod)
  local config_mod = M.get_module(mod)
  if not config_mod or config_mod.loaded then
    return
  end

  local cmd = string.format("lua require'nvim-treesitter.configs'.attach_module('%s')", mod)
  api.nvim_command(string.format("autocmd NvimTreesitter FileType * %s", cmd))

  config_mod.loaded = true
end

-- Enables the module globally and for all current buffers.
-- After enabled, `enable` will be set to true for the module.
-- @param mod path to module
local function enable_all(mod)
  local config_mod = M.get_module(mod)
  if not config_mod then return end

  for _, bufnr in pairs(api.nvim_list_bufs()) do
    enable_module(mod, bufnr)
  end

  enable_mod_conf_autocmd(mod)
  config_mod.enable = true
end

-- Disables and detaches the module for a buffer.
-- @param mod path to module
-- @param bufnr buffer number, defaults to current buffer
local function disable_module(mod, bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()
  M.detach_module(mod, bufnr)
end

-- Disables autocomands for the module.
-- After the module is unloaded `loaded` will be set to false for the module.
-- @param mod path to module
local function disable_mod_conf_autocmd(mod)
  local config_mod = M.get_module(mod)
  if not config_mod or not config_mod.loaded then
    return
  end
  -- TODO(kyazdani): detach the correct autocmd... doesn't work when using %s, cmd.
  -- This will remove all autocomands!
  api.nvim_command("autocmd! NvimTreesitter FileType *")
  config_mod.loaded = false
end

-- Disables the module globally and for all current buffers.
-- After disabled, `enable` will be set to false for the module.
-- @param mod path to module
local function disable_all(mod)
  local config_mod = M.get_module(mod)
  if not config_mod or not config_mod.enable then return end

  for _, bufnr in pairs(api.nvim_list_bufs()) do
    disable_module(mod, bufnr)
  end

  disable_mod_conf_autocmd(mod)
  config_mod.enable = false
end

-- Toggles a module for a buffer
-- @param mod path to module
-- @param bufnr buffer number, defaults to current buffer
-- @param lang language, defaults to current language
local function toggle_module(mod, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.get_buf_lang(bufnr)

  if attached_buffers_by_module.has(mod, bufnr) then
    disable_module(mod, bufnr)
  else
    enable_module(mod, bufnr, lang)
  end
end

-- Toggles the module globally and for all current buffers.
-- @param mod path to module
local function toggle_all(mod)
  local config_mod = M.get_module(mod)
  if not config_mod then return end

  if config_mod.enable then
    disable_all(mod)
  else
    enable_all(mod)
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

-- Shows current configuration of all nvim-treesitter modules
-- @param process_function function used as the `process` parameter
--        for vim.inspect (https://github.com/kikito/inspect.lua#optionsprocess)
local function config_info(process_function)
  process_function = process_function or function(item, path)
    if path[#path] == vim.inspect.METATABLE then return end
    if path[#path] == "is_supported" then return end
    return item
  end
  print(vim.inspect(config, {process = process_function}))
end

function M.edit_query_file(query_group, lang)
  lang = lang or parsers.get_buf_lang()
  local files = ts_query.get_query_files(lang, query_group, true)
  if #files == 0 then
    vim.notify('No query file found! Creating a new one!')
    M.edit_query_file_user_after(query_group, lang)
  elseif #files == 1 then
    vim.cmd(':edit '..files[1])
  else
    local counter = 0
    local choices = {
      'Select a file:',
      table.unpack(vim.tbl_map(function(f)
          counter = counter + 1
          return counter..'. '..f
        end,
        files
      ))
    }
    local choice = vim.fn.inputlist(choices)
    if choice > 0 and choice <= #files then
      vim.cmd(':edit '..files[choice])
    end
  end
end

function M.edit_query_file_user_after(query_group, lang)
  lang = lang or parsers.get_buf_lang()
  local folder = utils.join_path(vim.fn.stdpath('config'), 'after', 'queries', lang)
  local file = utils.join_path(folder, query_group..'.scm')
  if vim.fn.isdirectory(folder) ~= 1 then
    local choice = vim.fn.inputlist({'"'..folder.." does not exist. Create it?", "1. Yes", "2. No"})
    if choice == 1 then
      vim.fn.mkdir(folder, "p", "0755")
    else
      return
    end
  end
  vim.cmd(':edit '..file)
end

M.commands = {
  TSBufEnable = {
    run = enable_module,
    args = {
      "-nargs=1",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSBufDisable = {
    run = disable_module,
    args = {
      "-nargs=1",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSBufToggle = {
    run = toggle_module,
    args = {
      "-nargs=1",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSEnableAll = {
    run = enable_all,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSDisableAll = {
    run = disable_all,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSToggleAll = {
    run = toggle_all,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
  TSConfigInfo = {
    run = config_info,
    args = {
      "-nargs=0",
    },
  },
  TSEditQuery = {
    run = M.edit_query_file,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#available_query_groups",
    },
  },
  TSEditQueryUserAfter = {
    run = M.edit_query_file_user_after,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#available_query_groups",
    },
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
  config.modules = vim.tbl_deep_extend('force', config.modules, user_data)
  config.ignore_install = user_data.ignore_install or {}

  local ensure_installed = user_data.ensure_installed or {}
  if #ensure_installed > 0 then
    require'nvim-treesitter.install'.ensure_installed(ensure_installed)
  end

  config.modules.ensure_installed = nil

  recurse_modules(function(_, _, new_path)
    local data = utils.get_at_path(config.modules, new_path)
    if data.enable then
      enable_all(new_path)
    end
  end, config.modules)
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

  for _, mod in ipairs(M.available_modules(mod_defs)) do
    local module_config = M.get_module(mod)
    if module_config and module_config.enable then
      enable_mod_conf_autocmd(mod)
    end
  end
end

-- Attaches a module to a buffer
-- @param mod_name the module name
-- @param bufnr the bufnr
-- @param lang the language of the buffer
function M.attach_module(mod_name, bufnr, lang)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local lang = lang or parsers.get_buf_lang(bufnr)
  local resolved_mod = resolve_module(mod_name)

  if resolved_mod
    and not attached_buffers_by_module.has(mod_name, bufnr)
    and M.is_enabled(mod_name, lang) then
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

  if resolved_mod and attached_buffers_by_module.has(mod_name, bufnr) then
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

function M.get_update_strategy()
  return config.update_strategy
end

function M.get_ignored_parser_installs()
  return config.ignore_install or {}
end

return M
