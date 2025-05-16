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

local ok = update and require('nvim-treesitter.install').update('all'):wait(6000000)
  or require('nvim-treesitter.install')
    .install(#parsers > 0 and parsers or 'all', { force = true, generate = generate, max_jobs = max_jobs })
    :wait(6000000)

if not ok then
  vim.cmd.cq()
end
