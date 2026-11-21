local fn = vim.fn
local fs = vim.fs
local uv = vim.uv

local async = vim.async
local config = require('nvim-treesitter.config')
local log = require('nvim-treesitter.log')
local parsers = require('nvim-treesitter.parsers')
local util = require('nvim-treesitter.util')

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_copyfile = async.wrap(4, uv.fs_copyfile)

---@type fun(path: string): string?
local uv_rmdir = async.wrap(2, uv.fs_rmdir)

---@type fun(path: string, new_path: string): string?
local uv_rename = async.wrap(3, uv.fs_rename)

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_symlink = async.wrap(4, uv.fs_symlink)

---@type fun(path: string): string?
local uv_unlink = async.wrap(2, uv.fs_unlink)

--- Yield to the main loop, so that the API can be called after a uv callback.
---@async
local function schedule()
  async.await(vim.schedule)
end

---@async
---@param path string
---@return string? err
local function rmpath(path)
  local stat = uv.fs_lstat(path)
  if not stat then
    return
  end

  if stat.type == 'directory' then
    for file in fs.dir(path) do
      rmpath(fs.joinpath(path, file))
    end
    return uv_rmdir(path)
  else
    return uv_unlink(path)
  end
end

local MAX_JOBS = 100
local INSTALL_TIMEOUT = 60000

--- Run tasks concurrently, at most `max_jobs` at a time, and wait until all are done.
--- A task that fails does not affect the others.
--- @async
--- @param max_jobs integer
--- @param tasks (async fun())[]
local function join(max_jobs, tasks)
  local limit = async.semaphore(max_jobs)
  local running = {} ---@type vim.async.Task<nil>[]
  for i, task in ipairs(tasks) do
    running[i] = async.run(function()
      limit:with(task)
    end)
  end
  for _, task in ipairs(running) do
    async.pawait(task)
  end
end

---@async
---@param cmd string[]
---@param opts? vim.SystemOpts
---@return vim.SystemCompleted
local function system(cmd, opts)
  local cwd = opts and opts.cwd or uv.cwd()
  log.trace('running job: (cwd=%s) %s', cwd, table.concat(cmd, ' '))

  ---vim.system throws an error when uv.spawn fails, in particular if cmd or cwd
  ---does not exist. This kills the coroutine, so the async'ed call simply hangs.
  ---Instead, we pass a wrapper that catches errors and propagates them as a proper
  ---`SystemObj`.
  ---TODO(clason): remove when https://github.com/neovim/neovim/issues/38257 is resolved.
  ---@param _cmd string[]
  ---@param _opts vim.SystemOpts
  ---@param on_exit fun(result: vim.SystemCompleted)
  ---@return vim.SystemObj?
  local function system_wrap(_cmd, _opts, on_exit)
    local ok, ret = pcall(vim.system, _cmd, _opts, on_exit)
    if not ok then
      on_exit({
        code = 125,
        signal = 0,
        stdout = '',
        stderr = ret --[[@as string]],
      })
      return nil
    end
    return ret --[[@as vim.SystemObj]]
  end

  local r = async.await(3, system_wrap, cmd, opts) --[[@as vim.SystemCompleted]]
  schedule()
  if r.stdout and r.stdout ~= '' then
    log.trace('stdout -> %s', r.stdout)
  end
  if r.stderr and r.stderr ~= '' then
    log.trace('stderr -> %s', r.stderr)
  end

  return r
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
    return
  end

  return parser_config.install_info
end

