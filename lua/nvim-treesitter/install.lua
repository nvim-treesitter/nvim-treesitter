local api = vim.api
local fn = vim.fn
local luv = vim.loop

local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'
local info = require'nvim-treesitter.info'
local configs = require'nvim-treesitter.configs'

local M = {}
local lockfile = {}

function M.iter_cmd(cmd_list, i, lang, success_message)
  if i == #cmd_list + 1 then return print(success_message) end

  local attr = cmd_list[i]
  if attr.info then print(attr.info) end

  local handle

  handle = luv.spawn(attr.cmd, attr.opts, vim.schedule_wrap(function(code)
    handle:close()
    if code ~= 0 then return api.nvim_err_writeln(attr.err) end
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

    vim.fn.system(get_command(cmd))
    if vim.v.shell_error ~= 0 then
      api.nvim_err_writeln(cmd.err)
      return false
    end

  end

  return true
end

local function get_revision(lang)
  if #lockfile == 0 then
    lockfile = vim.fn.json_decode(vim.fn.readfile(utils.get_package_path()..'/lockfile.json'))
  end
  return (lockfile[lang] and lockfile[lang].revision) or 'master'
end

local function run_install(cache_folder, package_path, lang, repo, with_sync)
  parsers.reset_cache()

  local project_name = 'tree-sitter-'..lang
  local project_repo = cache_folder..'/'..project_name
  -- compile_location only needed for typescript installs.
  local compile_location = cache_folder..'/'..(repo.location or project_name)
  local parser_lib_name = package_path.."/parser/"..lang..".so"
  local revision = configs.get_update_strategy() == 'lockfile' and get_revision(lang) or 'master'

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
        args = { 'clone', '--single-branch', '--branch', revision, '--depth', '1', repo.url, project_name },
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
    M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been installed')
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

function M.uninstall(lang)
  if lang == 'all' then
    local installed = info.installed_parsers()
    for _, lang in pairs(installed) do
      M.uninstall(lang)
    end
  elseif lang then
    local package_path, err = utils.get_package_path()
    if err then
      print(err)
      return
    end
    local parser_lib = package_path.."/parser/"..lang..".so"

    local command_list = {
        {
          cmd = 'rm',
          opts = {
            args = { parser_lib },
          },
          info = "Uninstalling parser for "..lang,
          err = "Could not delete "..parser_lib,
        },
      }
      M.iter_cmd(command_list, 1, lang, 'Treesitter parser for '..lang..' has been uninstalled')
  end
end

function M.write_lockfile(verbose)
  local sorted_parsers = {}

  for k, v in pairs(parsers.get_parser_configs()) do
    table.insert(sorted_parsers, {name = k, parser = v})
  end

  table.sort(sorted_parsers, function(a, b) return a.name < b.name end)

  for _, v in ipairs(sorted_parsers) do
    -- I'm sure this can be done in aync way with iter_cmd
    local sha = vim.split(vim.fn.systemlist('git ls-remote '..v.parser.install_info.url)[1], '\t')[1]
    lockfile[v.name] = { revision = sha }
    if verbose then
      print(v.name..': '..sha)
    end
  end

  if verbose then
    print(vim.inspect(lockfile))
  end
  vim.fn.writefile(vim.fn.split(vim.fn.json_encode(lockfile), '\n'), utils.get_package_path().."/lockfile.json")
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
  },
  TSUninstall = {
    run = M.uninstall,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_installed_parsers"
    }
  }
}

return M
