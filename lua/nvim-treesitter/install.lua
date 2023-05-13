local api = vim.api
local luv = vim.loop

local utils = require('nvim-treesitter.utils')
local parsers = require('nvim-treesitter.parsers')
local config = require('nvim-treesitter.config')
local shell = require('nvim-treesitter.shell_cmds')

local M = {}

---@class LockfileInfo
---@field revision string

---@type table<string, LockfileInfo>
local lockfile = {}

M.compilers = { vim.fn.getenv('CC'), 'cc', 'gcc', 'clang', 'cl', 'zig' }
M.prefer_git = vim.fn.has('win32') == 1
M.command_extra_args = {}
M.ts_generate_args = nil

local started_commands = 0
local finished_commands = 0
local failed_commands = 0
local complete_std_output = {}
local complete_error_output = {}

local function reset_progress_counter()
  if started_commands ~= finished_commands then
    return
  end
  started_commands = 0
  finished_commands = 0
  failed_commands = 0
  complete_std_output = {}
  complete_error_output = {}
end

local function get_job_status()
  return '[nvim-treesitter] ['
    .. finished_commands
    .. '/'
    .. started_commands
    .. (failed_commands > 0 and ', failed: ' .. failed_commands or '')
    .. ']'
end

---@param lang string
---@param validate boolean|nil
---@return InstallInfo
local function get_parser_install_info(lang, validate)
  local parser_config = parsers.get_parser_configs()[lang]

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

local function load_lockfile()
  local filename = utils.join_path(utils.get_package_path(), 'lockfile.json')
  lockfile = vim.fn.filereadable(filename) == 1 and vim.fn.json_decode(vim.fn.readfile(filename))
    or {}
end

local function is_ignored_parser(lang)
  return vim.tbl_contains(config.get_ignored_parser_installs(), lang)
end

---@param lang string
---@return string|nil
local function get_revision(lang)
  if #lockfile == 0 then
    load_lockfile()
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
  if vim.fn.filereadable(lang_file) == 1 then
    return vim.fn.readfile(lang_file)[1]
  end
end

-- Clean path for use in a prefix comparison
---@param input string
---@return string
local function clean_path(input)
  local pth = vim.fn.fnamemodify(input, ':p')
  if vim.fn.has('win32') == 1 then
    pth = pth:gsub('/', '\\')
  end
  return pth
end

-- Checks if parser is installed with nvim-treesitter
---@param lang string
---@return boolean
local function is_installed(lang)
  local matched_parsers = api.nvim_get_runtime_file('parser/' .. lang .. '.so', true) or {}
  local install_dir = config.get_install_dir('parser')
  if not install_dir then
    return false
  end
  install_dir = clean_path(install_dir)
  for _, path in ipairs(matched_parsers) do
    local abspath = clean_path(path)
    if vim.startswith(abspath, install_dir) then
      return true
    end
  end
  return false
end

---@param lang string
---@return boolean
local function needs_update(lang)
  local revision = get_revision(lang)
  return not revision or revision ~= get_installed_revision(lang)
end

---@return string[]
local function outdated_parsers()
  return vim.tbl_filter(function(lang) ---@param lang string
    return is_installed(lang) and needs_update(lang)
  end, M.installed_parsers())
end

---@param handle userdata
---@param is_stderr boolean
local function onread(handle, is_stderr)
  return function(_, data)
    if data then
      if is_stderr then
        complete_error_output[handle] = (complete_error_output[handle] or '') .. data
      else
        complete_std_output[handle] = (complete_std_output[handle] or '') .. data
      end
    end
  end
end

