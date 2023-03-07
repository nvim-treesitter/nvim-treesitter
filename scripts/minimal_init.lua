vim.opt.runtimepath:append "."
vim.cmd [[runtime! plugin/plenary.vim]]
vim.cmd [[runtime! plugin/nvim-treesitter.lua]]

vim.cmd [[au BufRead,BufNewFile *.conf set filetype=hocon]]
vim.cmd [[au BufRead,BufNewFile *.gleam set filetype=gleam]]

vim.o.swapfile = false
vim.bo.swapfile = false

require("nvim-treesitter.configs").setup {
  indent = { enable = true },
  highlight = { enable = true },
}

-- Load the plenary.nvim module with vim-plug if present.
-- Note that since vim-plug is an autoload module, which means we need to call
-- `runtime autoload/plug.vim` load load it before checking if the `plug#begin` function exists.
-- See: https://vi.stackexchange.com/questions/38490/how-to-check-if-an-autoload-function-exists-without-calling-it
vim.cmd [[
runtime autoload/plug.vim
if exists('*plug#begin')
  call plug#begin()
  Plug 'nvim-lua/plenary.nvim'
  call plug#end()
endif
]]
