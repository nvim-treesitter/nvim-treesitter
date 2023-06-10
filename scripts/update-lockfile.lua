#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')

-- Load previous lockfile
local filename = require('nvim-treesitter.install').get_package_path('lockfile.json')
local old_lockfile = vim.json.decode(util.read_file(filename)) --[[@as table<string,{revision:string}>]]

---@type table<string,{revision:string}>
local new_lockfile = {}

local parsers = require('nvim-treesitter.parsers').configs

local jobs = {} --- @type table<string,SystemObj>

-- check for new revisions
for k, p in pairs(parsers) do
  if p.tier == 4 then
    new_lockfile[k] = old_lockfile[k]
    print('Skipping ' .. k)
  elseif p.install_info then
    jobs[k] = vim.system({ 'git', 'ls-remote', p.install_info.url })
  end

  if #vim.tbl_keys(jobs) % 100 == 0 or next(parsers, k) == nil then
    for name, job in pairs(jobs) do
      local stdout = vim.split(job:wait().stdout, '\n')
      jobs[name] = nil

      local branch = parsers[name].install_info.branch

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
      new_lockfile[name] = { revision = sha }
      print(name .. ': ' .. sha)
    end
  end
end

assert(#vim.tbl_keys(jobs) == 0)

local lockfile_json = vim.json.encode(new_lockfile) --[[@as string]]
if vim.fn.executable('jq') == 1 then
  lockfile_json =
    assert(vim.system({ 'jq', '--sort-keys' }, { stdin = lockfile_json }):wait().stdout)
end

util.write_file(filename, lockfile_json)
