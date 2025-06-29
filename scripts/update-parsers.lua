#!/usr/bin/env -S nvim -l
-- Update parsers to latest version (tier 1, stable) or commit (tier 2, unstable)
--
-- Usage:
-- nvim -l update-parsers.lua            # update all (stable and unstable) parsers
-- nvim -l update-parsers.lua --tier=1   # update stable parsers to latest version
-- nvim -l update-parsers.lua --tier=2   # update unstable parsers to latest commit

local tier = nil ---@type integer?
for i = 1, #_G.arg do
  if _G.arg[i]:find('^%-%-tier=') then
    tier = tonumber(_G.arg[i]:match('=(%d+)'))
  end
end

vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')
local parsers = require('nvim-treesitter.parsers')

local jobs = {} ---@type table<string,vim.SystemObj>
local updates = {} ---@type string[]

-- check for new revisions
for k, p in pairs(parsers) do
  if p.tier <= 2 and (tier == nil or p.tier == tier) and p.install_info then
    print('Updating ' .. k)
    local cmd = p.tier == 1
        and {
          'git',
          '-c',
          'versionsort.suffix=-',
          'ls-remote',
          '--tags',
          '--refs',
          '--sort=v:refname',
          p.install_info.url,
        }
      or { 'git', 'ls-remote', p.install_info.url }
    jobs[k] = vim.system(cmd)
  end

  if #vim.tbl_keys(jobs) % 100 == 0 or next(parsers, k) == nil then
    for name, job in pairs(jobs) do
      local stdout = vim.split(job:wait().stdout, '\n')
      jobs[name] = nil

      local info = parsers[name].install_info
      assert(info)

      local sha ---@type string
      if parsers[name].tier == 1 then
        sha = stdout[#stdout - 1]:match('v[%d%.]+$')
      else
        local branch = info.branch
        local line = 1
        if branch then
          for j, l in ipairs(stdout) do
            if l:find(vim.pesc(branch)) then
              line = j
              break
            end
          end
        end
        sha = vim.split(stdout[line], '\t')[1]
      end

      if info.revision ~= sha then
        info.revision = sha
        updates[#updates + 1] = name
      end
    end
  end
end

assert(#vim.tbl_keys(jobs) == 0)

if #updates > 0 then
  -- write new parser file
  local header = '---@type nvim-ts.parsers\nreturn '
  local parser_file = header .. vim.inspect(parsers)
  if vim.fn.executable('stylua') == 1 then
    parser_file = vim.system({ 'stylua', '-' }, { stdin = parser_file }):wait().stdout --[[@as string]]
  end
  util.write_file('lua/nvim-treesitter/parsers.lua', parser_file)

  table.sort(updates)
  local update_list = table.concat(updates, ', ')
  print(string.format('\nUpdated parsers: %s', update_list))
  -- pass list to workflow
  local gh_env = os.getenv('GITHUB_ENV')
  if gh_env then
    local env = assert(io.open(gh_env, 'a'))
    env:write(string.format('UPDATED_PARSERS=%s\n', update_list))
    env:close()
  end
else
  print('\nAll parsers up to date!')
end
