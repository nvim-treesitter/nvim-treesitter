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
  if skip_langs and not vim.list_contains(skip_langs, v.name) then
    local sha ---@type string
    if v.parser.install_info.branch then
      sha = vim.split(
        vim.fn.systemlist(
          'git ls-remote '
            .. v.parser.install_info.url
            .. ' | grep refs/heads/'
            .. v.parser.install_info.branch
        )[1],
        '\t'
      )[1]
    else
      sha = vim.split(vim.fn.systemlist('git ls-remote ' .. v.parser.install_info.url)[1], '\t')[1]
    end
    lockfile[v.name] = { revision = sha }
    print(v.name .. ': ' .. sha)
  else
    print('Skipping ' .. v.name)
  end
end

lockfile = vim.fn.system('jq --sort-keys', vim.json.encode(lockfile))
util.write_file(filename, lockfile)