---@param ... string
---@return string
function M.get_package_path(...)
  local info = assert(debug.getinfo(1, 'S'))
  return fs.joinpath(fn.fnamemodify(info.source:sub(2), ':p:h:h:h'), ...)
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
  local from_json = true
  if repo.generate_from_json == false then
    from_json = false
  end

  logger:info(
    string.format('Generating parser.c from %s...', from_json and 'grammar.json' or 'grammar.js')
  )

  local r = system({
    'tree-sitter',
    'generate',
    '--abi',
    tostring(vim.treesitter.language_version),
    from_json and 'src/grammar.json' or nil,
  }, { cwd = compile_location, env = { TREE_SITTER_JS_RUNTIME = 'native' } })
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
  local tmp = output_dir .. '-tmp'

  rmpath(tmp)
  schedule()

  url = url:gsub('.git$', '')
  local target = string.format('%s/archive/%s.tar.gz', url, revision)

  local tarball_path = fs.joinpath(cache_dir, project_name .. '.tar.gz')

  do -- Download tarball
    logger:info('Downloading %s...', project_name)
    local r = system({
      'curl',
      '--silent',
      '--fail',
      '--show-error',
      '--retry',
      '7',
      '-L', -- follow redirects
      target,
      '--output',
      tarball_path,
    })
    if r.code > 0 then
      return logger:error('Error during download: %s', r.stderr)
    end
  end

  do -- Create tmp dir
    logger:debug('Creating temporary directory: %s', tmp)
    local ok, err = pcall(fs.mkdir, tmp, { parents = true })
    if not ok then
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
    schedule()
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
    schedule()
    if err then
      return logger:error('Could not rename temp: %s', err)
    end
  end

  rmpath(tmp)
  schedule()
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

  local tempfile = target_location .. tostring(uv.hrtime())
  uv_rename(target_location, tempfile) -- parser may be in use: rename...
  uv_unlink(tempfile) -- ...and mark for garbage collection

  local err = uv_copyfile(compile_location, target_location)
  schedule()
  if err then
    return logger:error('Error during parser installation: %s', err)
  end
end

---@async
---@param logger Logger
---@param query_src string
---@param query_dir string
---@return string? err
local function do_link_queries(logger, query_src, query_dir)
  uv_unlink(query_dir)
  local err = uv_symlink(query_src, query_dir, { dir = true, junction = true })
  schedule()
  if err then
    return logger:error(err)
  end
end

---@async
---@param logger Logger
---@param query_src string
---@param query_dir string
---@return string? err
local function do_copy_queries(logger, query_src, query_dir)
  rmpath(query_dir)
  local ok, mkdir_err = pcall(fs.mkdir, query_dir)
  if not ok then
    return logger:error(mkdir_err --[[@as string]])
  end

  local err ---@type string?
  for f in fs.dir(query_src) do
    err = uv_copyfile(fs.joinpath(query_src, f), fs.joinpath(query_dir, f))
  end
  schedule()
  if err then
    return logger:error(err)
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
  local project_name = 'tree-sitter-' .. lang
  if repo then
    local revision = repo.revision

    local compile_location ---@type string
    if repo.path then
      compile_location = fs.normalize(repo.path)
    else
      local project_dir = fs.joinpath(cache_dir, project_name)
      rmpath(project_dir)

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
  end

  do -- install queries
    local query_src = M.get_package_path('runtime', 'queries', lang)
    local query_dir = fs.joinpath(config.get_install_dir('queries'), lang)
    local task ---@type function

    if repo and repo.queries and repo.path then -- link queries from local repo
      query_src = fs.joinpath(fs.normalize(repo.path), repo.queries)
      task = do_link_queries
    elseif repo and repo.queries then -- copy queries from tarball
      query_src = fs.joinpath(cache_dir, project_name, repo.queries)
      task = do_copy_queries
    elseif uv.fs_stat(query_src) then -- link queries from runtime
      task = do_link_queries
    end

    if task then
      local err = task(logger, query_src, query_dir)
      if err then
        return err
      end
    end
  end

  -- clean up
  if repo and not repo.path then
    rmpath(fs.joinpath(cache_dir, project_name))
    schedule()
  end

  logger:info('Language installed')
end

local installing = {} ---@type table<string,boolean?>

---@async
---@param lang string
---@param cache_dir string
---@param install_dir string
---@param generate? boolean
---@return boolean success
local function install_lang(lang, cache_dir, install_dir, generate)
  if installing[lang] then
    local success = vim.wait(INSTALL_TIMEOUT, function()
      return not installing[lang]
    end)
    return success
  end

  installing[lang] = true
  local err = try_install_lang(lang, cache_dir, install_dir, generate)
  installing[lang] = nil
  return not err
end

--- Reload the parser table and user modifications in case of update
local function reload_parsers()
  package.loaded['nvim-treesitter.parsers'] = nil
  ---@diagnostic disable-next-line:duplicate-require
  parsers = require('nvim-treesitter.parsers')
  vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
