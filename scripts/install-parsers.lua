#!/usr/bin/env -S nvim -l

local generate = false
local max_jobs = nil ---@as integer
local parsers = {}
for i = 1, #_G.arg do
  if _G.arg[i] == '--generate' then
    generate = true
  elseif _G.arg[i]:find('^%-%-max%-jobs') then
    max_jobs = _G.arg[i]:match('=(%d+)')
  else
    parsers[#parsers + 1] = _G.arg[i]
  end
end

vim.opt.runtimepath:append('.')

-- needed on CI
vim.fn.mkdir(vim.fn.stdpath('cache'), 'p')

local ok = nil
require('nvim-treesitter.install').install(
  #parsers > 0 and parsers or 'all',
  { force = true, generate = generate, max_jobs = max_jobs },
  function(success)
    ok = success
  end
)

vim.wait(6000000, function()
  return ok ~= nil
end)
if not ok then
  vim.cmd.cq()
end
