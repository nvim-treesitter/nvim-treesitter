-- Init file of the Nvim under test (started by tests/sut.lua).
vim.opt.rtp:prepend('.')
vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site')
-- for require('tests....') in code run with exec_lua()
package.path = './?.lua;' .. package.path
vim.cmd.filetype({ 'plugin', 'indent', 'on' })
-- Regex syntax is not needed (Treesitter takes over in the FileType autocommand below).
vim.cmd.syntax('off')

vim.filetype.add({
  extension = {
    conf = 'hocon',
    w = 'wing',
  },
})

vim.o.swapfile = false

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start)
    vim.bo[args.buf].indentexpr = require('nvim-treesitter').indentexpr
  end,
})
