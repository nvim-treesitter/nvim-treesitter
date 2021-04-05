local api = vim.api
local configs = require'nvim-treesitter.configs'
local parsers = require'nvim-treesitter.parsers'

local M = {}

local function install_info()
  local max_len = 0
  for _, ft in pairs(parsers.available_parsers()) do
    if #ft > max_len then max_len = #ft end
  end

  for _, ft in pairs(parsers.available_parsers()) do
    local is_installed = #api.nvim_get_runtime_file('parser/'..ft..'.so', false) > 0
    api.nvim_out_write(ft..string.rep(' ', max_len - #ft + 1))
    if is_installed then
      api.nvim_out_write("[✓] installed\n")
    else
      api.nvim_out_write("[✗] not installed\n")
    end
  end
end

local function print_info_module(sorted_languages, mod)
  local max_str_len = #sorted_languages[1]
  local header = string.format('%s%s', string.rep(' ', max_str_len + 2), mod)
  api.nvim_out_write(header..'\n')
  for _, lang in pairs(sorted_languages) do
    local padding = string.rep(' ', max_str_len - #lang + #mod / 2 + 1)
    api.nvim_out_write(lang..":"..padding)
    if configs.is_enabled(mod, lang) then
      api.nvim_out_write('✓')
    else
      api.nvim_out_write('✗')
    end
    api.nvim_out_write('\n')
  end
end

-- Sort a list of modules into namespaces.
-- {'mod1', 'mod2.sub1', 'mod2.sub2', 'mod3'}
-- ->
-- { default = {'mod1', 'mod3'}, mod2 = {'sub1', 'sub2'}}
local function namespace_modules(modulelist)
  local modules = { default = {} }
  for _, module in ipairs(modulelist) do
    if module:find('%.') then
      local namespace, submodule = module:match('^(.*)%.(.*)$')
      if not modules[namespace] then
        modules[namespace] = {}
      end
      table.insert(modules[namespace], submodule)
    else
      table.insert(modules.default, module)
    end
  end
  return modules
end

local function longest_string_length(list)
  local length = 0
  for _, value in ipairs(list) do
    if #value > length then
      length = #value
    end
  end
  return length
end

local function append_module_table(curbuf, parserlist, namespace, modulelist)
  local maxlen_parser = longest_string_length(parserlist)
  table.sort(modulelist)

  -- header
  local header = '>> ' .. namespace .. string.rep(' ', maxlen_parser - #namespace - 1)
  for _, module in pairs(modulelist) do
    header = header .. module .. '  '
  end
  api.nvim_buf_set_lines(curbuf, -1, -1, true, {header})

  -- actual table
  for _, parser in ipairs(parserlist) do
    local padding = string.rep(' ', maxlen_parser - #parser + 2)
    local line = parser ..  padding
    local namespace_prefix = (namespace == 'default') and '' or namespace .. '.'
    for _, module in pairs(modulelist) do
      local modlen = #module
      module = namespace_prefix .. module
      if configs.is_enabled(module, parser) then
        line = line .. '✓'
      else
        line = line .. '✗'
      end
      line = line .. string.rep(' ', modlen + 1)
    end
    api.nvim_buf_set_lines(curbuf, -1, -1, true, {line})
  end

  api.nvim_buf_set_lines(curbuf, -1, -1, true, {''})
end

local function print_info_modules(parserlist)
  api.nvim_command('enew')
  local curbuf = api.nvim_get_current_buf()

  local modules = namespace_modules(configs.available_modules())
  table.sort(parserlist)

  local namespaces = {}
  for k, _ in pairs(modules) do table.insert(namespaces, k) end
  table.sort(namespaces)

  for _, namespace in ipairs(namespaces) do
    append_module_table(curbuf, parserlist, namespace, modules[namespace])
  end

  api.nvim_buf_set_option(curbuf, 'modified', false)
  api.nvim_buf_set_option(curbuf, 'buftype', 'nofile')
  api.nvim_exec([[
    syntax match TSModuleInfoGood      /✓/
    syntax match TSModuleInfoBad       /✗/
    syntax match TSModuleInfoHeader    /^>>.*$/ contains=TSModuleInfoNamespace
    syntax match TSModuleInfoNamespace /^>> \w*/ contained
    syntax match TSModuleInfoParser    /^[^> ]*\ze /
    highlight default TSModuleInfoGood guifg=LightGreen gui=bold
    highlight default TSModuleInfoBad  guifg=Crimson
    highlight default link TSModuleInfoHeader    Type
    highlight default link TSModuleInfoNamespace Statement
    highlight default link TSModuleInfoParser    Identifier
  ]], false)
end

local function module_info(mod)
  if mod and not configs.get_module(mod) then return end

  local parserlist = parsers.available_parsers()
  if mod then
    print_info_module(parserlist, mod)
  else
    print_info_modules(parserlist)
  end
end

function M.installed_parsers()
  local installed = {}
  for _, p in pairs(parsers.available_parsers()) do
    if parsers.has_parser(p) then
      table.insert(installed, p)
    end
  end
  return installed
end

M.commands = {
  TSInstallInfo = {
    run = install_info,
    args = {
      "-nargs=0",
    },
  },
  TSModuleInfo = {
    run = module_info,
    args = {
      "-nargs=?",
      "-complete=custom,nvim_treesitter#available_modules",
    },
  },
}

return M
