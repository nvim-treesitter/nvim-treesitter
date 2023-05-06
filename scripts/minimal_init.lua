vim.opt.runtimepath:append "."
vim.cmd [[runtime! plugin/plenary.vim]]
vim.cmd [[runtime! plugin/nvim-treesitter.lua]]

vim.cmd [[au BufRead,BufNewFile *.conf set filetype=hocon]]
vim.cmd [[au BufRead,BufNewFile *.gleam set filetype=gleam]]
vim.cmd [[au BufRead,BufNewFile *.ncl set filetype=nickel]]
vim.cmd [[au BufRead,BufNewFile *.usd,*.usda set filetype=usd]]

vim.o.swapfile = false
vim.bo.swapfile = false

require("nvim-treesitter.configs").setup {
  indent = { enable = true },
  highlight = { enable = true },
}
