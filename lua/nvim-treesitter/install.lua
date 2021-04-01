local api = vim.api
local fn = vim.fn
local luv = vim.loop

local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'
local shell = require'nvim-treesitter.shell_command_selectors'

local M = {}
local lockfile = {}

M.compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl" }

local started_commands = 0
local finished_commands = 0
local failed_commands = 0

local function reset_progress_counter()
  if started_commands ~= finished_commands then
    return
  end
  started_commands = 0
  finished_commands = 0
  failed_commands = 0
end

local function get_job_status()
  return "[nvim-treesitter] ["..finished_commands.."/"..started_commands
    ..(failed_commands > 0 and ", failed: "..failed_commands or "").."]"
end

local function get_revision(lang)
  if #lockfile == 0 then
    local filename = utils.join_path(utils.get_package_path(), 'lockfile.json')
    lockfile = vim.fn.filereadable(filename) == 1 and vim.fn.json_decode(vim.fn.readfile(filename)) or {}
  end
  return (lockfile[lang] and lockfile[lang].revision)
end

local function get_installed_revision(lang)
  local lang_file = utils.join_path(utils.get_parser_info_dir(), lang..'.revision')
  if vim.fn.filereadable(lang_file) == 1 then
    return vim.fn.readfile(lang_file)[1]
  end
end

local function needs_update(lang)
  return not get_revision(lang) or get_revision(lang) ~= get_installed_revision(lang)
end

local function outdated_parsers()
  return vim.tbl_filter(function(lang)
    return needs_update(lang)
  end,
    info.installed_parsers())
end

function M.iter_cmd(cmd_list, i, lang, success_message)
  if i == 1 then
    started_commands = started_commands + 1
  end
  if i == #cmd_list + 1 then
    finished_commands = finished_commands + 1
    return print(get_job_status().." "..success_message)
  end

  local attr = cmd_list[i]
  if attr.info then print(get_job_status().." "..attr.info) end

  if type(attr.cmd) == 'function' then
    local ok, err = pcall(attr.cmd)
    if ok then
      M.iter_cmd(cmd_list, i + 1, lang, success_message)
    else
      failed_commands = failed_commands + 1
      finished_commands = finished_commands + 1
      return api.nvim_err_writeln((attr.err or ("Failed to execute the following command:\n"..vim.inspect(attr)))
        ..'\n'..vim.inspect(err))
    end
  else
    local handle
    handle = luv.spawn(attr.cmd, attr.opts, vim.schedule_wrap(function(code)
      handle:close()
      if code ~= 0 then
        failed_commands = failed_commands + 1
        finished_commands = finished_commands + 1
        return api.nvim_err_writeln(attr.err or ("Failed to execute the following command:\n"..vim.inspect(attr)))
      end
      M.iter_cmd(cmd_list, i + 1, lang, success_message)
    end))
  end
end

local function get_command(cmd)
  local options = ""
  if cmd.opts and cmd.opts.args then
    for _, opt in ipairs(cmd.opts.args) do
      options = string.format("%s %s", options, opt)
    end
  end

  local final = string.format('%s %s', cmd.cmd, options)
  if cmd.opts and cmd.opts.cwd then
    final = shell.make_directory_change_for_command(cmd.opts.cwd, final)
  end
  return final
end

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
        api.nvim_err_writeln((cmd.err and cmd.err..'\n' or '')
          .."Failed to execute the following command:\n"
          ..vim.inspect(cmd))
        return false
      end
    end

  end

  return true
end

