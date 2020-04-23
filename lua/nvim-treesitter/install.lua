local api = vim.api
local fn = vim.fn
local luv = vim.loop
local repositories = require'nvim-treesitter/configs'.repositories

local M = {}

local function get_package_path()
  for _, path in pairs(api.nvim_list_runtime_paths()) do
    if string.match(path, '.*/nvim%-treesitter') then
      return path
    end
  end

  return nil, 'Plugin runtime path not found.'
end

local function get_cache_dir()
  local home = fn.get(fn.environ(), 'HOME')
  local xdg_cache = fn.get(fn.environ(), 'XDG_CACHE_HOME')

  if xdg_cache == 0 then
    xdg_cache = home .. '/.cache'
  end

  if luv.fs_access(xdg_cache, 'RW') then
    return xdg_cache
  elseif luv.fs_access('/tmp', 'RW') then
    return '/tmp'
  end

  return nil, 'Invalid cache rights, $XDG_CACHE_HOME or /tmp should be read/write'
end

local function iter_cmd(cmd_list, i, ft)
  if i == #cmd_list then return print('Treesitter parser for '..ft..' has been installed') end

  local attr = cmd_list[i + 1]
  if attr.info then print(attr.info) end

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
            '-shared',
            '-lstdc++',
            '-fPIC',
            '-Os',
            '-I./src',
            repo.files
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

  iter_cmd(command_list, 0, ft)
end

-- TODO(kyazdani): this should work on windows too
local function install(ft)
  if fn.has('win32') == 1 then
    return api.nvim_err_writeln('This command is not available on windows at the moment.')
  end

  if not ft then
    return api.nvim_err_writeln("Usage: install_parser('language')")
  end

  if #api.nvim_get_runtime_file('parser/'..ft..'.so', false) > 0 then
    local yesno = fn.input('Parser already available: would you like to reinstall ? y/n: ')
    print('\n ') -- mandatory to avoid messing up command line
    if not string.match(yesno, '^y.*') then return end
  end

  local repository = repositories[ft]
  if not repository then
    return api.nvim_err_writeln('Parser not available for language '..ft)
  end

  vim.validate {
    url={ repository.url, 'string' },
    files={ repository.files, 'table' }
  }

  if fn.executable('git') == 0 then
    return api.nvim_err_writeln('Git is required on your system to run this command')
  end

  local package_path, err = get_package_path()
  if err then return api.nvim_err_writeln(err) end

  local cache_folder, err = get_cache_dir()
  if err then return api.nvim_err_writeln(err) end

  run_install(cache_folder, package_path, ft, repository)
end

local function install_info()
  local max_len = 0
  for parser_name, _ in pairs(repositories) do
    if #parser_name > max_len then max_len = #parser_name end
  end

  for parser_name, _ in pairs(repositories) do
    local is_installed = #api.nvim_get_runtime_file('parser/'..parser_name..'.so', false) > 0
    api.nvim_out_write(parser_name..string.rep(' ', max_len - #parser_name + 1))
    if is_installed then
      api.nvim_out_write("[✓] installed\n")
    else
      api.nvim_out_write("[✗] not installed\n")
    end
  end
end

M.commands = {
  TSInstall = {
    run = install,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_installable_parsers"
    },
    description = '`:TSInstall {ft}` installs a parser under nvim-treesitter/parser/{name}.so'
  },
  TSInstallInfo = {
    run = install_info,
    args = { "-nargs=0" },
    description = '`:TSInstallInfo` print installation state for every filetype'
  }
}

function M.setup()
  for command_name, def in pairs(M.commands) do
    local call_fn = string.format("lua require'nvim-treesitter.install'.commands.%s.run(<f-args>)", command_name)
    local parts = vim.tbl_flatten({
        "command!",
        def.args,
        command_name,
        call_fn,
      })
    api.nvim_command(table.concat(parts, " "))
  end
end

return M
