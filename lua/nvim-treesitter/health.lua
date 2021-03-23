local api = vim.api
local fn = vim.fn

local queries = require'nvim-treesitter.query'
local info = require'nvim-treesitter.info'

local health_start = vim.fn["health#report_start"]
local health_ok = vim.fn['health#report_ok']
local health_error = vim.fn['health#report_error']
local health_warn = vim.fn['health#report_warn']

local M = {}

local function install_health()
  health_start('Installation')
  if fn.executable('tree-sitter') == 0 then
    health_warn('`tree-sitter` executable not found (parser generator, only needed for :TSInstallFromGrammar,'..
                ' not required for :TSInstall)')
  else
    local handle = io.popen('tree-sitter  -V')
    local result = handle:read("*a")
    handle:close()
    local version = vim.split(result,'\n')[1]:match('[^tree%psitter].*')
    health_ok('`tree-sitter` found '..version..' (parser generator, only needed for :TSInstallFromGrammar)')
  end

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
      'Check that either gcc or clang is in your $PATH'
    })
  else
    health_ok('`cc` executable found.')
  end
end

local function query_status(lang, query_group)
  local ok, err = pcall(queries.get_query, lang, query_group)
  if not ok then
    return "x", err
  elseif not err then
    return "."
  else
    return "✓"
  end
end

function M.checkhealth()
  local error_collection = {}
  -- Installation dependency checks
  install_health()
  queries.invalidate_query_cache()
  health_start("Parser/Features H L F I")
  -- Parser installation checks
  for _, parser_name in pairs(info.installed_parsers()) do
    local installed = #api.nvim_get_runtime_file('parser/'..parser_name..'.so', false)

    -- Only print informations about installed parsers
    if installed >= 1 then
      local multiple_parsers = installed > 1 and "+" or ""
      local out = "  - "..parser_name..multiple_parsers..string.rep(" ", 15 - (#parser_name + #multiple_parsers))
      for _, query_group in pairs(queries.built_in_query_groups) do
        local status, err = query_status(parser_name, query_group)
        out = out..status.." "
        if err then
          table.insert(error_collection, {parser_name, query_group, err})
        end
      end
      print(out)
    end
  end
  print([[

 Legend: H[ighlight], L[ocals], F[olds], I[ndents]
         +) multiple parsers found, only one will be used
         x) errors found in the query, try to run :TSUpdate {lang}]])
  if #error_collection > 0 then
    print('\nThe following errors have been detected:')
    for _, p in ipairs(error_collection) do
      local lang, type, err = unpack(p)
      health_error(lang..'('..type..'): '..err)
    end
  end
end

return M
