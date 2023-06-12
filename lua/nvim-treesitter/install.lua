local api = vim.api
local uv = vim.loop

local utils = require('nvim-treesitter.utils')
local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')
local shell = require('nvim-treesitter.shell_cmds')

local M = {}

---@class LockfileInfo
---@field revision string

---@type table<string, LockfileInfo>
local lockfile = {}

M.compilers = { uv.os_getenv('CC'), 'cc', 'gcc', 'clang', 'cl', 'zig' }
M.prefer_git = uv.os_uname().sysname == 'Windows_NT'
M.command_extra_args = {}
M.ts_generate_args = nil

local started_commands = 0
local finished_commands = 0
local failed_commands = 0
local stdout_output = {}
local stderr_output = {}

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
  stdout_output = {}
  stderr_output = {}
end

local function get_job_status()
  return '[nvim-treesitter] ['
    .. finished_commands
    .. '/'
    .. started_commands
    .. (failed_commands > 0 and ', failed: ' .. failed_commands or '')
    .. ']'
end

---@param cmd Command
---@return string command
local function get_command(cmd)
  local options = ''
  if cmd.opts and cmd.opts.args then
    if M.command_extra_args[cmd.cmd] then
      vim.list_extend(cmd.opts.args, M.command_extra_args[cmd.cmd])
    end
    for _, opt in ipairs(cmd.opts.args) do
      options = string.format('%s %s', options, opt)
    end
  end

  local command = string.format('%s %s', cmd.cmd, options)
  if cmd.opts and cmd.opts.cwd then
    command = shell.make_directory_change_for_command(cmd.opts.cwd, command)
  end
  return command
end

---@param cmd_list Command[]
---@return boolean
local function iter_cmd_sync(cmd_list)
  for _, cmd in ipairs(cmd_list) do
    if cmd.info then
      vim.notify(cmd.info)
    end

    if type(cmd.cmd) == 'function' then
      cmd.cmd()
    else
      local ret = vim.fn.system(get_command(cmd))
      if vim.v.shell_error ~= 0 then
        vim.notify(ret)
        api.nvim_err_writeln(
          (cmd.err and cmd.err .. '\n' or '')
            .. 'Failed to execute the following command:\n'
            .. vim.inspect(cmd)
        )
        return false
      end
    end
  end

  return true
end

