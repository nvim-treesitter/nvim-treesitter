local api = vim.api
local fs = vim.fs
local uv = vim.loop

local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')

local a = require('nvim-treesitter.async')
local job = require('nvim-treesitter.job')
local util = require('nvim-treesitter.util')
local log = require('nvim-treesitter.log')

local uv_copyfile = a.wrap(uv.fs_copyfile, 4)
local uv_mkdir = a.wrap(uv.fs_mkdir, 3)
local uv_rename = a.wrap(uv.fs_rename, 3)
local uv_symlink = a.wrap(uv.fs_symlink, 4)
local uv_unlink = a.wrap(uv.fs_unlink, 2)

local M = {}

---@class LockfileInfo
---@field revision string

---@type table<string, LockfileInfo>
local lockfile = {}

local max_jobs = 50

local iswin = uv.os_uname().sysname == 'Windows_NT'
local ismac = uv.os_uname().sysname == 'Darwin'

M.compilers = { uv.os_getenv('CC'), 'cc', 'gcc', 'clang', 'cl', 'zig' }

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
    log.error('Parser not available for language "' .. lang .. '"')
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

function M.get_package_path(...)
  return fs.joinpath(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

---@param lang string
---@return string|nil
local function get_target_revision(lang)
  if #lockfile == 0 then
    local filename = M.get_package_path('lockfile.json')
    lockfile = vim.json.decode(util.read_file(filename)) --[[@as table<string, LockfileInfo>]]
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
  return util.read_file(lang_file)
end

---@param lang string
---@return boolean
local function needs_update(lang)
  local revision = get_target_revision(lang)
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
    local output --- @type string[]
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

---
--- PARSER MANAGEMENT FUNCTIONS
---

--- @param repo InstallInfo
--- @param project_name string
--- @param cache_dir string
--- @param from_local_path boolean
--- @return string
local function get_compile_location(repo, cache_dir, project_name, from_local_path)
  ---@type string compile_location only needed for typescript installs.
  if from_local_path then
    local compile_location = repo.url
    if repo.location then
      compile_location = fs.joinpath(compile_location, repo.location)
    end
    return compile_location
  end

  local repo_location = project_name
  if repo.location then
    repo_location = fs.joinpath(repo_location, repo.location)
  end
  return fs.joinpath(cache_dir, repo_location)
end

local function cc_err()
  log.error('No C compiler found! "' .. table.concat(
    vim.tbl_filter(function(c) ---@param c string
      return type(c) == 'string'
    end, M.compilers),
    '", "'
  ) .. '" are not executable.')
end

--- @param logger Logger
--- @param repo InstallInfo
--- @param compile_location string
local function do_generate_from_grammar(logger, repo, compile_location)
  if repo.generate_requires_npm then
    if vim.fn.executable('npm') ~= 1 then
      logger:error('NPM requires to be installed from grammar.js')
    end

    logger:info('Installing NPM dependencies')
    local r = job.run({ 'npm', 'install' }, { cwd = compile_location })
    a.main()
    if r.exit_code > 0 then
      failed_commands = failed_commands + 1
      finished_commands = finished_commands + 1
      logger:error('Error during `npm install`')
    end
  end

  logger:info('Generating source files from grammar.js...')

  local r = job.run({
    vim.fn.exepath('tree-sitter'),
    'generate',
    '--abi',
    tostring(vim.treesitter.language_version),
  }, { cwd = compile_location })
  a.main()
  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Error during "tree-sitter generate"')
  end
end

---@param logger Logger
---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
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

  local r = job.run({
    'curl',
    '--silent',
    '-L', -- follow redirects
    target,
    '--output',
    project_name .. '.tar.gz',
  }, {
    cwd = cache_dir,
  })
  a.main()
  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error(
      'Error during download, please verify your internet connection: ' .. vim.inspect(r.stderr)
    )
  end

  logger:debug('Creating temporary directory: ' .. temp_dir)
  --TODO(clason): use vim.fn.mkdir(temp_dir, 'p') in case stdpath('cache') is not created
  local err = uv_mkdir(temp_dir, 493)
  a.main()
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Could not create %s-tmp: %s', project_name, err)
  end

  logger:info('Extracting ' .. project_name .. '...')
  r = job.run({
    'tar',
    '-xzf',
    project_name .. '.tar.gz',
    '-C',
    project_name .. '-tmp',
  }, {
    cwd = cache_dir,
  })

  a.main()
  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Error during tarball extraction: ' .. vim.inspect(r.stderr))
  end

  err = uv_unlink(project_dir .. '.tar.gz')
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Could not remove tarball: ' .. err)
  end
  a.main()

  err = uv_rename(fs.joinpath(temp_dir, url:match('[^/]-$') .. '-' .. dir_rev), project_dir)
  a.main()

  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Could not rename temp: ' .. err)
  end

  util.delete(temp_dir)
end

---@param logger Logger
---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
local function do_download_git(logger, repo, project_name, cache_dir, revision, project_dir)
  logger:info('Downloading ' .. project_name .. '...')

  local r = job.run({
    'git',
    'clone',
    '--filter=blob:none',
    repo.url,
    project_name,
  }, {
    cwd = cache_dir,
  })

  a.main()

  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error(
      'Error during download, please verify your internet connection: ' .. vim.inspect(r.stderr)
    )
  end

  logger:info('Checking out locked revision')
  r = job.run({
    'git',
    'checkout',
    revision,
  }, {
    cwd = project_dir,
  })

  a.main()

  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Error while checking out revision: ' .. vim.inspect(r.stderr))
  end
end

---@param executables string[]
---@return string|nil
function M.select_executable(executables)
  return vim.tbl_filter(function(c) ---@param c string
    return c ~= vim.NIL and vim.fn.executable(c) == 1
  end, executables)[1]
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
      '/LD',
    }
  end

  if compiler:find('zig$') or compiler:find('zig.exe$') then
    return {
      'c++',
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

  if
    #vim.tbl_filter(function(file) ---@param file string
      local ext = vim.fn.fnamemodify(file, ':e')
      return ext == 'cc' or ext == 'cpp' or ext == 'cxx'
    end, repo.files) > 0
  then
    table.insert(args, '-lstdc++')
  end

  if not iswin then
    table.insert(args, '-fPIC')
  end

  return args
