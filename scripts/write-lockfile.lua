-- Execute as `nvim --headless -c "luafile ./scripts/write-lockfile.lua"`
require 'nvim-treesitter.install'.write_lockfile('verbose')
vim.cmd('q')
