local api = vim.api
local fs = vim.fs
local uv = vim.loop

local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')

local a = require('nvim-treesitter.async')
local job = require('nvim-treesitter.job')

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

local function get_package_path(...)
  return vim.fs.joinpath(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h'), ...)
end

---@param lang string
---@return string|nil
local function get_revision(lang)
  if #lockfile == 0 then
    local filename = get_package_path('lockfile.json')
    local file = assert(io.open(filename, 'r'))
    lockfile = vim.json.decode(file:read('*all')) --[[@as table<string, LockfileInfo>]]
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
end

--- @param repo InstallInfo
--- @param lang string
--- @param compile_location string
local function do_generate_from_grammar(repo, lang, compile_location)
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

  print('Generating source files from grammar.js...')

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
    error('Error during "tree-sitter generate"')
  end
end

---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
local function do_download_tar(repo, project_name, cache_dir, revision, project_dir)
  local is_github = repo.url:find('github.com', 1, true)
  local url = repo.url:gsub('.git$', '')

  local dir_rev = revision
  if is_github and revision:find('^v%d') then
    dir_rev = revision:sub(2)
  end

  local temp_dir = project_dir .. '-tmp'

  vim.fn.delete(temp_dir, 'rf')

  print('Downloading ' .. project_name .. '...')
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
    error(
      'Error during download, please verify your internet connection: ' .. vim.inspect(r.stderr)
    )
  end

  print('Creating temporary directory')
  --TODO(clason): use vim.fn.mkdir(temp_dir, 'p') in case stdpath('cache') is not created
  local err = a.wrap(uv.fs_mkdir, 3)(temp_dir, 493)
  a.main()
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error(string.format('Could not create %s-tmp: %s', project_name, err))
  end

  print('Extracting ' .. project_name .. '...')
  r = job.run({
    'tar',
    '-xvzf',
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
    error('Error during tarball extraction: ' .. vim.inspect(r.stderr))
  end

  err = a.wrap(uv.fs_unlink, 2)(project_dir .. '.tar.gz')
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error('Could not remove tarball: ' .. err)
  end
  a.main()

  err = a.wrap(uv.fs_rename, 3)(
    vim.fs.joinpath(temp_dir, url:match('[^/]-$') .. '-' .. dir_rev),
    project_dir
  )
  a.main()

  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error('Could not rename temp: ' .. err)
  end

  vim.fn.delete(temp_dir, 'rf')
end

---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string
---@param project_dir string
local function do_download_git(repo, project_name, cache_dir, revision, project_dir)
  print('Downloading ' .. project_name .. '...')

  local r = job.run({
    'git',
    'clone',
    repo.url,
    project_name,
  }, {
    cwd = cache_dir,
  })

  a.main()

  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error(
      'Error during download, please verify your internet connection: ' .. vim.inspect(r.stderr)
    )
  end

  print('Checking out locked revision')
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
    error('Error while checking out revision: ' .. vim.inspect(r.stderr))
  end
end

---@param executables string[]
---@return string|nil
local function select_executable(executables)
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
---@param project_name string
---@param cache_dir string
---@param revision string|nil
local function do_download(repo, project_name, cache_dir, revision)
  local can_use_tar = vim.fn.executable('tar') == 1 and vim.fn.executable('curl') == 1
  local is_github = repo.url:find('github.com', 1, true)
  local is_gitlab = repo.url:find('gitlab.com', 1, true)
  local project_dir = vim.fs.joinpath(cache_dir, project_name)

  revision = revision or repo.branch or 'master'

  if can_use_tar and (is_github or is_gitlab) and not iswin then
    do_download_tar(repo, project_name, cache_dir, revision, project_dir)
    return
  end

  do_download_git(repo, project_name, cache_dir, revision, project_dir)
end

-- Returns the compile command based on the OS and user options
---@param repo InstallInfo
---@param cc string
---@param compile_location string
local function do_compile(repo, cc, compile_location)
  local make = select_executable({ 'gmake', 'make' })

  print('Compiling...')

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

  if r.exit_code > 0 then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error('Error during compilation: ' .. vim.inspect(r.stderr))
  end
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

  local cc = select_executable(M.compilers)
  if not cc then
    cc_err()
    return
  end

  local repo = get_parser_install_info(lang)

  local project_name = 'tree-sitter-' .. lang

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
  end

  if generate_from_grammar and vim.fn.executable('node') ~= 1 then
    api.nvim_err_writeln('Node JS not found: `node` is not executable')
    return
  end

  local revision = repo.revision or get_revision(lang)

  local maybe_local_path = fs.normalize(repo.url)
  local from_local_path = vim.fn.isdirectory(maybe_local_path) == 1
  if from_local_path then
    repo.url = maybe_local_path
  end

  if not from_local_path then
    vim.fn.delete(fs.joinpath(cache_dir, project_name), 'rf')
    do_download(repo, project_name, cache_dir, revision)
  end

  local compile_location = get_compile_location(repo, cache_dir, project_name, from_local_path)

  if generate_from_grammar then
    do_generate_from_grammar(repo, lang, compile_location)
  end

  do_compile(repo, cc, compile_location)

  local copyfile = a.wrap(uv.fs_copyfile, 4)

  local parser_lib_name = fs.joinpath(install_dir, lang) .. '.so'

  local err = copyfile(fs.joinpath(compile_location, 'parser.so'), parser_lib_name)
  a.main()
  if err then
    failed_commands = failed_commands + 1
    finished_commands = finished_commands + 1
    error(err)
  end

  local revfile = fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision')
  local file = assert(io.open(revfile))
  file:write(revision or '')
  file:close()

  if not from_local_path then
    vim.fn.delete(fs.joinpath(cache_dir, project_name), 'rf')
  end

  print('Parser for ' .. lang .. ' has been installed')
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

  if with_sync then
    -- TODO(lewis6991): sync support
    print('No sync support yet')
    return
  end

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

  local tasks = {} --- @type fun()[]
  for _, lang in ipairs(languages) do
    tasks[#tasks + 1] = a.sync(function()
      install_lang(lang, cache_dir, install_dir, force, generate_from_grammar)
      local err = symlink(
        get_package_path('runtime', 'queries', lang),
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
local function uninstall(lang, parser, queries)
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
end

--- @param languages string[]|string
M.uninstall = a.sync(function(languages)
  reset_progress_counter()

  languages = config.norm_languages(languages or 'all', { missing = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  local tasks = {} --- @type fun()[]
  for _, lang in ipairs(languages) do
    if not vim.list_contains(installed, lang) then
      print('Parser for ' .. lang .. ' is is not managed by nvim-treesitter', vim.log.levels.ERROR)
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.sync(function()
        uninstall(lang, parser, queries)
      end)
    end
  end

  a.join(max_jobs, nil, tasks)
end, 1)

return M
