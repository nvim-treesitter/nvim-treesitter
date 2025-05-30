#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')

local query_types = require('nvim-treesitter.health').bundled_queries
local configs = require('nvim-treesitter.parsers')
local parsers = #_G.arg > 0 and { unpack(_G.arg) }
  or require('nvim-treesitter.config').get_installed('queries')

-- Check queries for each installed parser in parsers
local errors = {} ---@type string[]
local timings = {} ---@type { duration: number, lang: string, query_type: string }[]
do
  print('::group::Check parsers')

  for _, lang in pairs(parsers) do
    if configs[lang] and configs[lang].install_info then
      timings[lang] = {}
      for _, query_type in pairs(query_types) do
        local before = vim.uv.hrtime()
        local ok, query = pcall(vim.treesitter.query.get, lang, query_type)
        local duration = vim.uv.hrtime() - before
        if query then
          table.insert(timings, { duration = duration, lang = lang, query_type = query_type })
          print(string.format('Checking %s %s (%.02fms)', lang, query_type, duration * 1e-6))
        end
        if not ok then
          errors[#errors + 1] = string.format('%s (%s): %s', lang, query_type, query)
        end
      end
    end
  end

  print('::endgroup::')
end

-- Output
if #errors > 0 then
  print('::group::Errors')
  for _, err in ipairs(errors) do
    print(err)
  end
  print('::endgroup::')
  print('Check failed!\n')
  vim.cmd.cq()
else
  print('::group::Timings')
  table.sort(timings, function(a, b)
    return a.duration < b.duration
  end)
  for i, val in ipairs(timings) do
    print(
      string.format(
        '%i. %.02fms %s %s',
        #timings - i + 1,
        val.duration * 1e-6,
        val.lang,
        val.query_type
      )
    )
  end
  print('::endgroup::')
  print('Check successful!')
end
