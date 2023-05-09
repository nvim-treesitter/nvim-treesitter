vim.opt.runtimepath:append "."
vim.cmd.runtime { "plugin/plenary.vim", bang = true }
vim.cmd.runtime { "plugin/nvim-treesitter.lua", bang = true }

vim.filetype.add {
  extension = {
    conf = "hocon",
    ncl = "nickel",
    usd = "usd",
    usda = "usd",
  },
}

vim.o.swapfile = false
vim.bo.swapfile = false

require('nvim-treesitter').setup({
  indent = { enable = true },
  highlight = { enable = true },
})
