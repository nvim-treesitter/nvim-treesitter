#!/usr/bin/env -S nvim -l

local generate = false
local update = false
local max_jobs = nil ---@type integer?
local parsers = {}
for i = 1, #_G.arg do
  if _G.arg[i] == '--generate' then
    generate = true
  elseif _G.arg[i] == '--update' then
    update = true
  elseif _G.arg[i]:find('^%-%-max%-jobs') then
    max_jobs = _G.arg[i]:match('=(%d+)')
  else
    parsers[#parsers + 1] = _G.arg[i] ---@type string
  end
end

vim.opt.runtimepath:append('.')

-- needed on CI
vim.fn.mkdir(vim.fn.stdpath('cache'), 'p')

local done = nil
if update then
  require('nvim-treesitter.install').update('all'):await(function(_err, ok)
    done = ok
  end)
else
  require('nvim-treesitter.install')
    .install(#parsers > 0 and parsers or 'all', { force = true, generate = generate, max_jobs = max_jobs })
    :await(function(_err, ok)
      done = ok
    end)
end

vim.wait(6000000, function()
  return done ~= nil
end)
if not done then
  vim.cmd.cq()
end
