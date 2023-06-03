local install = require('nvim-treesitter.install')
local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')
local util = require('nvim-treesitter.util')
local tsq = vim.treesitter.query

local M = {}

local NVIM_TREESITTER_MINIMUM_ABI = 13

---@return string|nil
local function ts_cli_version()
  if vim.fn.executable('tree-sitter') == 1 then
    local handle = io.popen('tree-sitter -V')
    if not handle then
      return
    end
    local result = handle:read('*a')
    handle:close()
    return vim.split(result, '\n')[1]:match('[^tree%psitter ].*')
  end
end

local function install_health()
  vim.health.start('Installation')

  if vim.fn.has('nvim-0.10') ~= 1 then
    vim.health.error('Nvim-treesitter requires Neovim Nightly')
  end

  if vim.fn.executable('tree-sitter') == 0 then
    vim.health.warn(
      '`tree-sitter` executable not found (parser generator, only needed for :TSInstallFromGrammar,'
        .. ' not required for :TSInstall)'
    )
  else
    vim.health.ok(
      '`tree-sitter` found '
        .. (ts_cli_version() or '(unknown version)')
        .. ' (parser generator, only needed for :TSInstallFromGrammar)'
    )
  end

  if vim.fn.executable('node') == 0 then
    vim.health.warn(
      '`node` executable not found (only needed for :TSInstallFromGrammar,'
        .. ' not required for :TSInstall)'
    )
  else
    local handle = assert(io.popen('node --version'))
    local result = handle:read('*a')
    handle:close()
    local version = vim.split(result, '\n')[1]
    vim.health.ok('`node` found ' .. version .. ' (only needed for :TSInstallFromGrammar)')
  end

  if vim.fn.executable('git') == 0 then
    vim.health.error('`git` executable not found.', {
      'Install it with your package manager.',
      'Check that your `$PATH` is set correctly.',
    })
  else
    vim.health.ok('`git` executable found.')
  end

  local cc = install.select_executable(install.compilers)
  if not cc then
    vim.health.error('`cc` executable not found.', {
      'Check that any of '
        .. vim.inspect(install.compilers)
        .. ' is in your $PATH'
        .. ' or set the environment variable CC or `require"nvim-treesitter.install".compilers` explicitly!',
    })
  else
    local version = vim.fn.systemlist(cc .. (cc == 'cl' and '' or ' --version'))[1]
    vim.health.ok(
      '`'
        .. cc
        .. '` executable found. Selected from '
        .. vim.inspect(install.compilers)
        .. (version and ('\nVersion: ' .. version) or '')
    )
  end
  if vim.treesitter.language_version then
    if vim.treesitter.language_version >= NVIM_TREESITTER_MINIMUM_ABI then
      vim.health.ok(
        'Neovim was compiled with tree-sitter runtime ABI version '
          .. vim.treesitter.language_version
          .. ' (required >='
          .. NVIM_TREESITTER_MINIMUM_ABI
          .. '). Parsers must be compatible with runtime ABI.'
      )
    else
      vim.health.error(
        'Neovim was compiled with tree-sitter runtime ABI version '
          .. vim.treesitter.language_version
          .. '.\n'
          .. 'nvim-treesitter expects at least ABI version '
          .. NVIM_TREESITTER_MINIMUM_ABI
          .. '\n'
          .. 'Please make sure that Neovim is linked against are recent tree-sitter runtime when building'
          .. ' or raise an issue at your Neovim packager. Parsers must be compatible with runtime ABI.'
      )
    end
  end

  vim.health.start('OS Info:\n' .. vim.inspect(vim.uv.os_uname()))
end

local function query_status(lang, query_group)
  local ok, err = pcall(tsq.get, lang, query_group)
  if not ok then
    return 'x', err
  elseif not err then
    return '.'
  else
    return '✓'
  end
end

function M.check()
  --- @type {[1]: string, [2]: string, [3]: string}[]
  local error_collection = {}
  -- Installation dependency checks
  install_health()
  -- Parser installation checks
  local languages = config.installed_parsers()
  local parser_installation = { 'Parser/Features' .. string.rep(' ', 9) .. 'H L F I J' }
  for _, lang in pairs(languages) do
    local parser = parsers.configs[lang]
    local out = '  - ' .. lang .. string.rep(' ', 20 - #lang)
    if parser.install_info then
      for _, query_group in pairs(M.bundled_queries) do
        local status, err = query_status(lang, query_group)
        out = out .. status .. ' '
        if err then
          table.insert(error_collection, { lang, query_group, err })
        end
      end
    end
    if parser.requires then
      for _, p in pairs(parser.requires) do
        if not vim.list_contains(languages, p) then
          table.insert(error_collection, { lang, 'queries', 'dependency ' .. p .. ' missing' })
        end
      end
    end
    table.insert(parser_installation, vim.fn.trim(out, ' ', 2))
  end
  local legend = [[

  Legend: H[ighlight], L[ocals], F[olds], I[ndents], In[J]ections
          x) errors found in the query, try to run :TSUpdate {lang}]]
  table.insert(parser_installation, legend)
  -- Finally call the report function
  vim.health.start(table.concat(parser_installation, '\n'))
  if #error_collection > 0 then
    vim.health.start('The following errors have been detected:')
    for _, p in ipairs(error_collection) do
      local lang, type, err = p[1], p[2], p[3]
      local lines = {}
      table.insert(lines, lang .. '(' .. type .. '): ' .. err)
      local files = tsq.get_files(lang, type)
      if #files > 0 then
        table.insert(lines, lang .. '(' .. type .. ') is concatenated from the following files:')
        for _, file in ipairs(files) do
          local query = util.read_file(file)
          local ok, file_err = pcall(tsq.parse, lang, query)
          if ok then
            table.insert(lines, '|  [OK]:"' .. file .. '"')
          else
            table.insert(lines, '| [ERR]:"' .. file .. '", failed to load: ' .. file_err)
          end
        end
      end
      vim.health.error(table.concat(lines, '\n'))
    end
  end
end

M.bundled_queries = { 'highlights', 'locals', 'folds', 'indents', 'injections' }

return M