function M.iter_cmd(cmd_list, i, lang, success_message)
  if i == 1 then
    started_commands = started_commands + 1
  end
  if i == #cmd_list + 1 then
    finished_commands = finished_commands + 1
    return print(get_job_status() .. ' ' .. success_message)
  end

  local attr = cmd_list[i]
  if attr.info then
    print(get_job_status() .. ' ' .. attr.info)
  end

  if attr.opts and attr.opts.args and M.command_extra_args[attr.cmd] then
    vim.list_extend(attr.opts.args, M.command_extra_args[attr.cmd])
  end

  if type(attr.cmd) == 'function' then
    local ok, err = pcall(attr.cmd)
    if ok then
      M.iter_cmd(cmd_list, i + 1, lang, success_message)
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
    local stdout = luv.new_pipe(false)
    local stderr = luv.new_pipe(false)
    attr.opts.stdio = { nil, stdout, stderr }
    ---@type userdata
    handle = luv.spawn(
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
          if complete_std_output[handle] and complete_std_output[handle] ~= '' then
            print(complete_std_output[handle])
          end

          local err_msg = complete_error_output[handle] or ''
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
        M.iter_cmd(cmd_list, i + 1, lang, success_message)
      end)
    )
    luv.read_start(stdout, onread(handle, false))
    luv.read_start(stderr, onread(handle, true))
  end
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
      print(cmd.info)
    end

    if type(cmd.cmd) == 'function' then
      cmd.cmd()
    else
      local ret = vim.fn.system(get_command(cmd))
      if vim.v.shell_error ~= 0 then
        print(ret)
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

---@param cache_dir string
---@param install_dir string
---@param lang string
---@param repo InstallInfo
---@param with_sync boolean
---@param generate_from_grammar boolean
local function run_install(cache_dir, install_dir, lang, repo, with_sync, generate_from_grammar)
  local path_sep = utils.get_path_sep()

  local project_name = 'tree-sitter-' .. lang
  local maybe_local_path = vim.fn.expand(repo.url)
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
      repo_location = repo_location .. '/' .. repo.location
    end
    repo_location = repo_location:gsub('/', path_sep)
    compile_location = utils.join_path(cache_dir, repo_location)
  end
  local parser_lib_name = utils.join_path(install_dir, lang) .. '.so'

  generate_from_grammar = repo.requires_generate_from_grammar or generate_from_grammar

  if generate_from_grammar and vim.fn.executable('tree-sitter') ~= 1 then
    api.nvim_err_writeln('tree-sitter CLI not found: `tree-sitter` is not executable!')
    if repo.requires_generate_from_grammar then
      api.nvim_err_writeln(
        'tree-sitter CLI is needed because `'
          .. lang
          .. '` is marked that it needs '
          .. 'to be generated from the grammar definitions to be compatible with nvim!'
      )
    end
    return
  else
    if not M.ts_generate_args then
      M.ts_generate_args = { 'generate', '--abi', vim.treesitter.language_version }
    end
  end
  if generate_from_grammar and vim.fn.executable('node') ~= 1 then
    api.nvim_err_writeln('Node JS not found: `node` is not executable!')
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
    vim.list_extend(command_list, { shell.select_install_rm_cmd(cache_dir, project_name) })
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
    shell.select_mv_cmd('parser.so', parser_lib_name, compile_location),
    {
      cmd = function()
        vim.fn.writefile(
          { revision or '' },
          utils.join_path(config.get_install_dir('parser-info') or '', lang .. '.revision')
        )
      end,
    },
  })
  if not from_local_path then
    vim.list_extend(command_list, { shell.select_install_rm_cmd(cache_dir, project_name) })
  end

  if with_sync then
    if iter_cmd_sync(command_list) == true then
      print('Treesitter parser for ' .. lang .. ' has been installed')
    end
  else
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for ' .. lang .. ' has been installed')
  end
end

