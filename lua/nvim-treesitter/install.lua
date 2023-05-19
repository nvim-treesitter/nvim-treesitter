local api = vim.api
local fs = vim.fs
local uv = vim.loop

local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')
local shell = require('nvim-treesitter.shell_cmds')

local a = require('nvim-treesitter.async')
local job = require('nvim-treesitter.job')

local M = {}

---@class LockfileInfo
---@field revision string

---@type table<string, LockfileInfo>
local lockfile = {}

local max_jobs = 50

M.compilers = { uv.os_getenv('CC'), 'cc', 'gcc', 'clang', 'cl', 'zig' }
M.prefer_git = uv.os_uname().sysname == 'Windows_NT'
M.command_extra_args = {}
M.ts_generate_args = nil

local started_commands = 0
local finished_commands = 0
local failed_commands = 0

---
--- JOB API functions
---

local function reset_progress_counter()
  if started_commands ~= finished_commands then
    return
  end
  started_commands = 0
  finished_commands = 0
  failed_commands = 0
end

---
--- PARSER INFO
---

---@param lang string
---@param validate boolean|nil
---@return InstallInfo
local function get_parser_install_info(lang, validate)
  local parser_config = parsers.configs[lang]

  if not parser_config then
    error('Parser not available for language "' .. lang .. '"')
  end

  local install_info = parser_config.install_info

  if validate then
    vim.validate({
      url = { install_info.url, 'string' },
      files = { install_info.files, 'table' },
    })
  end

  return install_info
end

---@param lang string
---@return string|nil
local function get_revision(lang)
  if #lockfile == 0 then
    local filename = shell.get_package_path('lockfile.json')
    local file = assert(io.open(filename, 'r'))
    lockfile = vim.json.decode(file:read('*all'))
    file:close()
  end

  local install_info = get_parser_install_info(lang)
  if install_info.revision then
    return install_info.revision
  end

  if lockfile[lang] then
    return lockfile[lang].revision
  end
end

---@param lang string
---@return string|nil
local function get_installed_revision(lang)
  local lang_file = fs.joinpath(config.get_install_dir('parser-info'), lang .. '.revision')
  local file = assert(io.open(lang_file, 'r'))
  local revision = file:read('*a')
  file:close()
  return revision
end

---@param lang string
---@return boolean
local function needs_update(lang)
  local revision = get_revision(lang)
  return not revision or revision ~= get_installed_revision(lang)
end

