#!/usr/bin/env -S nvim -l
vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')
local parsers = require('nvim-treesitter.parsers')

local jobs = {} ---@type table<string,vim.SystemObj>
local updates = {} ---@type string[]

-- check for new revisions
for k, p in pairs(parsers) do
  if p.tier < 5 and p.install_info then
    print('Updating ' .. k)
    jobs[k] = vim.system({ 'git', 'ls-remote', p.install_info.url })
  end

  if #vim.tbl_keys(jobs) % 100 == 0 or next(parsers, k) == nil then
    for name, job in pairs(jobs) do
      local stdout = vim.split(job:wait().stdout, '\n')
      jobs[name] = nil

      local info = parsers[name].install_info
      assert(info)

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

      local sha = vim.split(stdout[line], '\t')[1]
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

  local update_list = table.concat(updates, ', ')
  print(string.format('\nUpdated parsers: %s', update_list))
  -- pass list to workflow
  if os.getenv('GITHUB_ENV') then
    local env = io.open(os.getenv('GITHUB_ENV'), 'a')
    env:write(string.format('UPDATED_PARSERS=%s\n', update_list))
    env:close()
  end
else
  print('\nAll parsers up to date!')
end