---@param lang string
---@param ask_reinstall boolean|string
---@param cache_dir string
---@param install_dir string
---@param with_sync boolean
---@param generate_from_grammar boolean
local function install_lang(
  lang,
  ask_reinstall,
  cache_dir,
  install_dir,
  with_sync,
  generate_from_grammar
)
  if is_installed(lang) and ask_reinstall ~= 'force' then
    if not ask_reinstall then
      return
    end

    local yesno =
      vim.fn.input(lang .. ' parser already available: would you like to reinstall ? y/n: ')
    print('\n ')
    if not string.match(yesno, '^y.*') then
      return
    end
  end

  local install_info = get_parser_install_info(lang)

  run_install(cache_dir, install_dir, lang, install_info, with_sync, generate_from_grammar)
end

local function difference(t1, t2)
  return vim.iter.filter(function(v)
    return not vim.list_contains(t2, v)
  end, t1)
end

-- Copy bundled queries for {lang} into install directory (on rtp)
---@param lang string
local function sync_queries(lang)
  return iter_cmd_sync({
    shell.select_cp_cmd(
      utils.join_path(utils.get_package_path(), 'runtime', 'queries', lang),
      utils.join_path(config.get_install_dir('queries'), lang)
    ),
  })
end

---@class InstallOptions
---@field with_sync boolean
---@field ask_reinstall boolean|string
---@field generate_from_grammar boolean
---@field exclude_configured_parsers boolean

-- Install a parser
---@param options? InstallOptions
---@return function
function M.install(options)
  options = options or {}
  local with_sync = options.with_sync
  local ask_reinstall = options.ask_reinstall
  local generate_from_grammar = options.generate_from_grammar
  local exclude_configured_parsers = options.exclude_configured_parsers

  reset_progress_counter()
  return function(...)
    if vim.fn.executable('git') == 0 then
      return api.nvim_err_writeln('Git is required on your system to run this command')
    end

    local cache_dir = vim.fn.stdpath('cache')
    local install_dir = config.get_install_dir('parser')

    local languages ---@type string[]
    local ask ---@type boolean|string
    if ... == 'all' then
      languages = parsers.available_parsers()
      ask = false
    else
      languages = vim.tbl_flatten({ ... })
      ask = ask_reinstall
    end

    if exclude_configured_parsers then
      languages = difference(languages, config.get_ignored_parser_installs())
    end

    for _, lang in ipairs(languages) do
      install_lang(lang, ask, cache_dir, install_dir, with_sync, generate_from_grammar)
      sync_queries(lang)
    end
  end
end

function M.setup_auto_install()
  api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(args)
      local ft = vim.bo[args.buffer].filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft
      if
        parsers.get_parser_configs()[lang]
        and not is_installed(lang)
        and not is_ignored_parser(lang)
      then
        M.install()({ lang })
      end
    end,
  })
end

function M.update(options)
  options = options or {}
  return function(...)
    reset_progress_counter()
    M.lockfile = {}
    if ... and ... ~= 'all' then
      ---@type string[]
      local languages = vim.tbl_flatten({ ... })
      local installed = 0
      for _, lang in ipairs(languages) do
        if (not is_installed(lang)) or (needs_update(lang)) then
          installed = installed + 1
          M.install({
            ask_reinstall = 'force',
            with_sync = options.with_sync,
          })(lang)
        end
      end
      if installed == 0 then
        vim.notify('Parsers are up-to-date!')
      end
    else
      local parsers_to_update = outdated_parsers() or M.installed_parsers()
      if #parsers_to_update == 0 then
        vim.notify('All parsers are up-to-date!')
      end
      for _, lang in pairs(parsers_to_update) do
        M.install({
          ask_reinstall = 'force',
          exclude_configured_parsers = true,
          with_sync = options.with_sync,
        })(lang)
      end
    end
    -- always sync all installed queries
    for _, lang in pairs(M.installed_parsers()) do
      sync_queries(lang)
    end
  end
end

