local api = vim.api
local fn = vim.fn

local queries = require'nvim-treesitter.query'
local info = require'nvim-treesitter.info'

local health_start = vim.fn["health#report_start"]
local health_ok = vim.fn['health#report_ok']
local health_warn = vim.fn['health#report_warn']
local health_error = vim.fn['health#report_error']

local M = {}

local function install_health()
  health_start('Installation')
  if fn.executable('git') == 0 then
    health_error('`git` executable not found.', {
        'Install it with your package manager.',
        'Check that your `$PATH` is set correctly.'
      })
  else
    health_ok('`git` executable found.')
  end

  if fn.executable('cc') == 0 then
    health_error('`cc` executable not found.', {
        'Install `gcc` with your package manager.',
        'Install `clang` with your package manager.',
        'Check that your `$PATH` is set correctly.'
      })
  else
    health_ok('`cc` executable found.')
  end
end

local function query_health(lang, query_group)
  local ok, found_query = pcall(queries.get_query, lang, query_group)
  if not ok then
    health_error("Error in `"..query_group..".scm` query found for "..lang..'\n'..found_query, {
      "Try `:TSUpdate "..lang.."` (queries might have been adapted for a upstream parser change)",
      "Try to find the syntax error/invalid node type in above file."
    })
  elseif not found_query then
    health_warn("No `"..query_group..".scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`"..query_group..".scm` found.")
  end
end

function M.checkhealth()
  -- Installation dependency checks
  install_health()
  -- Parser installation checks
  for _, parser_name in pairs(info.installed_parsers()) do
    local installed = #api.nvim_get_runtime_file('parser/'..parser_name..'.so', false)

    -- Only print informations about installed parsers
    if installed >= 1 then
      if installed > 1 then
        health_warn(string.format("Multiple parsers found for %s, only %s will be used.", parser_name, installed[1]))
      end
      health_start(parser_name .. " parser healthcheck")
      health_ok(parser_name .. " parser found.")

      for _, query_group in pairs(queries.built_in_query_groups) do
        query_health(parser_name, query_group)
      end
    end
  end
end

return M
