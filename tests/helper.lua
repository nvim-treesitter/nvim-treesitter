-- Loaded by the Nvim test harness (`--helper`, see Makefile) before running the specs.
-- The specs run their checks in a separate Nvim, the Nvim under test ($NVIM_PRG, default: the Nvim
-- running the harness), see tests/sut.lua.

-- Keep the RPC client and its session state loaded across spec files.
require('test.functional.testnvim')()

-- Don't let the Nvim under test inherit the runtime files of the Nvim running the harness.
vim.env.VIMRUNTIME = nil
vim.env.VIM = nil
