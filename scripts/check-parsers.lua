#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')

local configs = require('nvim-treesitter.parsers')
local parsers = #_G.arg > 0 and { unpack(_G.arg) }
  or require('nvim-treesitter.config').get_installed('parsers')

local data = {} ---@type table[]
local errors = {} ---@type string[]
for _, lang in pairs(parsers) do
  if configs[lang] and configs[lang].install_info then
    local ok, info = pcall(vim.treesitter.language.inspect, lang)
    if not ok then
      errors[#errors + 1] = string.format('%s: %s', lang, info)
    else
      data[#data + 1] = { lang = lang, abi = info.abi_version, state_count = info.state_count }
    end
  end
end

if #errors > 0 then
  print('::group::Errors')
  for _, err in ipairs(errors) do
    print(err)
  end
  print('::endgroup::')
  print('Check failed!\n')
  vim.cmd.cq()
else
  print('::group::State counts')
  table.sort(data, function(a, b)
    return a.state_count < b.state_count
  end)

  for i, val in ipairs(data) do
    print(string.format('%i.\t%d\t%s (ABI %d)', #data - i + 1, val.state_count, val.lang, val.abi))
  end
  print('::endgroup::')
  print('Check successful!')
end
