-- Loaded by the Nvim test harness (`--helper`, see Makefile) before running the specs.
vim.opt.rtp:prepend('.')
vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site')
vim.cmd('filetype plugin indent on')
-- Regex syntax is not needed (and with `-l`, its FileType autocommand runs before the one below, so
-- every buffer would load its syntax file before Treesitter takes over).
vim.cmd('syntax off')
vim.cmd.runtime({ 'plugin/query_predicates.lua', bang = true })
vim.cmd.runtime({ 'plugin/filetypes.lua', bang = true })

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
