local fn = vim.fn
local fs = vim.fs
local uv = vim.uv

local a = require('nvim-treesitter.async')
local config = require('nvim-treesitter.config')
local log = require('nvim-treesitter.log')
local parsers = require('nvim-treesitter.parsers')
local util = require('nvim-treesitter.util')

--- @type fun(path: string, new_path: string, flags?: table): string?
local uv_copyfile = a.wrap(uv.fs_copyfile, 4)

--- @type fun(path: string, mode: integer): string?
local uv_mkdir = a.wrap(uv.fs_mkdir, 3)

--- @type fun(path: string, new_path: string): string?
local uv_rename = a.wrap(uv.fs_rename, 3)

--- @type fun(path: string, new_path: string, flags?: table): string?
local uv_symlink = a.wrap(uv.fs_symlink, 4)

--- @type fun(path: string): string?
local uv_unlink = a.wrap(uv.fs_unlink, 2)

local M = {}

local max_jobs = 10

local iswin = uv.os_uname().sysname == 'Windows_NT'
local ismac = uv.os_uname().sysname == 'Darwin'

--- @diagnostic disable-next-line:missing-parameter
M.compilers = { 'cc', 'gcc', 'clang', 'cl', 'zig' }
if uv.os_getenv('CC') then
  table.insert(M.compilers, 1, uv.os_getenv('CC'))
end

local function system(cmd, opts)
  log.trace('running job: (cwd=%s) %s', opts.cwd, table.concat(cmd, ' '))
  local r = a.wrap(vim.system, 3)(cmd, opts) --[[@as vim.SystemCompleted]]
  a.main()
  if r.stdout and r.stdout ~= '' then
    log.trace('stdout -> %s', r.stdout)
  end
  if r.stderr and r.stderr ~= '' then
    log.trace('stderr -> %s', r.stderr)
  end

  return r
end

---
--- PARSER INFO
---

---@param lang string
---@return InstallInfo?
local function get_parser_install_info(lang)
  local parser_config = parsers[lang]

  if not parser_config then
    log.error('Parser not available for language "' .. lang .. '"')
  end

  return parser_config.install_info
end

