local api = vim.api
local fn = vim.fn
local luv = vim.loop

local M = {}
local repositories = {
  javascript = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = { "src/parser.c", "src/scanner.c" },
  },
  c = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = { "src/parser.c" }
  },
  cpp = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" }
  },
  rust = {
    url = "https://github.com/tree-sitter/tree-sitter-rust",
    files = { "src/parser.c", "src/scanner.c" },
  },
  lua = {
    url = "https://github.com/nvim-treesitter/tree-sitter-lua",
    files = { "src/parser.c", "src/scanner.cc" }
  },
  python = {
    url = "https://github.com/tree-sitter/tree-sitter-python",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  go = {
    url = "https://github.com/tree-sitter/tree-sitter-go",
    files = { "src/parser.c" },
  },
  ruby = {
    url = "https://github.com/tree-sitter/tree-sitter-ruby",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  bash = {
    url = "https://github.com/tree-sitter/tree-sitter-bash",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  php = {
    url = "https://github.com/tree-sitter/tree-sitter-php",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  java = {
    url = "https://github.com/tree-sitter/tree-sitter-java",
    files = { "src/parser.c" },
  },
  html = {
    url = "https://github.com/tree-sitter/tree-sitter-html",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  julia = {
    url = "https://github.com/tree-sitter/tree-sitter-julia",
    files = { "src/parser.c", "src/scanner.c" },
  },
  json = {
    url = "https://github.com/tree-sitter/tree-sitter-json",
    files = { "src/parser.c" },
  },
  css = {
    url = "https://github.com/tree-sitter/tree-sitter-css",
    files = { "src/parser.c", "src/scanner.c" },
  },
  ocaml = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  swift = {
    url = "https://github.com/tree-sitter/tree-sitter-swift",
    files = { "src/parser.c" },
  },
  -- TODO: find a way to install c-sharp and typescript properly
  -- csharp = {
  --   url = "https://github.com/tree-sitter/tree-sitter-c-sharp",
  --   files = { "src/parser.c", "src/scanner.c" },
  -- },
}

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
  local project_repo = cache_folder..'/tree-sitter-'..ft
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
        args = { 'clone', repo.url },
        cwd = cache_folder,
      },
    },
    {
      cmd = 'cc',
      info = 'Compiling...',
      err = 'Error during compilation',
      opts = {
        args = { '-o', 'parser.so', '-shared', '-lstdc++', unpack(repo.files), '-Os', '-I./src' },
        cwd = project_repo
      }
    },
    {
      cmd = 'mv',
      opts = {
        args = { project_repo..'/parser.so', parser_lib_name }
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
function M.install_parser(ft)
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

  if fn.executable('git') == 0 then
    return api.nvim_err_writeln('Git is required on your system to run this command')
  end

  local package_path, err = get_package_path()
  if err then return api.nvim_err_writeln(err) end

  local cache_folder, err = get_cache_dir()
  if err then return api.nvim_err_writeln(err) end

  run_install(cache_folder, package_path, ft, repository)
end

return M
