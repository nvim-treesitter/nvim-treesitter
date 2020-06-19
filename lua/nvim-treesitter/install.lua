local api = vim.api
local fn = vim.fn
local luv = vim.loop

local configs = require'nvim-treesitter.configs'
local utils = require'nvim-treesitter.utils'

local M = {}

local function iter_cmd(cmd_list, i, ft)
  if i == #cmd_list + 1 then return print('Treesitter parser for '..ft..' has been installed') end

  local attr = cmd_list[i]
  if attr.info then print(attr.info) end

  local handle

  handle = luv.spawn(attr.cmd, attr.opts, vim.schedule_wrap(function(code)
    handle:close()
    if code ~= 0 then return api.nvim_err_writeln(attr.err) end
    iter_cmd(cmd_list, i + 1, ft)
  end))
end

local function run_install(cache_folder, package_path, ft, repo)
  local project_name = 'tree-sitter-'..ft
  local project_repo = cache_folder..'/'..project_name
  -- compile_location only needed for typescript installs.
  local compile_location = cache_folder..'/'..(repo.location or project_name)
  local parser_lib_name = package_path.."/parser/"..ft..".so"
  local command_list = {
    {
      cmd = 'mkdir',
      opts = {
        args = { '-p', package_path.."/parser" }
      }
    },
    {
      cmd = 'rm',
      opts = {
        args = { '-rf', project_repo },
      }
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

  iter_cmd(command_list, 1, ft)
end

-- TODO(kyazdani): this should work on windows too
local function install(...)
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

  for _, ft in ipairs({ ... }) do
    if #api.nvim_get_runtime_file('parser/'..ft..'.so', false) > 0 then
      local yesno = fn.input(ft .. ' parser already available: would you like to reinstall ? y/n: ')
      print('\n ') -- mandatory to avoid messing up command line
      if not string.match(yesno, '^y.*') then return end
    end

    local parser_config = configs.get_parser_configs()[ft]
    if not parser_config then
      return api.nvim_err_writeln('Parser not available for language '..ft)
    end

    local install_info = parser_config.install_info
    vim.validate {
      url={ install_info.url, 'string' },
      files={ install_info.files, 'table' }
    }

    run_install(cache_folder, package_path, ft, install_info)
  end
end


M.ensure_installed = function(languages)
  if type(languages) == 'string' then
    if languages == 'all' then
      languages = configs.available_parsers()
    else
      languages = {languages}
    end
  end

  for _, ft in ipairs(languages) do
    if not utils.has_parser(ft) then
      install(ft)
    end
  end
end


M.commands = {
  TSInstall = {
    run = install,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_installable_parsers"
    },
    description = '`:TSInstall {ft}` installs a parser under nvim-treesitter/parser/{name}.so'
  }
}

return M
