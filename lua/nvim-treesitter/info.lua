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

local function print_info_modules(sorted_languages)
  local max_str_len = #sorted_languages[1]
  local header = string.rep(' ', max_str_len + 2)
  for _, mod in pairs(configs.available_modules()) do
    header = string.format('%s%s ', header, mod)
  end
  api.nvim_out_write(header..'\n')

  for _, lang in pairs(sorted_languages) do
    local padding = string.rep(' ', max_str_len - #lang)
    api.nvim_out_write(lang..":"..padding)

    for _, mod in pairs(configs.available_modules()) do
      local pad_len = #mod / 2 + 1
      api.nvim_out_write(string.rep(' ', pad_len))

      if configs.is_enabled(mod, lang) then
        api.nvim_out_write('✓')
      else
        api.nvim_out_write('✗')
      end
      api.nvim_out_write(string.rep(' ', pad_len - 1))
    end
    api.nvim_out_write('\n')
  end
end

local function module_info(mod)
  if mod and not configs.get_module(mod) then return end

  local parserlist = parsers.available_parsers()
  table.sort(parserlist, function(a, b) return #a > #b end)
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
