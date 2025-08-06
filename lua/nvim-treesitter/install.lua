local fn = vim.fn
local fs = vim.fs
local uv = vim.uv

local a = require('nvim-treesitter.async')
local config = require('nvim-treesitter.config')
local log = require('nvim-treesitter.log')
local parsers = require('nvim-treesitter.parsers')
local util = require('nvim-treesitter.util')

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_copyfile = a.awrap(4, uv.fs_copyfile)

---@type fun(path: string, mode: integer): string?
local uv_mkdir = a.awrap(3, uv.fs_mkdir)

---@type fun(path: string): string?
local uv_rmdir = a.awrap(2, uv.fs_rmdir)

---@type fun(path: string, new_path: string): string?
local uv_rename = a.awrap(3, uv.fs_rename)

---@type fun(path: string, new_path: string, flags?: table): string?
local uv_symlink = a.awrap(4, uv.fs_symlink)

---@type fun(path: string): string?
local uv_unlink = a.awrap(2, uv.fs_unlink)

---@async
---@param path string
---@return string? err
local function mkpath(path)
  local parent = fs.dirname(path)
  if not parent:match('^[./]$') and not uv.fs_stat(parent) then
    mkpath(parent)
  end

  return uv_mkdir(path, 493) -- tonumber('755', 8)
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

--- @async
--- @param max_jobs integer
--- @param tasks async.TaskFun[]
local function join(max_jobs, tasks)
  if #tasks == 0 then
    return
  end

  max_jobs = math.min(max_jobs, #tasks)

  local remaining = { select(max_jobs + 1, unpack(tasks)) }
  local to_go = #tasks

  a.await(1, function(finish)
    local function cb()
      to_go = to_go - 1
      if to_go == 0 then
        finish()
      elseif #remaining > 0 then
        local next_task = table.remove(remaining)
        next_task():await(cb)
      end
    end

    for i = 1, max_jobs do
      tasks[i]():await(cb)
    end
  end)
end

---@async
---@param cmd string[]
---@param opts? vim.SystemOpts
---@return vim.SystemCompleted
local function system(cmd, opts)
  local cwd = opts and opts.cwd or uv.cwd()
  log.trace('running job: (cwd=%s) %s', cwd, table.concat(cmd, ' '))
  local r = a.await(3, vim.system, cmd, opts) --[[@as vim.SystemCompleted]]
  a.schedule()
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

  rmpath(tmp)
  a.schedule()

  url = url:gsub('.git$', '')
  local target = is_gitlab
      and string.format('%s/-/archive/%s/%s-%s.tar.gz', url, revision, project_name, revision)
    or string.format('%s/archive/%s.tar.gz', url, revision)

  local tarball_path = fs.joinpath(cache_dir, project_name .. '.tar.gz')

  do -- Download tarball
    logger:info('Downloading %s...', project_name)
    local r = system({
      'curl',
      '--silent',
      '--fail',
      '--show-error',
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
    local err = mkpath(tmp)
    a.schedule()
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
    a.schedule()
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
    a.schedule()
    if err then
      return logger:error('Could not rename temp: %s', err)
    end
  end

  rmpath(tmp)
  a.schedule()
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
  a.schedule()
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
  a.schedule()
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
  local err = uv_mkdir(query_dir, 493) -- tonumber('755', 8)

  for f in fs.dir(query_src) do
    err = uv_copyfile(fs.joinpath(query_src, f), fs.joinpath(query_dir, f))
  end
  a.schedule()
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
    a.schedule()
  end

  logger:info('Language installed')
end

local installing = {} ---@type table<string,boolean?>

---@async
---@param lang string
---@param cache_dir string
---@param install_dir string
---@param force? boolean
---@param generate? boolean
---@return boolean success
local function install_lang(lang, cache_dir, install_dir, force, generate)
  if not force and vim.list_contains(config.get_installed(), lang) then
    return true
  elseif installing[lang] then
    local success = vim.wait(INSTALL_TIMEOUT, function()
      return not installing[lang]
    end)
    return success
  else
    installing[lang] = true
    local err = try_install_lang(lang, cache_dir, install_dir, generate)
    installing[lang] = nil
    return not err
  end
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
---@field summary? boolean

--- Install a parser
---@async
---@param languages string[]
---@param options? InstallOptions
---@return boolean true if installation successful
local function install(languages, options)
  options = options or {}

  local cache_dir = fs.normalize(fn.stdpath('cache'))
  if not uv.fs_stat(cache_dir) then
    fn.mkdir(cache_dir, 'p')
  end

  local install_dir = config.get_install_dir('parser')

  local tasks = {} ---@type async.TaskFun[]
  local done = 0
  for _, lang in ipairs(languages) do
    tasks[#tasks + 1] = a.async(--[[@async]] function()
      a.schedule()
      local success = install_lang(lang, cache_dir, install_dir, options.force, options.generate)
      if success then
        done = done + 1
      end
    end)
  end

  join(options and options.max_jobs or MAX_JOBS, tasks)
  if #tasks > 1 then
    a.schedule()
    if options and options.summary then
      log.info('Installed %d/%d languages', done, #tasks)
    end
  end
  return done == #tasks
end

---@async
---@param languages string[]|string
---@param options? InstallOptions
M.install = a.async(function(languages, options)
  reload_parsers()
  languages = config.norm_languages(languages, { unsupported = true })
  return install(languages, options)
end)

---@async
---@param languages? string[]|string
---@param options? InstallOptions
M.update = a.async(function(languages, options)
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

---@async
---@param logger Logger
---@param lang string
---@param parser string
---@param queries string
---@return string? err
local function uninstall_lang(logger, lang, parser, queries)
  logger:debug('Uninstalling ' .. lang)

  if fn.filereadable(parser) == 1 then
    logger:debug('Unlinking ' .. parser)
    local perr = uv_unlink(parser)
    a.schedule()
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
    a.schedule()
    if qerr then
      return logger:error(qerr)
    end
  end

  logger:info('Language uninstalled')
end

---@async
---@param languages string[]|string
---@param options? InstallOptions
M.uninstall = a.async(function(languages, options)
  vim.api.nvim_exec_autocmds('User', { pattern = 'TSUpdate' })
  languages = config.norm_languages(languages or 'all', { missing = true, dependencies = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.get_installed()

  local tasks = {} ---@type async.TaskFun[]
  local done = 0
  for _, lang in ipairs(languages) do
    local logger = log.new('uninstall/' .. lang)
    if not vim.list_contains(installed, lang) then
      log.warn('Parser for ' .. lang .. ' is not managed by nvim-treesitter')
    else
      local parser = fs.joinpath(parser_dir, lang) .. '.so'
      local queries = fs.joinpath(query_dir, lang)
      tasks[#tasks + 1] = a.async(--[[@async]] function()
        local err = uninstall_lang(logger, lang, parser, queries)
        if not err then
          done = done + 1
        end
      end)
    end
  end

  join(MAX_JOBS, tasks)
  if #tasks > 1 then
    a.schedule()
    if options and options.summary then
      log.info('Uninstalled %d/%d languages', done, #tasks)
    end
  end
end)

return M
