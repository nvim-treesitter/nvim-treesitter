local uv = vim.loop
local utils = require('nvim-treesitter.utils')

local iswin = uv.os_uname().sysname == 'Windows_NT'

local M = {}

---@param executables string[]
---@return string|nil
function M.select_executable(executables)
  return vim.tbl_filter(function(c) ---@param c string
    return c ~= vim.NIL and vim.fn.executable(c) == 1
  end, executables)[1]
end

-- Returns the compiler arguments based on the compiler and OS
---@param repo InstallInfo
---@param compiler string
---@return string[]
function M.select_compiler_args(repo, compiler)
  if compiler:find('cl$') or compiler:find('cl.exe$') then
    return {
      '/Fe:',
      'parser.so',
      '/Isrc',
      repo.files,
      '-Os',
      '/LD',
    }
  elseif compiler:find('zig$') or compiler:find('zig.exe$') then
    return {
      'c++',
      '-o',
      'parser.so',
      repo.files,
      '-lc',
      '-Isrc',
      '-shared',
      '-Os',
    }
  else
    local args = {
      '-o',
      'parser.so',
      '-I./src',
      repo.files,
      '-Os',
    }
    if uv.os_uname().sysname == 'Darwin' then
      table.insert(args, '-bundle')
    else
      table.insert(args, '-shared')
    end
    if
      #vim.tbl_filter(function(file) ---@param file string
        local ext = vim.fn.fnamemodify(file, ':e')
        return ext == 'cc' or ext == 'cpp' or ext == 'cxx'
      end, repo.files) > 0
    then
      table.insert(args, '-lstdc++')
    end
    if not iswin then
      table.insert(args, '-fPIC')
    end
    return args
  end
end

-- Returns the compile command based on the OS and user options
---@param repo InstallInfo
---@param cc string
---@param compile_location string
---@return Command
function M.select_compile_command(repo, cc, compile_location)
  local make = M.select_executable({ 'gmake', 'make' })
  if cc:find('cl$') or cc:find('cl.exe$') or not repo.use_makefile or iswin or not make then
    return {
      cmd = cc,
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = vim.tbl_flatten(M.select_compiler_args(repo, cc)),
        cwd = compile_location,
      },
    }
  else
    return {
      cmd = make,
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = {
          '--makefile=' .. utils.get_package_path('scripts', 'compile_parsers.makefile'),
          'CC=' .. cc,
        },
        cwd = compile_location,
      },
    }
  end
end

---@param repo InstallInfo
---@param project_name string
---@param cache_dir string
---@param revision string|nil
---@param prefer_git boolean
---@return table
function M.select_download_commands(repo, project_name, cache_dir, revision, prefer_git)
  local can_use_tar = vim.fn.executable('tar') == 1 and vim.fn.executable('curl') == 1
  local is_github = repo.url:find('github.com', 1, true)
  local is_gitlab = repo.url:find('gitlab.com', 1, true)
  local project_dir = utils.join_path(cache_dir, project_name)

  revision = revision or repo.branch or 'master'

  if can_use_tar and (is_github or is_gitlab) and not prefer_git then
    local url = repo.url:gsub('.git$', '')

    local dir_rev = revision
    if is_github and revision:find('^v%d') then
      dir_rev = revision:sub(2)
    end

    local temp_dir = project_dir .. '-tmp'

    return {
      {
        cmd = function()
          vim.fn.delete(temp_dir, 'rf')
        end,
      },
      {
        cmd = 'curl',
        info = 'Downloading ' .. project_name .. '...',
        err = 'Error during download, please verify your internet connection',
        opts = {
          args = {
            '--silent',
            '-L', -- follow redirects
            is_github and url .. '/archive/' .. revision .. '.tar.gz'
              or url
                .. '/-/archive/'
                .. revision
                .. '/'
                .. project_name
                .. '-'
                .. revision
                .. '.tar.gz',
            '--output',
            project_name .. '.tar.gz',
          },
          cwd = cache_dir,
        },
      },
      {
        cmd = function()
          --TODO(clason): use vim.fn.mkdir(temp_dir, 'p') in case stdpath('cache') is not created
          uv.fs_mkdir(temp_dir, 493)
        end,
        info = 'Creating temporary directory',
        err = 'Could not create ' .. project_name .. '-tmp',
      },
      {
        cmd = 'tar',
        info = 'Extracting ' .. project_name .. '...',
        err = 'Error during tarball extraction.',
        opts = {
          args = {
            '-xvzf',
            project_name .. '.tar.gz',
            '-C',
            project_name .. '-tmp',
          },
          cwd = cache_dir,
        },
      },
      {
        cmd = function()
          uv.fs_unlink(project_dir .. '.tar.gz')
        end,
      },
      {
        cmd = function()
          uv.fs_rename(
            utils.join_path(temp_dir, url:match('[^/]-$') .. '-' .. dir_rev),
            project_dir
          )
        end,
      },
      {
        cmd = function()
          vim.fn.delete(temp_dir, 'rf')
        end,
      },
    }
  else
    local git_dir = project_dir
    local clone_error = 'Error during download, please verify your internet connection'

    return {
      {
        cmd = 'git',
        info = 'Downloading ' .. project_name .. '...',
        err = clone_error,
        opts = {
          args = {
            'clone',
            repo.url,
            project_name,
          },
          cwd = cache_dir,
        },
      },
      {
        cmd = 'git',
        info = 'Checking out locked revision',
        err = 'Error while checking out revision',
        opts = {
          args = {
            'checkout',
            revision,
          },
          cwd = git_dir,
        },
      },
    }
  end
end

--TODO(clason): only needed for iter_cmd_sync -> replace with uv.spawn?

-- Convert path for cmd.exe on Windows (needed when shellslash is set)
---@param p string
---@return string
local function cmdpath(p)
  return vim.o.shellslash and p:gsub('/', '\\') or p
end

---@param dir string
---@param command string
---@return string command
function M.make_directory_change_for_command(dir, command)
  if iswin then
    if string.find(vim.o.shell, 'cmd') ~= nil then
      return string.format('pushd %s & %s & popd', cmdpath(dir), command)
    else
      return string.format('pushd %s ; %s ; popd', cmdpath(dir), command)
    end
  else
    return string.format('cd %s;\n %s', dir, command)
  end
end

return M