function M.info()
  local installed = config.installed_parsers()
  local parser_list = parsers.get_available()
  table.sort(parser_list)

  local max_len = 0
  for _, lang in pairs(parser_list) do
    if #lang > max_len then
      max_len = #lang
    end
  end

  for _, lang in pairs(parser_list) do
    local parser = (lang .. string.rep(' ', max_len - #lang + 1))
    local output
    if vim.list_contains(installed, lang) then
      output = { parser .. '[✓] installed', 'DiagnosticOk' }
    elseif #api.nvim_get_runtime_file('parser/' .. lang .. '.*', true) > 0 then
      output = { parser .. '[·] not installed (but available from runtimepath)', 'DiagnosticInfo' }
    else
      output = { parser .. '[✗] not installed' }
    end
    api.nvim_echo({ output }, false, {})
  end
end

--- @param cmd Command
local function run_command(cmd)
  if cmd.info then
    print(cmd.info)
  end

  if type(cmd.cmd) == 'function' then
    cmd.cmd()
    return
  end

  local cmd1 = { cmd.cmd }
  if cmd.opts and cmd.opts.args then
    vim.list_extend(cmd1, cmd.opts.args)
  end

  local r = job.run(cmd1, {
    cwd = (cmd.opts or {}).cwd,
  })
  a.main()

  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error(cmd.err .. ': ' .. vim.inspect(r.stderr))
  end
end

---
--- PARSER MANAGEMENT FUNCTIONS
---

---@param lang string
---@param cache_dir string
---@param install_dir string
---@param force boolean
---@param with_sync boolean
---@param generate_from_grammar boolean
local function install_lang(lang, cache_dir, install_dir, force, with_sync, generate_from_grammar)
  if vim.list_contains(config.installed_parsers(), lang) then
    if not force then
      local yesno =
        vim.fn.input(lang .. ' parser already available: would you like to reinstall ? y/n: ')
      print('\n ')
      if yesno:sub(1, 1) ~= 'y' then
        return
      end
    end
  end

  local repo = get_parser_install_info(lang)

  local project_name = 'tree-sitter-' .. lang
  local maybe_local_path = fs.normalize(repo.url)
  local from_local_path = vim.fn.isdirectory(maybe_local_path) == 1
  if from_local_path then
    repo.url = maybe_local_path
  end

  ---@type string compile_location only needed for typescript installs.
  local compile_location
  if from_local_path then
    compile_location = repo.url
    if repo.location then
      compile_location = fs.joinpath(compile_location, repo.location)
    end
  else
    local repo_location = project_name
    if repo.location then
      repo_location = fs.joinpath(repo_location, repo.location)
    end
    compile_location = fs.joinpath(cache_dir, repo_location)
  end
  local parser_lib_name = fs.joinpath(install_dir, lang) .. '.so'

  generate_from_grammar = repo.requires_generate_from_grammar or generate_from_grammar

  if generate_from_grammar and vim.fn.executable('tree-sitter') ~= 1 then
    api.nvim_err_writeln('tree-sitter CLI not found: `tree-sitter` is not executable')
    if repo.requires_generate_from_grammar then
      api.nvim_err_writeln(
        'tree-sitter CLI is needed because the parser for `'
          .. lang
          .. '` needs to be generated from grammar'
      )
    end
    return
  else
    if not M.ts_generate_args then
      M.ts_generate_args = { 'generate', '--abi', vim.treesitter.language_version }
    end
  end
  if generate_from_grammar and vim.fn.executable('node') ~= 1 then
    api.nvim_err_writeln('Node JS not found: `node` is not executable')
    return
  end
  local cc = shell.select_executable(M.compilers)
  if not cc then
    api.nvim_err_writeln(
      'No C compiler found! "'
        .. table.concat(
          vim.tbl_filter(function(c) ---@param c string
            return type(c) == 'string'
          end, M.compilers),
          '", "'
        )
        .. '" are not executable.'
    )
    return
  end

  local revision = repo.revision
  if not revision then
    revision = get_revision(lang)
  end

  ---@class Command
  ---@field cmd string
  ---@field info string
  ---@field err string
  ---@field opts CmdOpts

  ---@class CmdOpts
  ---@field args string[]
  ---@field cwd string

  if not from_local_path then
    vim.fn.delete(fs.joinpath(cache_dir, project_name), 'rf')

    local dlcmds =
      shell.select_download_commands(repo, project_name, cache_dir, revision, M.prefer_git)
    for _, cmd in ipairs(dlcmds) do
      run_command(cmd)
    end
  end

  if generate_from_grammar then
    if repo.generate_requires_npm then
      if vim.fn.executable('npm') ~= 1 then
        api.nvim_err_writeln('`' .. lang .. '` requires NPM to be installed from grammar.js')
        return
      end

      print('Installing NPM dependencies of ' .. lang .. ' parser')
      local r = job.run({ 'npm', 'install' }, { cwd = compile_location })
      a.main()
      if r.exit_code > 0 then
        failed_commands = failed_commands + 1
        finished_commands = finished_commands + 1
        error(
          'Error during `npm install` (required for parser generation of '
            .. lang
            .. ' with npm dependencies)'
        )
      end
    end

    local tscmd = { vim.fn.exepath('tree-sitter') }
    vim.list_extend(tscmd, M.ts_generate_args)

    print('Generating source files from grammar.js...')

    local r = job.run(tscmd, { cwd = compile_location })
    a.main()
    if r.exit_code > 0 then
      failed_commands = failed_commands + 1
      finished_commands = finished_commands + 1
      error('Error during "tree-sitter generate"')
    end
  end

  run_command(shell.select_compile_command(repo, cc, compile_location))

  local copyfile = a.wrap(uv.fs_copyfile, 4)

  local err = copyfile(fs.joinpath(compile_location, 'parser.so'), parser_lib_name)
  a.main()
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error(err)
  end

  local file = assert(
    io.open(fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision'), 'w')
  )
  file:write(revision or '')
  file:close()

  if not from_local_path then
    vim.fn.delete(fs.joinpath(cache_dir, project_name), 'rf')
  end

  if with_sync then
    -- TODO(lewis6991): sync support
    print('No sync support yet')
  else
    print('Parser for ' .. lang .. ' has been installed')
  end
end

---@class InstallOptions
---@field with_sync boolean
---@field force boolean
---@field generate_from_grammar boolean
---@field skip table

local unlink = a.wrap(uv.fs_unlink, 2)
local symlink = a.wrap(uv.fs_symlink, 4)

-- Install a parser
---@param languages? string[]|string
---@param options? InstallOptions
M.install = a.sync(function(languages, options)
  options = options or {}
  local with_sync = options.with_sync
  local force = options.force
  local generate_from_grammar = options.generate_from_grammar
  local skip = options.skip

  reset_progress_counter()

  if vim.fn.executable('git') == 0 then
    api.nvim_err_writeln('Git is required on your system to run this command')
    return
  end

  local cache_dir = vim.fn.stdpath('cache')
  local install_dir = config.get_install_dir('parser')

  if languages == 'all' then
    force = true
  end

  languages = config.norm_languages(languages, skip)

  local tasks = {}
  for _, lang in ipairs(languages) do
    tasks[#tasks + 1] = a.sync(function()
      install_lang(lang, cache_dir, install_dir, force, with_sync, generate_from_grammar)
      local err = symlink(
        shell.get_package_path('runtime', 'queries', lang),
        fs.joinpath(config.get_install_dir('queries'), lang),
        { dir = true, junction = true }
      )
      if err then
        error(err)
      end
    end)
  end

  a.join(max_jobs, nil, tasks)
end, 2)

---@class UpdateOptions
---@field with_sync boolean

---@param languages? string[]|string
---@param options? UpdateOptions
M.update = a.sync(function(languages, options)
  options = options or {}

  reset_progress_counter()
  M.lockfile = {}

  languages = config.norm_languages(languages or 'all', { ignored = true, missing = true })
  languages = vim.iter.filter(needs_update, languages) --- @type string[]

  if #languages > 0 then
    M.install(languages, {
      force = true,
      with_sync = options.with_sync,
    })
  else
    print('All parsers are up-to-date')
  end
end, 2)

--- @param lang string
--- @param parser string
--- @param queries string
local uninstall = a.sync(function(lang, parser, queries)
  if vim.fn.filereadable(parser) ~= 1 then
    return
  end

  local perr = unlink(parser)

  if perr then
    vim.schedule(function()
      error(perr)
    end)
  end

  local qerr = unlink(queries)

  if qerr then
    vim.schedule(function()
      error(qerr)
    end)
  end

  print('Parser for ' .. lang .. ' has been uninstalled')
end, 3)

--- @param languages string[]|string
M.uninstall = a.sync(function(languages)
  reset_progress_counter()

  languages = config.norm_languages(languages or 'all', { missing = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  local tasks = {}
  for _, lang in ipairs(languages) do
    if not vim.list_contains(installed, lang) then
      print('Parser for ' .. lang .. ' is is not managed by nvim-treesitter', vim.log.levels.ERROR)
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.curry(uninstall, lang, parser, queries)
    end
  end

  a.join(max_jobs, nil, tasks)
end, 1)

return M
