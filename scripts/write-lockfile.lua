#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')

-- Load previous lockfile
local filename = require('nvim-treesitter.utils').get_package_path('lockfile.json')
local file = assert(io.open(filename, 'r'))
local lockfile = vim.json.decode(file:read('*a'))
file:close()

---@type string?
local skip_lang_string = os.getenv('SKIP_LOCKFILE_UPDATE_FOR_LANGS')
local skip_langs = skip_lang_string and vim.split(skip_lang_string, ',') or {}
vim.print('Skipping languages: ', skip_langs)

local sorted_parsers = {}
local configs = require('nvim-treesitter.parsers').configs
for k, v in pairs(configs) do
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
vim.print(lockfile)

-- write new lockfile
file = assert(io.open(filename, 'w'))
file:write(vim.json.encode(lockfile))
file:close()
