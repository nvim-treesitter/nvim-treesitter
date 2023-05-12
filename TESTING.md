# Testing Guide

## Running tests for lazy.nvim users

The default `scripts/run_tests.sh` would not work with lazy.nvim users because
it's not aware of the `plenary.nvim` provided by `lazy.nvim`. Some adjustments
need to be applied before running tests.

First, make `plenary.nvim` available by prepending following lines to
`scripts/minimal_init.lua`:

```lua
-- prepend these lines to beginning of scripts/minimal_init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
vim.opt.rtp:prepend(lazypath)
```

Then add the `plenary.vim` so that nvim could use `PlenaryBustedDirectory`:

```sh
cp ~/.local/share/nvim/lazy/plenary.nvim/plugin/plenary.vim plugin/plenary.vim
```

Now test file could be run. For example after change indents.scm of ruby, run:

```sh
scripts/run_tests.sh indent/ruby_spec.lua
```

`vim-plug` users could take a look at [issue #2570](https://github.com/nvim-treesitter/nvim-treesitter/issues/2570).
