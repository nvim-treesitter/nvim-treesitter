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

---@type async.Task
local task = update and require('nvim-treesitter').update('all', { summary = true })
  or require('nvim-treesitter').install(
    #parsers > 0 and parsers or 'all',
    { force = true, summary = true, generate = generate, max_jobs = max_jobs }
  )

local ok, err_or_ok = task:pwait(1800000) -- wait max. 30 minutes
if not ok then
  print('ERROR: ', err_or_ok)
  vim.cmd.cq()
elseif not err_or_ok then
  vim.cmd.cq()
end
