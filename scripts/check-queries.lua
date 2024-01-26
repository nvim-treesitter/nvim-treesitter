#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')

local query_types = require('nvim-treesitter.health').bundled_queries
local configs = require('nvim-treesitter.parsers').configs
local parsers = #_G.arg > 0 and { unpack(_G.arg) }
  or require('nvim-treesitter.config').installed_parsers()

-- Extract captures from documentation for validation
local captures = {}
do
  local current_query ---@type string

  for line in io.lines('CONTRIBUTING.md') do
    if vim.startswith(line, '### ') then
      current_query = line:sub(5):lower()
    elseif vim.startswith(line, '@') and current_query then
      if not captures[current_query] then
        captures[current_query] = {}
      end

      table.insert(captures[current_query], vim.split(line:sub(2), ' ')[1])
    end
  end

  -- Complete captures for injections.
  for _, lang in pairs(vim.tbl_keys(configs)) do
    table.insert(captures['injections'], lang)
  end
end

-- Check queries for each installed parser in parsers
local errors = {} ---@type string[]
local timings = {} ---@type number[][]
do
  print('::group::Check parsers')

  for _, lang in pairs(parsers) do
    if configs[lang] and configs[lang].install_info then
      timings[lang] = {}
      for _, query_type in pairs(query_types) do
        local before = vim.uv.hrtime()
        local ok, query = pcall(vim.treesitter.query.get, lang, query_type)
        local duration = vim.uv.hrtime() - before
        table.insert(timings, { duration = duration, lang = lang, query_type = query_type })
        print(string.format('Checking %s %s (%.02fms)', lang, query_type, duration * 1e-6))
        if not ok then
          errors[#errors + 1] = string.format('%s (%s): %s', lang, query_type, query)
        else
          if query then
            for _, capture in ipairs(query.captures) do
              local is_valid = (
                vim.startswith(capture, '_') -- Helpers.
                or vim.tbl_contains(captures[query_type], function(documented_capture)
                  return vim.startswith(capture, documented_capture)
                end, { predicate = true })
              )
              if not is_valid then
                errors[#errors + 1] =
                  string.format('%s (%s): invalid capture "@%s"', lang, query_type, capture)
              end
            end
          end
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
