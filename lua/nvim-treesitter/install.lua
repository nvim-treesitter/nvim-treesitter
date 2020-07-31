local api = vim.api
local fn = vim.fn
local luv = vim.loop

local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local info = require'nvim-treesitter.info'

local M = {}

local function iter_cmd(cmd_list, i, lang)
  if i == #cmd_list + 1 then return print('Treesitter parser for '..lang..' has been installed') end

  local attr = cmd_list[i]
  if attr.info then print(attr.info) end

  local handle

  handle = luv.spawn(attr.cmd, attr.opts, vim.schedule_wrap(function(code)
    handle:close()
    if code ~= 0 then return api.nvim_err_writeln(attr.err) end
    iter_cmd(cmd_list, i + 1, lang)
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

    vim.fn.system(get_command(cmd))
    if vim.v.shell_error ~= 0 then
      api.nvim_err_writeln(cmd.err)
      return false
    end

  end

  return true
end

local function run_install(cache_folder, package_path, lang, repo, with_sync)
  local project_name = 'tree-sitter-'..lang
  local project_repo = cache_folder..'/'..project_name
  -- compile_location only needed for typescript installs.
  local compile_location = cache_folder..'/'..(repo.location or project_name)
  local parser_lib_name = package_path.."/parser/"..lang..".so"
  local command_list = {
    {
      cmd = 'rm',
      opts = {
        args = { '-rf', project_repo },
      },
    },
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
      cmd = 'cc',
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = vim.tbl_flatten({
            '-o',
            'parser.so',
            '-I./src',
            repo.files,
            '-shared',
            '-Os',
            '-lstdc++',
            '-fPIC',
          }),
        cwd = compile_location
      }
    },
    {
      cmd = 'mv',
      opts = {
        args = { compile_location..'/parser.so', parser_lib_name }
      }
    },
    {
      cmd = 'rm',
      opts = {
        args = { '-rf', project_repo }
      }
    }
  }

  if with_sync then
    if iter_cmd_sync(command_list) == true then
      print('Treesitter parser for '..lang..' has been installed')
    end
  else
    iter_cmd(command_list, 1, lang)
  end
end

local function install_lang(lang, ask_reinstall, cache_folder, package_path, with_sync)
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

  run_install(cache_folder, package_path, lang, install_info, with_sync)
end

-- TODO(kyazdani): this should work on windows too
local function install(with_sync, ask_reinstall)
  return function (...)
    if fn.has('win32') == 1 then
      return api.nvim_err_writeln('This command is not available on windows at the moment.')
    end

    if fn.executable('git') == 0 then
      return api.nvim_err_writeln('Git is required on your system to run this command')
    end

    local package_path, err = utils.get_package_path()
    if err then return api.nvim_err_writeln(err) end

    local cache_folder, err = utils.get_cache_dir()
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
      install_lang(lang, ask, cache_folder, package_path, with_sync)
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

M.ensure_installed = install(false, false)

M.commands = {
  TSInstall = {
    run = install(false, true),
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_installable_parsers"
    }
  },
  TSInstallSync = {
    run = install(true, true),
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_installable_parsers"
    }
  },
  TSUpdate = {
    run = M.update,
    args = {
      "-nargs=*",
      "-complete=custom,v:lua.ts_installed_parsers"
    }
  }
}

return M
