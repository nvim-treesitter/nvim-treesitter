-- Execute as `nvim --headless -c "luafile ./scripts/write-lockfile.lua"`
local only_working = vim.fn.getenv('LOCKFILE_ONLY_UPDATE_WORKING_LANGS') == '1'
require 'nvim-treesitter.install'.write_lockfile('verbose', only_working)
vim.cmd('q')
