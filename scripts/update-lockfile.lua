#!/usr/bin/env -S nvim -l

vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')
local parsers = require('lua.nvim-treesitter.parsers')

-- Load previous lockfile
local filename = require('nvim-treesitter.install').get_package_path('lockfile.json')
local lockfile = vim.json.decode(util.read_file(filename))

---@type string?
local skip_lang_string = os.getenv('LOCKFILE_SKIP')
local skip_langs = skip_lang_string and vim.split(skip_lang_string, ',') or {}
vim.print('Skipping languages: ', skip_langs)

-- check for new revisions
for _, name in ipairs(parsers.get_names()) do
  local config = parsers.configs[name]
  if not vim.list_contains(skip_langs, name) and config.install_info then
    local sha ---@type string
    if config.install_info.branch then
      sha = vim.split(
        vim.fn.systemlist(
          'git ls-remote '
            .. config.install_info.url
            .. ' | grep refs/heads/'
            .. config.install_info.branch
        )[1],
        '\t'
      )[1]
    else
      sha = vim.split(vim.fn.systemlist('git ls-remote ' .. config.install_info.url)[1], '\t')[1]
    end
    lockfile[name] = { revision = sha }
    print(name .. ': ' .. sha)
  else
    print('Skipping ' .. name)
  end
end

lockfile = vim.json.encode(lockfile)
if vim.fn.executable('jq') == 1 then
  lockfile = vim.fn.system('jq --sort-keys', lockfile)
end
util.write_file(filename, lockfile)
