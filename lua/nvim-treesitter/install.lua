local api = vim.api
local fn = vim.fn
local luv = vim.loop

local utils = require'nvim-treesitter.utils'
local parsers = require'nvim-treesitter.parsers'

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

local function run_install(cache_folder, package_path, lang, repo)
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

  iter_cmd(command_list, 1, lang)
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

  local languages = { ... }
  local check_installed = true
  if ... == 'all' then
    languages = parsers.available_parsers()
    check_installed = false
  end

  for _, lang in ipairs(languages) do
    if check_installed then
      if #api.nvim_get_runtime_file('parser/'..lang..'.so', false) > 0 then
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

    run_install(cache_folder, package_path, lang, install_info)
  end
end


M.ensure_installed = function(languages)
  if type(languages) == 'string' then
    if languages == 'all' then
      languages = parsers.available_parsers()
    else
      languages = {languages}
    end
  end

  for _, lang in ipairs(languages) do
    if not parsers.has_parser(lang) then
      install(lang)
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
    description = '`:TSInstall {lang}` installs a parser under nvim-treesitter/parser/{lang}.so'
  }
}

return M
