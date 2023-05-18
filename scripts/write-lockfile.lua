-- Execute as `nvim --clean -l ./scripts/write-lockfile.lua`
vim.opt.runtimepath:append('.')
local utils = require('nvim-treesitter.utils')
local parsers = require('nvim-treesitter.parsers')

---@type string|any[]
local skip_langs = vim.fn.getenv('SKIP_LOCKFILE_UPDATE_FOR_LANGS')

if skip_langs == vim.NIL then
  skip_langs = {}
else
  ---@diagnostic disable-next-line: param-type-mismatch
  skip_langs = vim.fn.split(skip_langs, ',')
end

vim.print('Skipping languages: ', skip_langs)

-- Load previous lockfile
local filename = utils.get_package_path('lockfile.json')
local lockfile = vim.fn.filereadable(filename) == 1
    and vim.fn.json_decode(vim.fn.readfile(filename))
  or {}

local sorted_parsers = {}
for k, v in pairs(parsers.configs) do
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
vim.fn.writefile(
  vim.fn.split(vim.fn.json_encode(lockfile), '\n'),
  utils.get_package_path('lockfile.json')
)
