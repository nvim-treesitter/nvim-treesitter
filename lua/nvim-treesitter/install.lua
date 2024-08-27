local fn = vim.fn
local fs = vim.fs
local uv = vim.uv

local a = require('nvim-treesitter.async')
local config = require('nvim-treesitter.config')
local log = require('nvim-treesitter.log')
local parsers = require('nvim-treesitter.parsers')
local util = require('nvim-treesitter.util')

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_copyfile = a.wrap(uv.fs_copyfile, 4)

---@type fun(path: string, mode: integer): string?
local uv_mkdir = a.wrap(uv.fs_mkdir, 3)

---@type fun(path: string, new_path: string): string?
local uv_rename = a.wrap(uv.fs_rename, 3)

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_symlink = a.wrap(uv.fs_symlink, 4)

---@type fun(path: string): string?
local uv_unlink = a.wrap(uv.fs_unlink, 2)

local MAX_JOBS = 100
local INSTALL_TIMEOUT = 60000

---@async
---@param cmd string[]
---@param opts? vim.SystemOpts
---@return vim.SystemCompleted
local function system(cmd, opts)
  local cwd = opts and opts.cwd or uv.cwd()
  log.trace('running job: (cwd=%s) %s', cwd, table.concat(cmd, ' '))
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

---@async
---@param url string
---@param output string
---@return string? err
local function download_file(url, output)
  local r = system({
    'curl',
    '--silent',
    '--show-error',
    '-L', -- follow redirects
    url,
    '--output',
    output,
  })
  if r.code > 0 then
    return r.stderr
  end
end

---@async
---@param path string
---@param mode? string
---@return string? err
local function mkpath(path, mode)
  local parent = fs.dirname(path)
  if not parent:match('^[./]$') and not uv.fs_stat(parent) then
    mkpath(parent, mode)
  end

  return uv_mkdir(path, tonumber(mode or '755', 8))
end

local M = {}

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

---@param ... string
---@return string
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

