#!/usr/bin/env -S nvim -l

vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')

-- Load previous lockfile
local filename = require('nvim-treesitter.install').get_package_path('lockfile.json')
local lockfile = vim.json.decode(util.read_file(filename)) --[[@as table<string,{revision:string}>]]

---@type string?
local skip_lang_string = os.getenv('LOCKFILE_SKIP')
local skip_langs = skip_lang_string and vim.split(skip_lang_string, ',') or {}
vim.print('Skipping languages: ', skip_langs)

local sorted_parsers = {} --- @type {name:string,parser:ParserInfo}[]
for k, v in pairs(require('nvim-treesitter.parsers').configs) do
  table.insert(sorted_parsers, { name = k, parser = v })
end
table.sort(sorted_parsers, function(a, b)
  return a.name < b.name
end)

local jobs = {} --- @type table<{name:string,parser:ParserInfo},SystemObj>

-- check for new revisions
for i, v in ipairs(sorted_parsers) do
  -- keep spawning jobs until we hit EMFILE
  local ok, err = pcall(function()
    if vim.list_contains(skip_langs, v.name) or not v.parser.install_info then
      print('Skipping ' .. v.name)
      return
    end

    jobs[v] = vim.system({ 'git', 'ls-remote', v.parser.install_info.url })
  end)

  if not ok or i == #sorted_parsers then
    if err and not err:match('EMFILE') then
      error(err)
    end

    for vi, job in pairs(jobs) do
      local stdout = vim.split(job:wait().stdout, '\n')
      jobs[vi] = nil

      local branch = vi.parser.install_info.branch

      local line = 1
      if branch then
        for j, l in ipairs(stdout) do
          if l:find(vim.pesc(branch)) then
            line = j
            break
          end
        end
      end

      local sha = vim.split(stdout[line], '\t')[1]
      lockfile[vi.name] = { revision = sha }
      print(vi.name .. ': ' .. sha)
    end
  end
end

assert(#vim.tbl_keys(jobs) == 0)

local lockfile_json = vim.json.encode(lockfile) --[[@as string]]
if vim.fn.executable('jq') == 1 then
  lockfile_json =
    assert(vim.system({ 'jq', '--sort-keys' }, { stdin = lockfile_json }):wait().stdout)
end
util.write_file(filename, lockfile_json)
