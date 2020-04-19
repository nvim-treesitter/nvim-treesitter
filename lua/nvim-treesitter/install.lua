local api = vim.api
local fn = vim.fn

local M = {}
local package_path = nil
local repositories = {
  javascript = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = "src/parser.c src/scanner.c",
  },
  c = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = "src/parser.c"
  }
}

-- TODO(kyazdani): there might be a better way to get the plugin path
for _, path in pairs(api.nvim_list_runtime_paths()) do
  if string.match(path, '.*/nvim%-treesitter') then
    package_path = path
    break
  end
end

local function create_compile_command(ft, path, files)
  -- TODO(kyazdani): should download the parser in $XDG_CACHE_HOME instead of /tmp
  return "cd /tmp/tree-sitter-"..ft..[[ && \
    gcc -o parser.so -shared ]]..files..[[ -Os -I./src && \
    mv parser.so ]]..path.."/parsers/"..ft..[[.so && \
    rm -rf /tmp/tree-sitter-]]..ft
end

local function create_download_command(url)
  return "cd /tmp && git clone "..url
end

function M.install_parser(lang)
  if fn.has('win32') == 1 then
    -- TODO(kyazdani): this should work on windows too
    api.nvim_err_writeln('This command is not available on windows at the moment.')
    return
  end

  if not lang then
    api.nvim_err_writeln("usage: install_parser('language')")
    return
  end

  local repository = repositories[lang]
  if not repository then
    api.nvim_err_writeln('Parser not available for language '..lang)
    return
  end

  if not package_path then
    api.nvim_err_writeln('Plugin runtime path not found.')
    return
  end

  if not fn.executable('git') == 1 then
    api.nvim_err_writeln('Please install `git` to download parsers.')
    return
  end

  print("Downloading parser...")
  fn.system(create_download_command(repository.url))

  print("Compiling parser...")
  fn.system(create_compile_command(lang, package_path, repository.files))

  print("Install for the " ..lang.." parser was successfull")
end

return M
