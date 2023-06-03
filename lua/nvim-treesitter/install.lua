local api = vim.api
local fs = vim.fs
local uv = vim.uv

local a = require('nvim-treesitter.async')
local config = require('nvim-treesitter.config')
local job = require('nvim-treesitter.job')
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

---@class LockfileInfo
---@field revision string

---@type table<string, LockfileInfo>
local lockfile = {}

local max_jobs = 50

local iswin = uv.os_uname().sysname == 'Windows_NT'
local ismac = uv.os_uname().sysname == 'Darwin'

--- @diagnostic disable-next-line:missing-parameter
M.compilers = { uv.os_getenv('CC'), 'cc', 'gcc', 'clang', 'cl', 'zig' }

---
--- PARSER INFO
---

---@param lang string
---@param validate? boolean
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

--- @param ... string
--- @return string
function M.get_package_path(...)
  return fs.joinpath(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

---@param lang string
---@return string?
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
---@return string?
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
    vim.tbl_filter(
      ---@param c string
      ---@return boolean
      function(c)
        return type(c) == 'string'
      end,
      M.compilers
    ),
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
    logger:error(
      'Error during download, please verify your internet connection: ' .. vim.inspect(r.stderr)
    )
  end

  logger:debug('Creating temporary directory: ' .. temp_dir)
  --TODO(clason): use vim.fn.mkdir(temp_dir, 'p') in case stdpath('cache') is not created
  local err = uv_mkdir(temp_dir, 493)
  a.main()
  if err then
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
    logger:error('Error during tarball extraction: ' .. vim.inspect(r.stderr))
  end

  err = uv_unlink(project_dir .. '.tar.gz')
  if err then
    logger:error('Could not remove tarball: ' .. err)
  end
  a.main()

  err = uv_rename(fs.joinpath(temp_dir, url:match('[^/]-$') .. '-' .. dir_rev), project_dir)
  a.main()

  if err then
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
    logger:error('Error while checking out revision: ' .. vim.inspect(r.stderr))
  end
end

---@param executables string[]
---@return string?
function M.select_executable(executables)
  return vim.tbl_filter(
    ---@param c string
    ---@return boolean
    function(c)
      return c ~= vim.NIL and vim.fn.executable(c) == 1
    end,
    executables
  )[1]
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
    #vim.tbl_filter(
      --- @param file string
      --- @return boolean
      function(file)
        local ext = vim.fn.fnamemodify(file, ':e')
        return ext == 'cc' or ext == 'cpp' or ext == 'cxx'
      end,
      repo.files
    ) > 0
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

  local logger = log.new('install/' .. lang)
  local err

  local repo = get_parser_install_info(lang)
  if repo then
    local cc = M.select_executable(M.compilers)
    if not cc then
      cc_err()
      return
    end

    local project_name = 'tree-sitter-' .. lang

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
      logger:error('Error during compilation: ' .. vim.inspect(r.stderr))
    end

    local parser_lib_name = fs.joinpath(install_dir, lang) .. '.so'

    err = uv_copyfile(fs.joinpath(compile_location, 'parser.so'), parser_lib_name)
    a.main()
    if err then
      logger:error(err)
    end

    local revfile = fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision')
    util.write_file(revfile, revision or '')

    if not from_local_path then
      util.delete(fs.joinpath(cache_dir, project_name))
    end
  end

  local queries = fs.joinpath(config.get_install_dir('queries'), lang)
  local queries_src = M.get_package_path('runtime', 'queries', lang)
  uv_unlink(queries)
  err = uv_symlink(queries_src, queries, { dir = true, junction = true })
  a.main()
  if err then
    logger:error(err)
  end
  logger:info('Language installed')
end

--- Throttles a function using the first argument as an ID
---
--- If function is already running then the function will be scheduled to run
--- again once the running call has finished.
---
---   fn#1        _/‾\__/‾\_/‾\_____________________________
---   throttled#1 _/‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\/‾‾‾‾‾‾‾‾‾‾\____________
--
---   fn#2        ______/‾\___________/‾\___________________
---   throttled#2 ______/‾‾‾‾‾‾‾‾‾‾\__/‾‾‾‾‾‾‾‾‾‾\__________
---
---
--- @generic F: function
--- @param fn F Function to throttle
--- @return F throttled function.
local function throttle_by_id(fn)
  local scheduled = {} --- @type table<any,boolean>
  local running = {} --- @type table<any,boolean>
  return function(id, ...)
    if scheduled[id] then
      -- If fn is already scheduled, then drop
      return
    end
    if not running[id] then
      scheduled[id] = true
    end
    if running[id] then
      return
    end
    while scheduled[id] do
      scheduled[id] = nil
      running[id] = true
      fn(id, ...)
      running[id] = nil
    end
  end
end

-- Async functions must not be interleaved
local install_lang_throttled = throttle_by_id(install_lang)

---@class InstallOptions
---@field force boolean
---@field generate_from_grammar boolean
---@field skip table

--- Install a parser
--- @param languages? string[]|string
--- @param options? InstallOptions
--- @param _callback? fun()
local function install(languages, options, _callback)
  options = options or {}
  local force = options.force
  local generate_from_grammar = options.generate_from_grammar
  local skip = options.skip

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
      install_lang_throttled(lang, cache_dir, install_dir, force, generate_from_grammar)
      done = done + 1
    end)
  end

  a.join(max_jobs, nil, tasks)
  if #tasks > 1 then
    a.main()
    log.info('Installed %d/%d languages', done, #tasks)
  end
end

M.install = a.sync(install, 2)

---@class UpdateOptions

---@param languages? string[]|string
---@param _options? UpdateOptions
---@param _callback function
M.update = a.sync(function(languages, _options, _callback)
  M.lockfile = {}

  if not languages or #languages == 0 then
    languages = 'all'
  end
  languages = config.norm_languages(languages, { ignored = true, missing = true })
  languages = vim.iter.filter(needs_update, languages) --- @type string[]

  if #languages > 0 then
    install(languages, { force = true })
  else
    log.info('All parsers are up-to-date')
  end
end, 2)

--- @param lang string
--- @param parser string
--- @param queries string
local function uninstall_lang(lang, parser, queries)
  local logger = log.new('uninstall/' .. lang)
  logger:debug('Uninstalling ' .. lang)

  if vim.fn.filereadable(parser) == 1 then
    logger:debug('Unlinking ' .. parser)
    local perr = uv_unlink(parser)
    a.main()

    if perr then
      log.error(perr)
    end
  end

  if vim.fn.isdirectory(queries) == 1 then
    logger:debug('Unlinking ' .. queries)
    local qerr = uv_unlink(queries)
    a.main()

    if qerr then
      logger:error(qerr)
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
    if not vim.list_contains(installed, lang) then
      log.warn('Parser for ' .. lang .. ' is is not managed by nvim-treesitter')
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.sync(function()
        uninstall_lang(lang, parser, queries)
        done = done + 1
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
