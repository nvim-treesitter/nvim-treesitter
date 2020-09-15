local api = vim.api
local fn = vim.fn
local luv = vim.loop

local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local info = require'nvim-treesitter.info'

local M = {}

function M.iter_cmd(cmd_list, i, lang, success_message)
  if i == #cmd_list + 1 then return print(success_message) end

  local attr = cmd_list[i]
  if attr.info then print(attr.info) end

  local handle

  handle = luv.spawn(attr.cmd, attr.opts, vim.schedule_wrap(function(code)
    handle:close()
    if code ~= 0 then
      return api.nvim_err_writeln(attr.err or ("Failed to execute the following command:\n"..vim.inspect(attr)))
    end
    M.iter_cmd(cmd_list, i + 1, lang, success_message)
  end))
end

local function get_command(cmd)
  local ret = ''
  if cmd.opts and cmd.opts.cwd then
    ret = string.format('cd %s;\n', cmd.opts.cwd)
  end

  ret = string.format('%s%s ', ret, cmd.cmd)

  local options = ""
  if cmd.opts and cmd.opts.args then
    for _, opt in ipairs(cmd.opts.args) do
      options = string.format("%s %s", options, opt)
    end
  end

  return string.format('%s%s', ret, options)
end

local function iter_cmd_sync(cmd_list)
  for _, cmd in ipairs(cmd_list) do
    if cmd.info then
      print(cmd.info)
    end

    local ret = vim.fn.system(get_command(cmd))
    if vim.v.shell_error ~= 0 then
      print(ret)
      api.nvim_err_writeln((cmd.err..'\n' or '').."Failed to execute the following command:\n"..vim.inspect(cmd))
      return false
    end

  end

  return true
end

local function select_executable(executables)
  return vim.tbl_filter(function(c) return fn.executable(c) == 1 end, executables)[1]
end

local function select_args(repo)
  local args = {
        '-o',
        'parser.so',
        '-I./src',
        repo.files,
        '-shared',
        '-Os',
        '-lstdc++',
  }
  if fn.has('win32') == 0 then
    table.insert(args, '-fPIC')
  end
  return args
end

local function select_install_rm_cmd(cache_folder, project_name)
  if fn.has('win32') == 1 then
    local dir = cache_folder ..'\\'.. project_name
    return {
      cmd = 'cmd',
      opts = {
        args = { '/C', 'if', 'exist', dir, 'rmdir', '/s', '/q', dir },
      }
    }
  else
    return {
      cmd = 'rm',
      opts = {
        args = { '-rf', cache_folder..'/'..project_name },
      }
    }
  end
end

local function select_mv_cmd(compile_location, parser_lib_name)
  if fn.has('win32') == 1 then
    return {
      cmd = 'cmd',
      opts = {
        args = { '/C', 'move', '/Y', compile_location..'\\parser.so', parser_lib_name },
      }
    }
  else
    return {
      cmd = 'mv',
      opts = {
        args = { compile_location..'/parser.so', parser_lib_name }
      }
    }
  end
end

local function run_install(cache_folder, install_folder, lang, repo, with_sync)
  parsers.reset_cache()

  local path_sep = utils.get_path_sep()

  local project_name = 'tree-sitter-'..lang
  -- compile_location only needed for typescript installs.
  local compile_location = cache_folder..path_sep..(repo.location or project_name)
  local parser_lib_name = install_folder..path_sep..lang..".so"

  local compilers = { "cc", "gcc", "clang" }
  local cc = select_executable(compilers)
  if not cc then
    api.nvim_err_writeln('No C compiler found! "'..table.concat(compilers, '", "')..'" are not executable.')
    return
  end

  local command_list = {
    select_install_rm_cmd(cache_folder, project_name),
    {
      cmd = 'git',
      info = 'Downloading...',
      err = 'Error during download, please verify your internet connection',
      opts = {
        args = { 'clone', '--single-branch', '--branch', 'master', '--depth', '1', repo.url, project_name },
        cwd = cache_folder,
      },
    },
    {
      cmd = cc,
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = vim.tbl_flatten(select_args(repo)),
        cwd = compile_location
      }
    },
    select_mv_cmd(compile_location, parser_lib_name),
    select_install_rm_cmd(cache_folder, project_name)
  }

  if with_sync then
    if iter_cmd_sync(command_list) == true then
      print('Treesitter parser for '..lang..' has been installed')
    end
  else
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been installed')
  end
end

local function install_lang(lang, ask_reinstall, cache_folder, install_folder, with_sync)
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

  run_install(cache_folder, install_folder, lang, install_info, with_sync)
end

local function install(with_sync, ask_reinstall)
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
    else
      languages = vim.tbl_flatten({...})
      ask = ask_reinstall
    end

    for _, lang in ipairs(languages) do
      install_lang(lang, ask, cache_folder, install_folder, with_sync)
    end
  end
end

function M.update(lang)
  if lang then
    install(false, 'force')(lang)
  else
    local installed = info.installed_parsers()
    for _, lang in pairs(installed) do
      install(false, 'force')(lang)
    end
  end
end

local function select_uninstall_rm_cmd(lang, parser_lib)
  if fn.has('win32') == 1 then
    return {
      cmd = 'cmd',
      opts = {
        args = { '/C', 'if', 'exist', parser_lib, 'del', parser_lib },
      },
      info = "Uninstalling parser for "..lang,
      err = "Could not delete "..parser_lib,
    }
  else
    return {
      cmd = 'rm',
      opts = {
        args = { parser_lib },
      },
      info = "Uninstalling parser for "..lang,
      err = "Could not delete "..parser_lib,
    }
  end
end

function M.uninstall(lang)
  local path_sep = '/'
  if fn.has('win32') == 1 then
    path_sep = '\\'
  end

  if lang == 'all' then
    local installed = info.installed_parsers()
    for _, lang in pairs(installed) do
      M.uninstall(lang)
    end
  elseif lang then
    local install_dir, err = utils.get_parser_install_dir()
    if err then return api.nvim_err_writeln(err) end

    local parser_lib = install_dir..path_sep..lang..".so"

    local command_list = {
      select_uninstall_rm_cmd(lang, parser_lib)
    }
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been uninstalled')
  end
end

M.ensure_installed = install(false, false)

M.commands = {
  TSInstall = {
    run = install(false, true),
    args = {
      "-nargs=+",
      "-complete=custom,nvim_treesitter#installable_parsers",
    },
  },
  TSInstallSync = {
    run = install(true, true),
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
