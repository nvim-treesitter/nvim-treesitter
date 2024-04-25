vim.opt.runtimepath:append('.')
vim.cmd.runtime({ 'plugin/plenary.vim', bang = true })
vim.cmd.runtime({ 'plugin/nvim-treesitter.lua', bang = true })
vim.cmd.runtime({ 'plugin/query_predicates.lua', bang = true })
vim.cmd.runtime({ 'plugin/filetypes.lua', bang = true })

vim.filetype.add({
  extension = {
    conf = 'hocon',
    hurl = 'hurl',
    ncl = 'nickel',
    tig = 'tiger',
    w = 'wing',
  },
})

vim.o.swapfile = false
vim.bo.swapfile = false

require('nvim-treesitter').setup()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start)
    vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
  end,
})
