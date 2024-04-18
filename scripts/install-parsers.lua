#!/usr/bin/env -S nvim -l

local generate = false
local parsers = {}
for i = 1, #_G.arg do
  if _G.arg[i] == '--generate' then
    generate = true
  else
    parsers[#parsers + 1] = _G.arg[i]
  end
end

vim.opt.runtimepath:append('.')

-- needed on CI
vim.fn.mkdir(vim.fn.stdpath('cache'), 'p')

local done = false
require('nvim-treesitter.install').install(
  #parsers > 0 and parsers or 'all',
  { force = true, generate = generate },
  function()
    done = true
  end
)

vim.wait(6000000, function()
  return done
end)