---@async
---@param logger Logger
---@param repo InstallInfo
---@param compile_location string
---@return string? err
local function do_generate(logger, repo, compile_location)
  logger:info(
    string.format(
      'Generating parser.c from %s...',
      repo.generate_from_json and 'grammar.json' or 'grammar.js'
    )
  )

  local r = system({
    'tree-sitter',
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

---@async
---@param logger Logger
---@param url string
---@param project_name string
---@param cache_dir string
---@param revision string
---@param output_dir string
---@return string? err
local function do_download(logger, url, project_name, cache_dir, revision, output_dir)
  local is_gitlab = url:find('gitlab.com', 1, true)

  local tmp = output_dir .. '-tmp'

  util.delete(tmp)

  url = url:gsub('.git$', '')
  local target = is_gitlab
      and string.format('%s/-/archive/%s/%s-%s.tar.gz', url, revision, project_name, revision)
    or string.format('%s/archive/%s.tar.gz', url, revision)

  local tarball_path = fs.joinpath(cache_dir, project_name .. '.tar.gz')

  do -- Download tarball
    logger:info('Downloading %s...', project_name)
    local err = download_file(target, tarball_path)
    if err then
      return logger:error('Error during download: %s', err)
    end
  end

  do -- Create tmp dir
    logger:debug('Creating temporary directory: %s', tmp)
    local err = mkpath(tmp)
    a.main()
    if err then
      return logger:error('Could not create %s-tmp: %s', project_name, err)
    end
  end

  do -- Extract tarball
    logger:debug('Extracting %s into %s...', tarball_path, project_name)
    -- Windows tar can't handle drive letters
    local r = system(
      { 'tar', '-xzf', project_name .. '.tar.gz', '-C', project_name .. '-tmp' },
      { cwd = cache_dir }
    )
    if r.code > 0 then
      return logger:error('Error during tarball extraction: %s', r.stderr)
    end
  end

  do -- Remove tarball
    logger:debug('Removing %s...', tarball_path)
    local err = uv_unlink(tarball_path)
    a.main()
    if err then
      return logger:error('Could not remove tarball: %s', err)
    end
  end

  do -- Move tmp dir to output dir
    local dir_rev = revision:find('^v%d') and revision:sub(2) or revision
    local repo_project_name = url:match('[^/]-$')
    local extracted = fs.joinpath(tmp, repo_project_name .. '-' .. dir_rev)
    logger:debug('Moving %s to %s/...', extracted, output_dir)
    local err = uv_rename(extracted, output_dir)
    a.main()
    if err then
      return logger:error('Could not rename temp: %s', err)
    end
  end

  util.delete(tmp)
end

---@async
---@param logger Logger
---@param compile_location string
---@return string? err
local function do_compile(logger, compile_location)
  logger:info(string.format('Compiling parser'))

  local r = system({
    'tree-sitter',
    'build',
    '-o',
    'parser.so',
  }, { cwd = compile_location })
  if r.code > 0 then
    return logger:error('Error during "tree-sitter build": %s', r.stderr)
  end
end

---@async
---@param logger Logger
---@param compile_location string
---@param target_location string
---@return string? err
local function do_install(logger, compile_location, target_location)
  logger:info(string.format('Installing parser'))

  if uv.os_uname().sysname == 'Windows_NT' then -- why can't you just be normal?!
    local tempfile = target_location .. tostring(uv.hrtime())
    uv_rename(target_location, tempfile) -- parser may be in use: rename...
    uv_unlink(tempfile) -- ...and mark for garbage collection
  end

  local err = uv_copyfile(compile_location, target_location)
  a.main()
  if err then
    return logger:error('Error during parser installation: %s', err)
  end
end

---@async
---@param lang string
---@param cache_dir string
---@param install_dir string
---@param generate? boolean
---@return string? err
local function try_install_lang(lang, cache_dir, install_dir, generate)
  local logger = log.new('install/' .. lang)

  local repo = get_parser_install_info(lang)
  if repo then
    local project_name = 'tree-sitter-' .. lang

    local revision = repo.revision

    local compile_location ---@type string
    if repo.path then
      compile_location = fs.normalize(repo.path)
    else
      local project_dir = fs.joinpath(cache_dir, project_name)
      util.delete(project_dir)

      revision = revision or repo.branch or 'main'

      local err = do_download(logger, repo.url, project_name, cache_dir, revision, project_dir)
      if err then
        return err
      end
      compile_location = fs.joinpath(cache_dir, project_name)
    end

    if repo.location then
      compile_location = fs.joinpath(compile_location, repo.location)
    end

    do -- generate parser from grammar
      if repo.generate or generate then
        local err = do_generate(logger, repo, compile_location)
        if err then
          return err
        end
      end
    end

    do -- compile parser
      local err = do_compile(logger, compile_location)
      if err then
        return err
      end
    end

    do -- install parser
      local parser_lib_name = fs.joinpath(compile_location, 'parser.so')
      local install_location = fs.joinpath(install_dir, lang) .. '.so'
      local err = do_install(logger, parser_lib_name, install_location)
      if err then
        return err
      end

      local revfile = fs.joinpath(config.get_install_dir('parser-info') or '', lang .. '.revision')
      util.write_file(revfile, revision or '')
    end

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

---@alias InstallStatus
--- | 'installing'
--- | 'installed'
--- | 'failed'
--- | 'timeout'

local install_status = {} ---@type table<string,InstallStatus?>

---@async
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
    local err = try_install_lang(lang, cache_dir, install_dir, generate)
    install_status[lang] = err and 'failed' or 'installed'
  end

  local status = install_status[lang]
  assert(status and status ~= 'installing')
  return status
end

--- Reload the parser table and user modifications in case of update
local function reload_parsers()
  ---@diagnostic disable-next-line:no-unknown
  package.loaded['nvim-treesitter.parsers'] = nil
  parsers = require('nvim-treesitter.parsers')
  vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
end

---@class InstallOptions
---@field force? boolean
---@field generate? boolean
---@field max_jobs? integer

--- Install a parser
---@param languages string[]
---@param options? InstallOptions
---@param _callback? fun()
local function install(languages, options, _callback)
  options = options or {}

  local cache_dir = fs.normalize(fn.stdpath('cache'))
  local install_dir = config.get_install_dir('parser')

  local tasks = {} ---@type fun()[]
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

  a.join(options and options.max_jobs or MAX_JOBS, nil, tasks)
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
  languages = vim.tbl_filter(needs_update, languages) ---@type string[]

  if #languages > 0 then
    install(languages, { force = true })
  else
    log.info('All parsers are up-to-date')
  end
end, 2)

---@async
---@param logger Logger
---@param lang string
---@param parser string
---@param queries string
---@return string? err
local function uninstall_lang(logger, lang, parser, queries)
  logger:debug('Uninstalling ' .. lang)
  install_status[lang] = nil

  if fn.filereadable(parser) == 1 then
    logger:debug('Unlinking ' .. parser)
    local perr = uv_unlink(parser)
    a.main()

    if perr then
      return logger:error(perr)
    end
  end

  if fn.isdirectory(queries) == 1 then
    logger:debug('Unlinking ' .. queries)
    local qerr = uv_unlink(queries)
    a.main()

    if qerr then
      return logger:error(qerr)
    end
  end

  logger:info('Language uninstalled')
end

---@param languages string[]|string
---@param _options? UpdateOptions
---@param _callback fun()
M.uninstall = a.sync(function(languages, _options, _callback)
  languages = config.norm_languages(languages or 'all', { missing = true, dependencies = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  local tasks = {} ---@type fun()[]
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

  a.join(MAX_JOBS, nil, tasks)
  if #tasks > 1 then
    a.main()
    log.info('Uninstalled %d/%d languages', done, #tasks)
  end
end, 2)

return M
