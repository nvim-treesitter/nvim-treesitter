#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')

-- Load previous lockfile
local filename = require('nvim-treesitter.install').get_package_path('lockfile.json')
local lockfile = vim.json.decode(util.read_file(filename))

---@type string?
local skip_lang_string = os.getenv('LOCKFILE_SKIP')
local skip_langs = skip_lang_string and vim.split(skip_lang_string, ',') or {}
vim.print('Skipping languages: ', skip_langs)

local sorted_parsers = {}
for k, v in pairs(require('nvim-treesitter.parsers').configs) do
  table.insert(sorted_parsers, { name = k, parser = v })
end
table.sort(sorted_parsers, function(a, b)
  return a.name < b.name
end)

-- check for new revisions
for _, v in ipairs(sorted_parsers) do
  if not vim.list_contains(skip_langs, v.name) and v.parser.install_info then
    local cmd = 'git ls-remote ' .. v.parser.install_info.url
    if v.parser.install_info.branch then
      cmd = cmd .. ' | grep refs/heads/' .. v.parser.install_info.branch
    end
    local sha = vim.split(vim.fn.systemlist(cmd)[1], '\t')[1]
    lockfile[v.name] = { revision = sha }
    print(v.name .. ': ' .. sha)
  else
    print('Skipping ' .. v.name)
  end
end

lockfile = vim.json.encode(lockfile)
if vim.fn.executable('jq') == 1 then
  lockfile = vim.fn.system('jq --sort-keys', lockfile)
end
util.write_file(filename, lockfile)
