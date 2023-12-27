#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')

-- Equivalent to print(), but this will ensure consistent output regardless of
-- operating system.
local function io_print(text)
  if not text then
    text = ''
  end
  io.write(text, '\n')
end

local function extract_captures()
  local captures = {}
  local current_query

  for line in io.lines('CONTRIBUTING.md') do
    if vim.startswith(line, '### ') then
      current_query = line:sub(5):lower()
    elseif vim.startswith(line, '@') and current_query then
      if not captures[current_query] then
        captures[current_query] = {}
      end

      table.insert(captures[current_query], vim.split(line:sub(2), ' ', true)[1])
    end
  end

  -- Complete captures for injections.
  local parsers = vim.tbl_keys(require('nvim-treesitter.parsers').configs)
  for _, lang in pairs(parsers) do
    table.insert(captures['injections'], lang)
  end

  return captures
end

local function list_any(list, predicate)
  for _, v in pairs(list) do
    if predicate(v) then
      return true
    end
  end
  return false
end

local function do_check()
  local timings = {}
  local parsers = require('nvim-treesitter.config').installed_parsers()
  local query_types = require('nvim-treesitter.health').bundled_queries
  local configs = require('nvim-treesitter.parsers').configs

  local captures = extract_captures()
  local last_error

  io_print('::group::Check parsers')

  for _, lang in pairs(parsers) do
    if configs[lang].install_info then
      timings[lang] = {}
      for _, query_type in pairs(query_types) do
        local before = vim.uv.hrtime()
        local ok, query = pcall(vim.treesitter.query.get, lang, query_type)
        local after = vim.uv.hrtime()
        local duration = after - before
        table.insert(timings, { duration = duration, lang = lang, query_type = query_type })
        io_print(
          'Checking ' .. lang .. ' ' .. query_type .. string.format(' (%.02fms)', duration * 1e-6)
        )
        if not ok then
          local err_msg = lang .. ' (' .. query_type .. '): ' .. query
          io_print(err_msg)
          last_error = err_msg
        else
          if query then
            for _, capture in ipairs(query.captures) do
              local is_valid = (
                vim.startswith(capture, '_') -- Helpers.
                or list_any(captures[query_type], function(documented_capture)
                  return vim.startswith(capture, documented_capture)
                end)
              )
              if not is_valid then
                local error =
                  string.format('(x) Invalid capture @%s in %s for %s.', capture, query_type, lang)
                io_print(error)
                last_error = error
              end
            end
          end
        end
      end
    end
  end

  io_print('::endgroup::')

  if last_error then
    io_print()
    io_print('Last error: ')
    error(last_error)
  end
  return timings
end

local ok, result = pcall(do_check)
if ok then
  io_print('::group::Timings')
  table.sort(result, function(a, b)
    return a.duration < b.duration
  end)
  for i, val in ipairs(result) do
    io_print(
      string.format(
        '%i. %.02fms %s %s',
        #result - i + 1,
        val.duration * 1e-6,
        val.lang,
        val.query_type
      )
    )
  end
  io_print('::endgroup::')
  io_print('Check successful!')
else
  io_print('Check failed:')
  io_print(result)
  io_print('\n')
end