local function run_install(cache_folder, install_folder, lang, repo, with_sync, generate_from_grammar)
  parsers.reset_cache()

  local path_sep = utils.get_path_sep()

  local project_name = 'tree-sitter-'..lang
  local maybe_local_path = vim.fn.expand(repo.url)
  local from_local_path = vim.fn.isdirectory(maybe_local_path) == 1
  if from_local_path then
    repo.url = maybe_local_path
  end

  -- compile_location only needed for typescript installs.
  local compile_location
  if from_local_path then
    compile_location = repo.url
  else
    local repo_location = string.gsub(repo.location or project_name, '/', path_sep)
    compile_location = cache_folder..path_sep..repo_location
  end
  local parser_lib_name = install_folder..path_sep..lang..".so"

  if repo.requires_generate_from_grammar and vim.env.CI then
    print("Skipping language "..lang.." on CI (requires npm)!")
    return
  end

  generate_from_grammar = repo.requires_generate_from_grammar or generate_from_grammar

  if generate_from_grammar and vim.fn.executable('tree-sitter') ~= 1 then
    api.nvim_err_writeln('tree-sitter CLI not found: `tree-sitter` is not executable!')
    if repo.requires_generate_from_grammar then
      api.nvim_err_writeln('tree-sitter CLI is needed because `'..lang..'` is marked that it needs '
                         ..'to be generated from the grammar definitions to be compatible with nvim!')
    end
    return
  end
  if generate_from_grammar and vim.fn.executable('node') ~= 1 then
    api.nvim_err_writeln('Node JS not found: `node` is not executable!')
  end
  local cc = shell.select_executable(M.compilers)
  if not cc then
    api.nvim_err_writeln('No C compiler found! "'
      ..table.concat(vim.tbl_filter(function(c) return type(c) == 'string' end, M.compilers), '", "')
      ..'" are not executable.')
    return
  end
  local revision = configs.get_update_strategy() == 'lockfile' and get_revision(lang)

  local command_list = {}
  if not from_local_path then
    vim.list_extend(command_list, { shell.select_install_rm_cmd(cache_folder, project_name) })
    vim.list_extend(command_list, shell.select_download_commands(repo, project_name, cache_folder, revision))
  end
  if generate_from_grammar then
    if repo.generate_requires_npm then
      if vim.fn.executable('npm') ~= 1 then
        api.nvim_err_writeln('`'..lang..'` requires NPM to be installed from grammar.js')
        return
      end
      vim.list_extend(command_list, {
        {
          cmd = 'npm',
          info = 'Installing NPM dependencies of '..lang..' parser',
          err = 'Error during `npm install` (required for parser generation of '..lang..' with npm dependencies)',
          opts = {
            args = {'install'},
            cwd = compile_location
          }
        }
      })
    end
    vim.list_extend(command_list, {
      {
        cmd = vim.fn.exepath('tree-sitter'),
        info = 'Generating source files from grammar.js...',
        err = 'Error during "tree-sitter generate"',
        opts = {
          args = {'generate'},
          cwd = compile_location
        }
      }
    })
  end
  vim.list_extend(command_list, {
    {
      cmd = cc,
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = vim.tbl_flatten(shell.select_compiler_args(repo, cc)),
        cwd = compile_location
      }
    },
    shell.select_mv_cmd('parser.so', parser_lib_name, compile_location),
    {
      cmd = function()
        vim.fn.writefile({revision or ''}, utils.join_path(utils.get_parser_info_dir(), lang..'.revision'))
      end
    }
  })
  if not from_local_path then
    vim.list_extend(command_list, {shell.select_install_rm_cmd(cache_folder, project_name)})
  end

  if with_sync then
    if iter_cmd_sync(command_list) == true then
      print('Treesitter parser for '..lang..' has been installed')
    end
  else
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been installed')
  end
end

local function install_lang(lang, ask_reinstall, cache_folder, install_folder, with_sync, generate_from_grammar)
  if #api.nvim_get_runtime_file('parser/'..lang..'.so', false) > 0 then
    if ask_reinstall ~= 'force' then
      if not ask_reinstall then return end

      local yesno = fn.input(lang .. ' parser already available: would you like to reinstall ? y/n: ')
      print('\n ') -- mandatory to avoid messing up command line
      if not string.match(yesno, '^y.*') then return end
    end
  end

  local parser_config = parsers.get_parser_configs()[lang]
  if not parser_config then
    return api.nvim_err_writeln('Parser not available for language '..lang)
  end

  local install_info = parser_config.install_info
  vim.validate {
    url={ install_info.url, 'string' },
    files={ install_info.files, 'table' }
  }

  run_install(cache_folder, install_folder, lang, install_info, with_sync, generate_from_grammar)
end