end

---@param repo InstallInfo
---@return boolean
local function can_download_tar(repo)
  local can_use_tar = vim.fn.executable('tar') == 1 and vim.fn.executable('curl') == 1
  local is_github = repo.url:find('github.com', 1, true)
  local is_gitlab = repo.url:find('gitlab.com', 1, true)
  return can_use_tar and (is_github or is_gitlab) and not iswin
end

-- Returns the compile command based on the OS and user options
---@param repo InstallInfo
---@param cc string
---@param compile_location string
---@return JobResult
local function do_compile(repo, cc, compile_location)
  local make = M.select_executable({ 'gmake', 'make' })

  local cmd --- @type string[]
  if cc:find('cl$') or cc:find('cl.exe$') or not repo.use_makefile or iswin or not make then
    local args = vim.tbl_flatten(select_compiler_args(repo, cc))
    cmd = vim.list_extend({ cc }, args)
  else
    cmd = {
      make,
      '--makefile=' .. M.get_package_path('scripts', 'compile_parsers.makefile'),
      'CC=' .. cc,
    }
  end

  local r = job.run(cmd, { cwd = compile_location })
  a.main()
  return r
end

---@param lang string
---@param cache_dir string
---@param install_dir string
---@param force boolean
---@param generate_from_grammar boolean
local function install_lang(lang, cache_dir, install_dir, force, generate_from_grammar)
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

  local cc = M.select_executable(M.compilers)
  if not cc then
    cc_err()
    return
  end

  local repo = get_parser_install_info(lang)

  local project_name = 'tree-sitter-' .. lang

  local logger = log.new('install/' .. lang)

  generate_from_grammar = repo.requires_generate_from_grammar or generate_from_grammar

  if generate_from_grammar and vim.fn.executable('tree-sitter') ~= 1 then
    logger:error('tree-sitter CLI not found: `tree-sitter` is not executable')
  end

  if generate_from_grammar and vim.fn.executable('node') ~= 1 then
    logger:error('Node JS not found: `node` is not executable')
  end

  local revision = repo.revision or get_target_revision(lang)

  local maybe_local_path = fs.normalize(repo.url)
  local from_local_path = vim.fn.isdirectory(maybe_local_path) == 1
  if from_local_path then
    repo.url = maybe_local_path
  end

  if not from_local_path then
    util.delete(fs.joinpath(cache_dir, project_name))
    local project_dir = fs.joinpath(cache_dir, project_name)

    revision = revision or repo.branch or 'master'

    if can_download_tar(repo) then
      do_download_tar(logger, repo, project_name, cache_dir, revision, project_dir)
    else
      do_download_git(logger, repo, project_name, cache_dir, revision, project_dir)
    end
  end

  local compile_location = get_compile_location(repo, cache_dir, project_name, from_local_path)

  if generate_from_grammar then
    do_generate_from_grammar(logger, repo, compile_location)
  end

  logger:info('Compiling parser')
  local r = do_compile(repo, cc, compile_location)
  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error('Error during compilation: ' .. vim.inspect(r.stderr))
  end

  local parser_lib_name = fs.joinpath(install_dir, lang) .. '.so'

  local err = uv_copyfile(fs.joinpath(compile_location, 'parser.so'), parser_lib_name)
  a.main()
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    logger:error(err)
  end

  local revfile = fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision')
  util.write_file(revfile, revision or '')

  if not from_local_path then
    util.delete(fs.joinpath(cache_dir, project_name))
  end

  logger:info('Parser installed')
