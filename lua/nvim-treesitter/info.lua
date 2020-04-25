local api = vim.api
local configs = require'nvim-treesitter.configs'

local M = {}

local function install_info()
  local max_len = 0
  for _, ft in pairs(configs.available_parsers()) do
    if #ft > max_len then max_len = #ft end
  end

  for _, ft in pairs(configs.available_parsers()) do
    local is_installed = #api.nvim_get_runtime_file('parser/'..ft..'.so', false) > 0
    api.nvim_out_write(ft..string.rep(' ', max_len - #ft + 1))
    if is_installed then
      api.nvim_out_write("[✓] installed\n")
    else
      api.nvim_out_write("[✗] not installed\n")
    end
  end
end

local function print_info_module(sorted_filetypes, mod)
  local max_str_len = #sorted_filetypes[1]
  local header = string.format('%s%s', string.rep(' ', max_str_len + 2), mod)
  api.nvim_out_write(header..'\n')
  for _, ft in pairs(sorted_filetypes) do
    local padding = string.rep(' ', max_str_len - #ft + #mod / 2 + 1)
    api.nvim_out_write(ft..":"..padding)
    if configs.is_enabled(mod, ft) then
      api.nvim_out_write('✓')
    else
      api.nvim_out_write('✗')
    end
    api.nvim_out_write('\n')
  end
end

local function print_info_modules(sorted_filetypes)
  local max_str_len = #sorted_filetypes[1]
  local header = string.rep(' ', max_str_len + 2)
  for _, mod in pairs(configs.available_modules()) do
    header = string.format('%s%s ', header, mod)
  end
  api.nvim_out_write(header..'\n')

  for _, ft in pairs(sorted_filetypes) do
    local padding = string.rep(' ', max_str_len - #ft)
    api.nvim_out_write(ft..":"..padding)

    for _, mod in pairs(configs.available_modules()) do
      local pad_len = #mod / 2 + 1
      api.nvim_out_write(string.rep(' ', pad_len))

      if configs.is_enabled(mod, ft) then
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
  if mod and not configs.get_config()[mod] then return end

  local ft_by_len = configs.available_parsers()
  table.sort(ft_by_len, function(a, b) return #a > #b end)
  if mod then
    print_info_module(ft_by_len, mod)
  else
    print_info_modules(ft_by_len)
  end
end

M.commands = {
  TSInstallInfo = {
    run = install_info,
    args = {
      "-nargs=0",
    },
    description = '`:TSInstallInfo` print installation state for every filetype'
  },
  TSModuleInfo = {
    run = module_info,
    args = {
      "-nargs=?",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSModuleInfo` print module state for every filetype, if module is specified, only for current module'
  }
}

return M
