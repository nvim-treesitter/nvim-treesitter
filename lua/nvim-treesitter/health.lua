local install = require('nvim-treesitter.install')
local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')
local util = require('nvim-treesitter.util')
local tsq = vim.treesitter.query
local health = vim.health

local M = {}

local NVIM_TREESITTER_MINIMUM_ABI = 13

---@return string|nil
local function ts_cli_version()
  if vim.fn.executable('tree-sitter') == 1 then
    local result = assert(vim.system({ 'tree-sitter', '-V' }):wait().stdout)
    return vim.split(result, '\n')[1]:match('[^tree%psitter ].*')
  end
end

local function install_health()
  health.start('Requirements')

  if vim.fn.has('nvim-0.10') ~= 1 then
    health.error('Nvim-treesitter requires Neovim Nightly')
  end

  if vim.fn.executable('tree-sitter') == 0 then
    health.warn(
      '`tree-sitter` executable not found (parser generator, only needed for :TSInstallFromGrammar,'
        .. ' not required for :TSInstall)'
    )
  else
    health.ok(
      '`tree-sitter` found '
        .. (ts_cli_version() or '(unknown version)')
        .. ' (only needed for `:TSInstallFromGrammar`)'
    )
  end

  if vim.fn.executable('node') == 0 then
    health.warn('`node` executable not found (only needed for `:TSInstallFromGrammar`.')
  else
    local result = assert(vim.system({ 'node', '--version' }):wait().stdout)
    local version = vim.split(result, '\n')[1]
    health.ok('`node` found ' .. version .. ' (only needed for `:TSInstallFromGrammar`)')
  end

  if vim.fn.executable('git') == 0 then
    health.error(
      '`git` executable not found.',
      'Install it with your package manager and check that your `$PATH` is set correctly.'
    )
  else
    health.ok('`git` executable found.')
  end

  local cc = install.select_executable(install.compilers)
  if not cc then
    health.error('`cc` executable not found.', {
      'Check that any of '
        .. table.concat(install.compilers, ', ')
        .. ' is in your $PATH'
        .. ' or set `$CC` or `require"nvim-treesitter.install".compilers` explicitly.',
    })
  else
    local version = assert(vim.system({ cc, cc == 'cl' and '' or '--version' }):wait().stdout)
    health.ok(
      '`'
        .. cc
        .. '` executable found, selected from:  '
        .. table.concat(install.compilers, ', ')
        .. (version and ('\nVersion: ' .. version) or '')
    )
  end
  if vim.treesitter.language_version then
    if vim.treesitter.language_version >= NVIM_TREESITTER_MINIMUM_ABI then
      health.ok(
        'Neovim was compiled with tree-sitter runtime ABI version '
          .. vim.treesitter.language_version
          .. ' (required >='
          .. NVIM_TREESITTER_MINIMUM_ABI
          .. ').'
      )
    else
      health.error(
        'Neovim was compiled with tree-sitter runtime ABI version '
          .. vim.treesitter.language_version
          .. '.\n'
          .. 'nvim-treesitter expects at least ABI version '
          .. NVIM_TREESITTER_MINIMUM_ABI
          .. '\n'
          .. 'Please make sure that Neovim is linked against a recent tree-sitter library when building'
          .. ' or raise an issue at your Neovim packager. Parsers must be compatible with runtime ABI.'
      )
    end
  end

  health.start('OS Info')
  for k, v in pairs(vim.uv.os_uname()) do
    health.info(k .. ': ' .. v)
  end

  local installdir = config.get_install_dir('')
  health.start('Install directory for parsers and queries')
  health.info(installdir)
  if vim.uv.fs_access(installdir, 'w') then
    health.ok('is writable.')
  else
    health.error('is not writable.')
  end
  if
    vim.iter(vim.api.nvim_list_runtime_paths()):any(function(p)
      if installdir == vim.fs.normalize(p) .. '/' then
        return true
      end
    end)
  then
    health.ok('is in runtimepath.')
  else
    health.error('is not in runtimepath.')
  end
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
  health.start('Installed languages' .. string.rep(' ', 5) .. 'H L F I J')
  local languages = config.installed_parsers()
  for _, lang in pairs(languages) do
    local parser = parsers.configs[lang]
    local out = lang .. string.rep(' ', 22 - #lang)
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
    health.info(vim.fn.trim(out, ' ', 2))
  end
  health.start('  Legend: H[ighlight], L[ocals], F[olds], I[ndents], In[J]ections')

  if #error_collection > 0 then
    health.start('The following errors have been detected in query files:')
    for _, p in ipairs(error_collection) do
      local lang, type = p[1], p[2]
      local lines = {}
      table.insert(lines, lang .. '(' .. type .. '): ')
      local files = tsq.get_files(lang, type)
      if #files > 0 then
        for _, file in ipairs(files) do
          local query = util.read_file(file)
          local _, file_err = pcall(tsq.parse, lang, query)
          if file_err then
            table.insert(lines, file)
          end
        end
      end
      health.error(table.concat(lines, ''))
    end
  end
end

M.bundled_queries = { 'highlights', 'locals', 'folds', 'indents', 'injections' }

return M