end

---@class InstallOptions
---@field force? boolean
---@field generate? boolean
---@field max_jobs? integer
---@field summary? boolean

--- Install a parser
---@async
---@param languages string[]
---@param options? InstallOptions
---@return boolean true if installation successful
local function install(languages, options)
  options = options or {}

  local cache_dir = fs.normalize(fn.stdpath('cache') --[[@as string]])
  fs.mkdir(cache_dir, { parents = true })

  local install_dir = config.get_install_dir('parser')
  local installed = options.force and {} or config.get_installed()

  local tasks = {} ---@type (async fun())[]
  local done = 0
  for _, lang in ipairs(languages) do
    if options.force or not vim.list_contains(installed, lang) then
      tasks[#tasks + 1] = function()
        schedule()
        if install_lang(lang, cache_dir, install_dir, options.generate) then
          done = done + 1
        end
      end
    end
  end

  join(options.max_jobs or MAX_JOBS, tasks)
  if #languages > 1 then
    schedule()
    if options.summary then
      if #tasks == 0 then
        log.info('All parsers are already installed')
      else
        log.info('Installed %d/%d languages', done, #tasks)
      end
    end
  end
  return done == #tasks
end

---@param languages string[]|string
---@param options? InstallOptions
---@return vim.async.Task<boolean...>
function M.install(languages, options)
  return async.run(function()
    reload_parsers()
    languages = config.norm_languages(languages, { unsupported = true })
    return install(languages, options)
  end)
end

---@param languages? string[]|string
---@param options? InstallOptions
---@return vim.async.Task<boolean...>
function M.update(languages, options)
  return async.run(function()
    reload_parsers()
    if not languages or #languages == 0 then
      languages = 'all'
    end
    languages = config.norm_languages(languages, { missing = true, unsupported = true })
    languages = vim.tbl_filter(needs_update, languages) ---@type string[]

    local summary = options and options.summary
    if #languages > 0 then
      return install(
        languages,
        { force = true, summary = summary, max_jobs = options and options.max_jobs }
      )
    else
      if summary then
        log.info('All parsers are up-to-date')
      end
      return true
    end
  end)
end

---@async
---@param logger Logger
---@param lang string
---@param parser string
---@param queries string
---@return string? err
local function uninstall_lang(logger, lang, parser, queries)
  logger:debug('Uninstalling ' .. lang)

  if uv.fs_stat(parser) then
    logger:debug('Unlinking ' .. parser)
    local perr = uv_unlink(parser)
    schedule()
    if perr then
      return logger:error(perr)
    end
  end

  local stat = uv.fs_lstat(queries)
  if stat then
    logger:debug('Unlinking ' .. queries)
    local qerr ---@type string?
    if stat.type == 'link' then
      qerr = uv_unlink(queries)
    else
      qerr = rmpath(queries)
    end
    schedule()
    if qerr then
      return logger:error(qerr)
    end
  end

  logger:info('Language uninstalled')
end

---@param languages string[]|string
---@param options? InstallOptions
---@return vim.async.Task<nil>
function M.uninstall(languages, options)
  return async.run(function()
    vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
    languages = config.norm_languages(languages or 'all', { missing = true, dependencies = true })

    local parser_dir = config.get_install_dir('parser')
    local query_dir = config.get_install_dir('queries')
    local installed = config.get_installed()

    local tasks = {} ---@type (async fun())[]
    local done = 0
    for _, lang in ipairs(languages) do
      local logger = log.new('uninstall/' .. lang)
      if not vim.list_contains(installed, lang) then
        log.warn('Parser for ' .. lang .. ' is not managed by nvim-treesitter')
      else
        local parser = fs.joinpath(parser_dir, lang) .. '.so'
        local queries = fs.joinpath(query_dir, lang)
        tasks[#tasks + 1] = function()
          local err = uninstall_lang(logger, lang, parser, queries)
          if not err then
            done = done + 1
          end
        end
      end
    end

    join(MAX_JOBS, tasks)
    if #tasks > 1 then
      schedule()
      if options and options.summary then
        log.info('Uninstalled %d/%d languages', done, #tasks)
      end
    end
  end)
end

return M