function M.uninstall(...)
  reset_progress_counter()
  if vim.tbl_contains({ 'all' }, ...) then
    local installed = M.installed_parsers()
    M.uninstall(installed)
  elseif ... then
    local install_dir = config.get_install_dir('parser')

    ---@type string[]
    local languages = vim.tbl_flatten({ ... })
    for _, lang in ipairs(languages) do
      if not vim.tbl_contains(M.installed_parsers(), lang) then
        vim.notify(
          'Parser for ' .. lang .. ' is is not managed by nvim-treesitter.',
          vim.log.levels.ERROR
        )
        break
      end

      local parser_lib = utils.join_path(install_dir, lang) .. '.so'
      if vim.fn.filereadable(parser_lib) == 1 then
        M.iter_cmd({
          shell.select_rm_file_cmd(parser_lib, 'Uninstalling parser for ' .. lang),
          shell.select_rm_file_cmd(
            utils.join_path(config.get_install_dir('queries'), lang),
            'Uninstalling queries for ' .. lang,
            true
          ),
        }, 1, lang, 'Treesitter parser for ' .. lang .. ' has been uninstalled')
      end
    end
  end
end

function M.write_lockfile(verbose, skip_langs)
  local sorted_parsers = {} ---@type Parser[]
  -- Load previous lockfile
  load_lockfile()
  skip_langs = skip_langs or {}

  for k, v in pairs(parsers.get_parser_configs()) do
    table.insert(sorted_parsers, { name = k, parser = v })
  end

  ---@param a Parser
  ---@param b Parser
  table.sort(sorted_parsers, function(a, b)
    return a.name < b.name
  end)

  for _, v in ipairs(sorted_parsers) do
    if not vim.tbl_contains(skip_langs, v.name) then
      -- I'm sure this can be done in aync way with iter_cmd
      local sha ---@type string
      if v.parser.install_info.branch then
        sha = vim.split(
          vim.fn.systemlist(
            'git ls-remote '
              .. v.parser.install_info.url
              .. ' | grep refs/heads/'
              .. v.parser.install_info.branch
          )[1],
          '\t'
        )[1]
      else
        sha =
          vim.split(vim.fn.systemlist('git ls-remote ' .. v.parser.install_info.url)[1], '\t')[1]
      end
      lockfile[v.name] = { revision = sha }
      if verbose then
        print(v.name .. ': ' .. sha)
      end
    else
      print('Skipping ' .. v.name)
    end
  end

  if verbose then
    print(vim.inspect(lockfile))
  end
  vim.fn.writefile(
    vim.fn.split(vim.fn.json_encode(lockfile), '\n'),
    utils.join_path(utils.get_package_path(), 'lockfile.json')
  )
end

M.ensure_installed = M.install({ exclude_configured_parsers = true })
M.ensure_installed_sync = M.install({ with_sync = true, exclude_configured_parsers = true })

---@return string[]
function M.installed_parsers()
  local installed = {}
  local install_dir = require('nvim-treesitter.config').get_install_dir('parser')
  local all_parsers = parsers.available_parsers()

  for _, lang in pairs(all_parsers) do
    local paths = vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', true)
    if vim.iter(paths):any(function(p)
      return p:find(install_dir)
    end) then
      installed[#installed + 1] = lang
    end
  end

  return installed
end

function M.info()
  local max_len = 0
  for _, ft in pairs(parsers.available_parsers()) do
    if #ft > max_len then
      max_len = #ft
    end
  end

  local parser_list = parsers.available_parsers()
  table.sort(parser_list)
  for _, lang in pairs(parser_list) do
    local installed = #api.nvim_get_runtime_file('parser/' .. lang .. '.so', false) > 0
    api.nvim_out_write(lang .. string.rep(' ', max_len - #lang + 1))
    if installed then
      api.nvim_out_write('[✓] installed\n')
    elseif pcall(vim.treesitter.inspect_lang, lang) then
      api.nvim_out_write('[✗] not installed (but still loaded. Restart Neovim!)\n')
    else
      api.nvim_out_write('[✗] not installed\n')
    end
  end
end

return M