local function install(options)
  options = options or {}
  local with_sync = options.with_sync
  local ask_reinstall = options.ask_reinstall
  local generate_from_grammar = options.generate_from_grammar
  local exclude_configured_parsers = options.exclude_configured_parsers

  return function (...)
    if fn.executable('git') == 0 then
      return api.nvim_err_writeln('Git is required on your system to run this command')
    end

    local cache_folder, err = utils.get_cache_dir()
    if err then return api.nvim_err_writeln(err) end

    local install_folder, err = utils.get_parser_install_dir()
    if err then return api.nvim_err_writeln(err) end

    local languages
    local ask
    if ... == 'all' then
      languages = parsers.available_parsers()
      ask = false
    elseif ... == 'maintained' then
      languages = parsers.maintained_parsers()
      ask = false
    else
      languages = vim.tbl_flatten({...})
      ask = ask_reinstall
    end

    if exclude_configured_parsers then
      languages = utils.difference(languages, configs.get_ignored_parser_installs())
    end

    if #languages > 1 then
      reset_progress_counter()
    end

    for _, lang in ipairs(languages) do
      install_lang(lang, ask, cache_folder, install_folder, with_sync, generate_from_grammar)
    end
  end
end

function M.update(lang)
  M.lockfile = {}
  reset_progress_counter()
  if lang and lang ~= 'all' then
    install({ ask_reinstall = 'force' })(lang)
  else
    local parsers_to_update = configs.get_update_strategy() == 'lockfile'
      and outdated_parsers()
      or info.installed_parsers()
    if #parsers_to_update == 0 then
      print('All parsers are up-to-date!')
    end
    for _, lang in pairs(parsers_to_update) do
      install({
        ask_reinstall = 'force',
        exclude_configured_parsers = true
      })(lang)
    end
  end
end

function M.uninstall(lang)
  local path_sep = '/'
  if fn.has('win32') == 1 then
    path_sep = '\\'
  end

  if vim.tbl_contains({'all', 'maintained'}, lang) then
    reset_progress_counter()
    local installed = info.installed_parsers()
    if lang == "maintained" then
      local maintained = parsers.maintained_parsers()
      installed = vim.tbl_filter(function(l) return vim.tbl_contains(maintained, l) end, installed)
    end
    for _, lang in pairs(installed) do
      M.uninstall(lang)
    end
  elseif lang then
    local install_dir, err = utils.get_parser_install_dir()
    if err then return api.nvim_err_writeln(err) end

    local parser_lib = install_dir..path_sep..lang..".so"

    local command_list = {
      shell.select_rm_file_cmd(parser_lib, "Uninstalling parser for "..lang)
    }
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been uninstalled')
  end
end

function M.write_lockfile(verbose, skip_langs)
  local sorted_parsers = {}
  -- Load previous lockfile
  get_revision()
  skip_langs = skip_langs or {}

  for k, v in pairs(parsers.get_parser_configs()) do
    table.insert(sorted_parsers, {name = k, parser = v})
  end

  table.sort(sorted_parsers, function(a, b) return a.name < b.name end)

  for _, v in ipairs(sorted_parsers) do

    if not vim.tbl_contains(skip_langs, v.name) then
      -- I'm sure this can be done in aync way with iter_cmd
      local sha = vim.split(vim.fn.systemlist('git ls-remote '..v.parser.install_info.url)[1], '\t')[1]
      lockfile[v.name] = { revision = sha }
      if verbose then
        print(v.name..': '..sha)
      end
    else
      print('Skipping '..v.name)
    end
  end

  if verbose then
    print(vim.inspect(lockfile))
  end
  vim.fn.writefile(vim.fn.split(vim.fn.json_encode(lockfile), '\n'),
    utils.join_path(utils.get_package_path(), "lockfile.json"))
end

M.ensure_installed = install({ exclude_configured_parsers = true })

M.commands = {
  TSInstall = {
    run = install({ ask_reinstall = true }),
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#installable_parsers",
    },
  },
  TSInstallFromGrammar = {
    run = install({ ask_reinstall = true, generate_from_grammar = true }),
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#installable_parsers",
    },
  },
  TSInstallSync = {
    run = install({ with_sync = true, ask_reinstall = true }),
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#installable_parsers",
    },
  },
  TSUpdate = {
    run = M.update,
    args = {
      "-nargs=*",
      "-complete=custom,nvim_treesitter#installed_parsers",
    },
  },
  TSUninstall = {
    run = M.uninstall,
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#installed_parsers",
    },
  },
}

return M
