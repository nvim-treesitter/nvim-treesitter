local api = vim.api
local fn = vim.fn

local queries = require'nvim-treesitter.query'
local locals = require'nvim-treesitter.locals'
local highlight = require'nvim-treesitter.highlight'
local configs = require'nvim-treesitter.configs'

local health_start = vim.fn["health#report_start"]
local health_ok = vim.fn['health#report_ok']
local health_info = vim.fn['health#report_info']
local health_warn = vim.fn['health#report_warn']
local health_error = vim.fn['health#report_error']

local M = {}

local function install_health()
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

local function highlight_health(lang)
  if not queries.get_query(lang, "highlights") then
    health_warn("No `highlights.scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`highlights.scm` found.")
  end
end

local function locals_health(lang)
  if not queries.get_query(lang, "locals") then
    health_warn("No `locals.scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`locals.scm` found.")
  end
end

function M.checkhealth()
  -- Installation dependency checks
  health_start('Installation')
  install_health()

  local missing_parsers = {}
  -- Parser installation checks
  for _, parser_name in pairs(configs.available_parsers()) do
    local installed = #api.nvim_get_runtime_file('parser/'..parser_name..'.so', false)

    -- Only print informations about installed parsers
    if installed == 1 then
      health_start(parser_name .. " parser healthcheck")
      health_ok(parser_name .. " parser found.")

      locals_health(parser_name)
      highlight_health(parser_name)
    elseif installed > 1 then
      health_warn(string.format("Multiple parsers found for %s, only %s will be used.", parser_name, installed[1]))
    else
      table.insert(missing_parsers, parser_name)
    end
  end

  -- Add informations on parsers we dont find
  if #missing_parsers > 0 then
    health_start('Missing parsers')

    -- TODO(vigoux): The installation command should be changed so that its easier to find
    health_warn('Some parsers are not installed:\n' .. table.concat(missing_parsers, '\n'), {
      "Install them using `:TSInstall language"})
  end
end

return M