--- @param ... string
--- @return string
function M.get_package_path(...)
  return fs.joinpath(fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

---@param lang string
---@return string?
local function get_installed_revision(lang)
  local lang_file = fs.joinpath(config.get_install_dir('parser-info'), lang .. '.revision')
  return util.read_file(lang_file)
end

---@param lang string
---@return boolean
local function needs_update(lang)
  local info = get_parser_install_info(lang)
  if info and info.revision then
    return info.revision ~= get_installed_revision(lang)
  end

  -- No revision. Check the queries link to the same place

  local queries = fs.joinpath(config.get_install_dir('queries'), lang)
  local queries_src = M.get_package_path('runtime', 'queries', lang)

  return uv.fs_realpath(queries) ~= uv.fs_realpath(queries_src)
end

---
--- PARSER MANAGEMENT FUNCTIONS
---

local function istring(c)
  return type(c) == 'string'
end

local function cc_err()
  log.error(
    'No C compiler found! "'
      .. table.concat(vim.tbl_filter(istring, M.compilers), '", "')
      .. '" are not executable.'
  )
end

--- @param x string
--- @return boolean
local function executable(x)
  return fn.executable(x) == 1
end

--- @param logger Logger
--- @param repo InstallInfo
--- @param compile_location string
--- @return string? err
local function do_generate(logger, repo, compile_location)
  if not executable('tree-sitter') then
    return logger:error('tree-sitter CLI not found: `tree-sitter` is not executable')
  end

  logger:info(
    string.format(
      'Generating parser.c from %s...',
      repo.generate_from_json and 'grammar.json' or 'grammar.js'
    )
  )

  local r = system({
    fn.exepath('tree-sitter'),
    'generate',
    '--no-bindings',
    '--abi',
    tostring(vim.treesitter.language_version),
    repo.generate_from_json and 'src/grammar.json',
  }, { cwd = compile_location })
  if r.code > 0 then
    return logger:error('Error during "tree-sitter generate": %s', r.stderr)
  end
end

---@param logger Logger
---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
---@return string? err
local function do_download_tar(logger, repo, project_name, cache_dir, revision, project_dir)
  local is_github = repo.url:find('github.com', 1, true)
  local url = repo.url:gsub('.git$', '')

  local dir_rev = revision
  if is_github and revision:find('^v%d') then
    dir_rev = revision:sub(2)
  end

  local temp_dir = project_dir .. '-tmp'

  util.delete(temp_dir)

  logger:info('Downloading ' .. project_name .. '...')
  local target = is_github and url .. '/archive/' .. revision .. '.tar.gz'
    or url .. '/-/archive/' .. revision .. '/' .. project_name .. '-' .. revision .. '.tar.gz'

  local r = system({
    'curl',
    '--silent',
    '-L', -- follow redirects
    target,
    '--output',
    project_name .. '.tar.gz',
  }, {
    cwd = cache_dir,
  })
  if r.code > 0 then
    return logger:error(
      'Error during download, please verify your internet connection: %s',
      r.stderr
    )
  end

  logger:debug('Creating temporary directory: ' .. temp_dir)
  --TODO(clason): use fn.mkdir(temp_dir, 'p') in case stdpath('cache') is not created
  local err = uv_mkdir(temp_dir, 493)
  a.main()
  if err then
    return logger:error('Could not create %s-tmp: %s', project_name, err)
  end

  logger:info('Extracting ' .. project_name .. '...')
  r = system({
    'tar',
    '-xzf',
    project_name .. '.tar.gz',
    '-C',
    project_name .. '-tmp',
  }, {
    cwd = cache_dir,
  })

  if r.code > 0 then
    return logger:error('Error during tarball extraction: %s', r.stderr)
  end

  err = uv_unlink(project_dir .. '.tar.gz')
  if err then
    return logger:error('Could not remove tarball: %s', err)
  end
  a.main()

  err = uv_rename(fs.joinpath(temp_dir, url:match('[^/]-$') .. '-' .. dir_rev), project_dir)
  a.main()

  if err then
    return logger:error('Could not rename temp: %s', err)
  end

  util.delete(temp_dir)
end

---@param logger Logger
---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
---@return string? err
local function do_download_git(logger, repo, project_name, cache_dir, revision, project_dir)
  if not executable('git') then
    return logger:error('git not found!')
  end

  logger:info('Downloading ' .. project_name .. '...')

  local r = system({
    'git',
    'clone',
    '--filter=blob:none',
    repo.url,
    project_name,
  }, {
    cwd = cache_dir,
  })

  if r.code > 0 then
    return logger:error('Error during download, please verify your internet connection: ', r.stderr)
  end

  logger:info('Checking out locked revision')
  r = system({
    'git',
    'checkout',
    revision,
  }, {
    cwd = project_dir,
  })

  if r.code > 0 then
    return logger:error('Error while checking out revision: %s', r.stderr)
  end
end

--- @type table<string,table<string,boolean>>
local cc_args_cache = vim.defaulttable()

--- @param cc string
--- @param arg string
--- @return boolean
local function test_cc_arg(cc, arg)
  if cc_args_cache[cc][arg] == nil then
    cc_args_cache[cc][arg] = system({ cc, '-xc', '-', arg }, {
      stdin = 'int main(void) { return 0; }',
    }).code == 0
  end
  return cc_args_cache[cc][arg]
end

---@param executables string[]
---@return string?
function M.select_executable(executables)
  return vim.tbl_filter(executable, executables)[1]
end

-- Returns the compiler arguments based on the compiler and OS
---@param repo InstallInfo
---@param compiler string
---@return string[]
local function select_compiler_args(repo, compiler)
  if compiler:find('cl$') or compiler:find('cl.exe$') then
    return {
      '/Fe:',
      'parser.so',
      '/Isrc',
      repo.files,
      '-Os',
      '/utf-8',
      '/LD',
    }
  end

  if compiler:find('zig$') or compiler:find('zig.exe$') then
    return {
      'cc',
      '-o',
      'parser.so',
      repo.files,
      '-lc',
      '-Isrc',
      '-shared',
      '-Os',
    }
  end

  local args = {
    '-o',
    'parser.so',
    '-I./src',
    repo.files,
    '-Os',
    ismac and '-bundle' or '-shared',
  }

  --- @param arg string
  local function add_cc_arg(arg)
    if test_cc_arg(compiler, arg) then
      args[#args + 1] = arg
    end
  end

  if not iswin then
    add_cc_arg('-Wall')
    add_cc_arg('-Wextra')
    add_cc_arg('-fPIC')

    -- Make sure we don't compile in any unresolved symbols, otherwise nvim will
    -- just exit (not even crash)
    add_cc_arg('-Werror=implicit-function-declaration')
  end

  return args
end

---@param repo InstallInfo
---@return boolean
local function can_download_tar(repo)
  local can_use_tar = executable('tar') and executable('curl')
  local is_github = repo.url:find('github.com', 1, true) ~= nil
  local is_gitlab = repo.url:find('gitlab.com', 1, true) ~= nil
  return can_use_tar and (is_github or is_gitlab) and not iswin
end

-- Returns the compile command based on the OS and user options
---@param logger Logger
---@param repo InstallInfo
---@param cc string
---@param compile_location string
---@return string? err
local function do_compile(logger, repo, cc, compile_location)
  local args = vim.iter(select_compiler_args(repo, cc)):flatten():totable()
  local cmd = vim.list_extend({ cc }, args)

  logger:info('Compiling parser')

  local r = system(cmd, { cwd = compile_location })
  if r.code > 0 then
    return logger:error('Error during compilation: %s', r.stderr)
  end
end

---@param lang string
---@param cache_dir string
---@param install_dir string
---@param generate? boolean
---@return string? err
local function install_lang0(lang, cache_dir, install_dir, generate)
  local logger = log.new('install/' .. lang)

  local repo = get_parser_install_info(lang)
  if repo then
    local cc = M.select_executable(M.compilers)
    if not cc then
      cc_err()
      return
    end

    local project_name = 'tree-sitter-' .. lang

    local revision = repo.revision

    local compile_location ---@type string
    if repo.path then
      compile_location = fs.normalize(repo.path)
    else
      local project_dir = fs.joinpath(cache_dir, project_name)
      util.delete(project_dir)

      revision = revision or repo.branch or 'main'

      local do_download = can_download_tar(repo) and do_download_tar or do_download_git
      local err = do_download(logger, repo, project_name, cache_dir, revision, project_dir)
      if err then
        return err
      end
      compile_location = fs.joinpath(cache_dir, project_name)
    end

    if repo.location then
      compile_location = fs.joinpath(compile_location, repo.location)
    end

    do
      if repo.generate or generate then
        local err = do_generate(logger, repo, compile_location)
        if err then
          return err
        end
      end
    end

    do
      local err = do_compile(logger, repo, cc, compile_location)
      if err then
        return err
      end
    end

    local parser_lib_name = fs.joinpath(install_dir, lang) .. '.so'

    local err = uv_copyfile(fs.joinpath(compile_location, 'parser.so'), parser_lib_name)
    a.main()
    if err then
      return logger:error(err)
    end

    local revfile = fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision')
    util.write_file(revfile, revision or '')

    if not repo.path then
      util.delete(fs.joinpath(cache_dir, project_name))
    end
  end

  local queries = fs.joinpath(config.get_install_dir('queries'), lang)
  local queries_src = M.get_package_path('runtime', 'queries', lang)
  uv_unlink(queries)
  local err = uv_symlink(queries_src, queries, { dir = true, junction = true })
  a.main()
  if err then
    return logger:error(err)
  end
  logger:info('Language installed')
end

--- @alias InstallStatus
--- | 'installing'
--- | 'installed'
--- | 'failed'
--- | 'timeout'

local install_status = {} --- @type table<string,InstallStatus?>

local INSTALL_TIMEOUT = 60000

---@param lang string
---@param cache_dir string
---@param install_dir string
---@param force? boolean
---@param generate? boolean
---@return InstallStatus status
local function install_lang(lang, cache_dir, install_dir, force, generate)
  if not force and vim.list_contains(config.installed_parsers(), lang) then
    local yesno = fn.input(lang .. ' parser already available: would you like to reinstall ? y/n: ')
    print('\n ')
    if yesno:sub(1, 1) ~= 'y' then
      install_status[lang] = 'installed'
      return 'installed'
    end
  end

  if install_status[lang] then
    if install_status[lang] == 'installing' then
      vim.wait(INSTALL_TIMEOUT, function()
        return install_status[lang] ~= 'installing'
      end)
      install_status[lang] = 'timeout'
    end
  else
    install_status[lang] = 'installing'
    local err = install_lang0(lang, cache_dir, install_dir, generate)
    install_status[lang] = err and 'failed' or 'installed'
  end

  local status = install_status[lang]
  assert(status and status ~= 'installing')
  return status
end

--- Reload the parser table and user modifications in case of update
local function reload_parsers()
  package.loaded['nvim-treesitter.parsers'] = nil
  parsers = require('nvim-treesitter.parsers')
  vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
end

---@class InstallOptions
---@field force? boolean
---@field generate? boolean

--- Install a parser
--- @param languages string[]
--- @param options? InstallOptions
--- @param _callback? fun()
local function install(languages, options, _callback)
  options = options or {}

  local cache_dir = vim.fs.normalize(fn.stdpath('cache'))
  local install_dir = config.get_install_dir('parser')

  local tasks = {} --- @type fun()[]
  local done = 0
  for _, lang in ipairs(languages) do
    tasks[#tasks + 1] = a.sync(function()
      a.main()
      local status = install_lang(lang, cache_dir, install_dir, options.force, options.generate)
      if status ~= 'failed' then
        done = done + 1
      end
    end)
  end

  a.join(max_jobs, nil, tasks)
  if #tasks > 1 then
    a.main()
    log.info('Installed %d/%d languages', done, #tasks)
  end
end

M.install = a.sync(function(languages, options, _callback)
  reload_parsers()
  if not languages or #languages == 0 then
    languages = 'all'
  end

  languages = config.norm_languages(languages, options and options.skip)

  if languages[1] == 'all' then
    options.force = true
  end

  install(languages, options)
end, 2)

---@class UpdateOptions

---@param languages? string[]|string
---@param _options? UpdateOptions
---@param _callback function
M.update = a.sync(function(languages, _options, _callback)
  reload_parsers()
  if not languages or #languages == 0 then
    languages = 'all'
  end
  languages = config.norm_languages(languages, { ignored = true, missing = true })
  languages = vim.tbl_filter(needs_update, languages) --- @type string[]

  if #languages > 0 then
    install(languages, { force = true })
  else
    log.info('All parsers are up-to-date')
  end
end, 2)

--- @param logger Logger
--- @param lang string
--- @param parser string
--- @param queries string
--- @return string? err
local function uninstall_lang(logger, lang, parser, queries)
  logger:debug('Uninstalling ' .. lang)
  install_status[lang] = nil

  if vim.fn.filereadable(parser) == 1 then
    logger:debug('Unlinking ' .. parser)
    local perr = uv_unlink(parser)
    a.main()

    if perr then
      return logger:error(perr)
    end
  end

  if vim.fn.isdirectory(queries) == 1 then
    logger:debug('Unlinking ' .. queries)
    local qerr = uv_unlink(queries)
    a.main()

    if qerr then
      return logger:error(qerr)
    end
  end

  logger:info('Language uninstalled')
end

--- @param languages string[]|string
--- @param _options? UpdateOptions
--- @param _callback fun()
M.uninstall = a.sync(function(languages, _options, _callback)
  languages = config.norm_languages(languages or 'all', { missing = true, dependencies = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  local tasks = {} --- @type fun()[]
  local done = 0
  for _, lang in ipairs(languages) do
    local logger = log.new('uninstall/' .. lang)
    if not vim.list_contains(installed, lang) then
      log.warn('Parser for ' .. lang .. ' is is not managed by nvim-treesitter')
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.sync(function()
        local err = uninstall_lang(logger, lang, parser, queries)
        if not err then
          done = done + 1
        end
      end)
    end
  end

  a.join(max_jobs, nil, tasks)
  if #tasks > 1 then
    a.main()
    log.info('Uninstalled %d/%d languages', done, #tasks)
  end
end, 2)

return M