local function iter_cmd(cmd_list, i, lang, success_message)
  if i == 1 then
    started_commands = started_commands + 1
  end
  if i == #cmd_list + 1 then
    finished_commands = finished_commands + 1
    return vim.notify(get_job_status() .. ' ' .. success_message)
  end

  local attr = cmd_list[i]
  if attr.info then
    vim.notify(get_job_status() .. ' ' .. attr.info)
  end

  if attr.opts and attr.opts.args and M.command_extra_args[attr.cmd] then
    vim.list_extend(attr.opts.args, M.command_extra_args[attr.cmd])
  end

  if type(attr.cmd) == 'function' then
    local ok, err = pcall(attr.cmd)
    if ok then
      iter_cmd(cmd_list, i + 1, lang, success_message)
    else
      failed_commands = failed_commands + 1
      finished_commands = finished_commands + 1
      return api.nvim_err_writeln(
        (attr.err or ('Failed to execute the following command:\n' .. vim.inspect(attr)))
          .. '\n'
          .. vim.inspect(err)
      )
    end
  else
    local handle
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)
    attr.opts.stdio = { nil, stdout, stderr }
    ---@type userdata
    handle = uv.spawn(
      attr.cmd,
      attr.opts,
      vim.schedule_wrap(function(code)
        if code ~= 0 then
          stdout:read_stop()
          stderr:read_stop()
        end
        stdout:close()
        stderr:close()
        handle:close()
        if code ~= 0 then
          failed_commands = failed_commands + 1
          finished_commands = finished_commands + 1
          if stdout_output[handle] and stdout_output[handle] ~= '' then
            vim.notify(stdout_output[handle])
          end

          local err_msg = stderr_output[handle] or ''
          api.nvim_err_writeln(
            'nvim-treesitter['
              .. lang
              .. ']: '
              .. (attr.err or ('Failed to execute the following command:\n' .. vim.inspect(attr)))
              .. '\n'
              .. err_msg
          )
          return
        end
        iter_cmd(cmd_list, i + 1, lang, success_message)
      end)
    )
    uv.read_start(stdout, function(_, data)
      if data then
        stdout_output[handle] = (stdout_output[handle] or '') .. data
      end
    end)
    uv.read_start(stderr, function(_, data)
      if data then
        stderr_output[handle] = (stderr_output[handle] or '') .. data
      end
    end)
  end
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
    local filename = utils.get_package_path('lockfile.json')
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
  local lang_file = utils.join_path(config.get_install_dir('parser-info'), lang .. '.revision')
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
  local maybe_local_path = vim.fs.normalize(repo.url)
  local from_local_path = vim.fn.isdirectory(maybe_local_path) == 1
  if from_local_path then
    repo.url = maybe_local_path
  end

  ---@type string compile_location only needed for typescript installs.
  local compile_location
  if from_local_path then
    compile_location = repo.url
    if repo.location then
      compile_location = utils.join_path(compile_location, repo.location)
    end
  else
    local repo_location = project_name
    if repo.location then
      repo_location = utils.join_path(repo_location, repo.location)
    end
    compile_location = utils.join_path(cache_dir, repo_location)
  end
  local parser_lib_name = utils.join_path(install_dir, lang) .. '.so'

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

  ---@type Command[]
  local command_list = {}
  if not from_local_path then
    vim.list_extend(command_list, {
      {
        cmd = function()
          vim.fn.delete(utils.join_path(cache_dir, project_name), 'rf')
        end,
      },
    })
    vim.list_extend(
      command_list,
      shell.select_download_commands(repo, project_name, cache_dir, revision, M.prefer_git)
    )
  end
  if generate_from_grammar then
    if repo.generate_requires_npm then
      if vim.fn.executable('npm') ~= 1 then
        api.nvim_err_writeln('`' .. lang .. '` requires NPM to be installed from grammar.js')
        return
      end
      vim.list_extend(command_list, {
        {
          cmd = 'npm',
          info = 'Installing NPM dependencies of ' .. lang .. ' parser',
          err = 'Error during `npm install` (required for parser generation of '
            .. lang
            .. ' with npm dependencies)',
          opts = {
            args = { 'install' },
            cwd = compile_location,
          },
        },
      })
    end
    vim.list_extend(command_list, {
      {
        cmd = vim.fn.exepath('tree-sitter'),
        info = 'Generating source files from grammar.js...',
        err = 'Error during "tree-sitter generate"',
        opts = {
          args = M.ts_generate_args,
          cwd = compile_location,
        },
      },
    })
  end
  vim.list_extend(command_list, {
    shell.select_compile_command(repo, cc, compile_location),
    {
      cmd = function()
        uv.fs_copyfile(utils.join_path(compile_location, 'parser.so'), parser_lib_name)
      end,
    },
    {
      cmd = function()
        local file = assert(
          io.open(
            utils.join_path(config.get_install_dir('parser-info') or '', lang .. '.revision'),
            'w'
          )
        )
        file:write(revision or '')
        file:close()
      end,
    },
  })
  if not from_local_path then
    vim.list_extend(command_list, {
      {
        cmd = function()
          vim.fn.delete(utils.join_path(cache_dir, project_name), 'rf')
        end,
      },
    })
  end

  if with_sync then
    if iter_cmd_sync(command_list) == true then
      vim.notify('Parser for ' .. lang .. ' has been installed')
    end
  else
    iter_cmd(command_list, 1, lang, 'Parser for ' .. lang .. ' has been installed')
  end
end

---@class InstallOptions
---@field with_sync boolean
---@field force boolean
---@field generate_from_grammar boolean
---@field skip table

-- Install a parser
---@param languages? string[]|string
---@param options? InstallOptions
function M.install(languages, options)
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

  for _, lang in ipairs(languages) do
    install_lang(lang, cache_dir, install_dir, force, with_sync, generate_from_grammar)
    uv.fs_symlink(
      utils.get_package_path('runtime', 'queries', lang),
      utils.join_path(config.get_install_dir('queries'), lang),
      { dir = true, junction = true } -- needed on Windows (non-junction links require admin)
    )
  end
end

---@class UpdateOptions
---@field with_sync boolean

---@param languages? string[]|string
---@param options? UpdateOptions
function M.update(languages, options)
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
    vim.notify('All parsers are up-to-date')
  end
end

--- @param lang string
--- @param parser string
--- @param queries string
local function uninstall(lang, parser, queries)
  if vim.fn.filereadable(parser) ~= 1 then
    return
  end

  iter_cmd({
    {
      cmd = function()
        uv.fs_unlink(parser)
      end,
    },
    {
      cmd = function()
        uv.fs_unlink(queries)
      end,
    },
  }, 1, lang, 'Parser for ' .. lang .. ' has been uninstalled')
end

--- @param languages string[]|string
function M.uninstall(languages)
  reset_progress_counter()

  languages = config.norm_languages(languages or 'all', { missing = true })

  local parser_dir = config.get_install_dir('parser')
  local query_dir = config.get_install_dir('queries')
  local installed = config.installed_parsers()

  for _, lang in ipairs(languages) do
    if not vim.list_contains(installed, lang) then
      vim.notify(
        'Parser for ' .. lang .. ' is is not managed by nvim-treesitter',
        vim.log.levels.ERROR
      )
    else
      local parser = utils.join_path(parser_dir, lang) .. '.so'
      local queries = utils.join_path(query_dir, lang)
      uninstall(lang, parser, queries)
    end
  end
end

return M
