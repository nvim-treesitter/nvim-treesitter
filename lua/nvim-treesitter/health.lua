local api = vim.api
local fn = vim.fn

local locals = require'nvim-treesitter.locals'
local configs = require'nvim-treesitter.configs'
local queries = require'nvim-treesitter.query'

local health_start = vim.fn["health#report_start"]
local health_ok = vim.fn['health#report_ok']
local health_info = vim.fn['health#report_info']
local health_warn = vim.fn['health#report_warn']
local health_error = vim.fn['health#report_error']

local M = {}

local function queries_health(lang)
  if not queries.get_query(lang, "locals") then
    health_warn("No `locals.scm` query found for " .. lang, {
      "Open an issue at https://github.com/nvim-treesitter/nvim-treesitter"
    })
  else
    health_ok("`locals.scm` found.")
  end
end

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

-- TODO(vigoux): Maybe we should move each check to be perform in its own module
function M.checkhealth()
  -- Installation dependency checks
  health_start('Installation')
  install_health()

  local missing_parsers = {}
  -- Parser installation checks
  for _, ft in pairs(configs.available_parsers()) do
    local installed = #api.nvim_get_runtime_file('parser/'..ft..'.so', false)

    -- Only print informations about installed parsers
    if installed == 1 then
      health_start(ft .. " parser healthcheck")
      health_ok(ft .. " parser found.")

      queries_health(ft)
    elseif installed > 1 then
      health_warn(string.format("Multiple parsers found for %s, only %s will be used.", ft, installed[1]))
    else
      table.insert(missing_parsers, ft)
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