end

---@class InstallOptions
---@field with_sync boolean
---@field force boolean
---@field generate_from_grammar boolean
---@field skip table

-- Install a parser
---@param languages? string[]|string
---@param options? InstallOptions
M.install = a.sync(function(languages, options)
  options = options or {}
  local with_sync = options.with_sync
  local force = options.force
  local generate_from_grammar = options.generate_from_grammar
  local skip = options.skip

  if with_sync then
    -- TODO(lewis6991): sync support
    log.warn('No sync support yet')
    return
  end

  reset_progress_counter()

  if vim.fn.executable('git') == 0 then
    log.error('Git is required on your system to run this command')
    return
  end

  local cache_dir = vim.fn.stdpath('cache')
  local install_dir = config.get_install_dir('parser')

  if not languages or type(languages) == 'string' then
    languages = { languages }
  end

  if languages[1] == 'all' then
    force = true
  end

  languages = config.norm_languages(languages, skip)

  local tasks = {} --- @type fun()[]
  local done = 0
  for _, lang in ipairs(languages) do
    tasks[#tasks + 1] = a.sync(function()
      a.main()
      install_lang(lang, cache_dir, install_dir, force, generate_from_grammar)
      local queries = fs.joinpath(config.get_install_dir('queries'), lang)
      local queries_src = M.get_package_path('runtime', 'queries', lang)
      uv_unlink(queries)
      local err = uv_symlink(queries_src, queries, { dir = true, junction = true })
      if err then
        log.error(err)
      end
      done = done + 1
    end)
  end

  if #tasks == 1 then
    tasks[1]()
  else
    a.join(max_jobs, nil, tasks)
    a.main()
    log.info('Installed %d/%d parsers', done, #tasks)
  end
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
    log.info('All parsers are up-to-date')
  end
end, 2)

--- @param lang string
--- @param parser string
--- @param queries string
local function uninstall(lang, parser, queries)
  local logger = log.new('uninstall/' .. lang)
  logger:debug('Uninstalling ' .. lang)
  if vim.fn.filereadable(parser) ~= 1 then
    return
  end

  logger:debug('Unlinking ' .. parser)
  local perr = uv_unlink(parser)
  a.main()

  if perr then
    log.error(perr)
  end

  logger:debug('Unlinking ' .. queries)
  local qerr = uv_unlink(queries)
  a.main()

  if qerr then
    logger:error(qerr)
  end

  logger:info('Parser uninstalled')
end

--- @param languages string[]|string
M.uninstall = a.sync(function(languages)
  reset_progress_counter()

  languages = config.norm_languages(languages or 'all', { missing = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  local tasks = {} --- @type fun()[]
  local done = 0
  for _, lang in ipairs(languages) do
    if not vim.list_contains(installed, lang) then
      log.warn('Parser for ' .. lang .. ' is is not managed by nvim-treesitter')
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.sync(function()
        uninstall(lang, parser, queries)
        done = done + 1
      end)
    end
  end

  if #tasks == 1 then
    tasks[1]()
  else
    a.join(max_jobs, nil, tasks)
    a.main()
    log.info('Uninstalled %d/%d parsers', done, #tasks)
  end
end, 1)

return M
