[![Gitter](https://badges.gitter.im/nvim-treesitter/community.svg)](https://gitter.im/nvim-treesitter/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
# nvim-treesitter
Treesitter configurations and abstraction layer for Neovim.

# Quickstart

## Requirements
  - Neovim [nightly](https://github.com/neovim/neovim#install-from-source)
  - `git` in your path.
  - A C compiler in your path.

## Installation

You can install `nvim-treesitter` with your favorite package manager, or using the default `pack` feature of Neovim!

### Using a package manager

Simply add these lines to your `init.vim` :
```vim
Plug 'nvim-treesitter/nvim-treesitter'
```

### Using neovim `pack` feature

We highly recommend reading `:h packages` to learn more about this feature, but you can still follow these steps:
```sh
$ mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
$ cd ~/.local/share/nvim/site/pack/nvim-treesitter/start
$ git clone https://github.com/nvim-treesitter/nvim-treesitter.git
```

## Adding parsers

Treesitter is using a different _parser_ for every language. It can be quite a pain to install, but fortunately `nvim-treesitter` 
provides two command to tackle this issue:
  - `TSInstall` to install a given parser.
  - `TSInstallInfo` to know which parser is installed.

Let's say you need parsers for `lua`, `c`, and `python`, this is how you do with these commands:
```vim
:TSInstall c
Downloading...
Compiling...
Treesitter parser for c has been installed

:TSInstall lua
Downloading...
Compiling...
Treesitter parser for lua has been installed

:TSInstall python
Downloading...
Compiling...
Treesitter parser for python has been installed
```

Cool, lets see which parsers are installed:
```vim
:TSInstallInfo
csharp     [✗] not installed
html       [✗] not installed
typescript [✗] not installed
c          [✓] installed
swift      [✗] not installed
java       [✗] not installed
python     [✓] installed
cpp        [✗] not installed
lua        [✓] installed
ruby       [✗] not installed
ocaml      [✗] not installed
go         [✗] not installed
rust       [✗] not installed
json       [✗] not installed
javascript [✗] not installed
css        [✗] not installed
julia      [✗] not installed
php        [✗] not installed
bash       [✗] not installed
tsx        [✗] not installed
```

And now you should be able to use every functionality `nvim-treesitter` provides!

## Setup

in your `init.vim`:

```lua
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,                    -- false will disable the whole extension
        disable = { 'c', 'rust' },        -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        disable = { 'cpp', 'lua' },
        keymaps = {                       -- mappings for incremental selection (visual mappings)
          init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
          node_incremental = "grn",       -- increment to the upper named parent
          scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
          scope_decremental = "grm",      -- decrement to the previous scope
        }
    },
    ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
EOF
```

## Commands

Each feature can be enabled or disabled by different means:
```vim
:TSBufEnable {module} " enable module on current buffer
:TSBufDisable {module} " disable module on current buffer
:TSEnableAll {module} [{ft}] " enable module on every buffer. If filetype is specified, enable only for this filetype.
:TSDisableAll {module} [{ft}] " disable module on every buffer. If filetype is specified, disable only for this filetype.
:TSModuleInfo [{module}] " list information about modules state for each filetype
```

## Features and Roadmap

The goal of `nvim-treesitter` is both to provide a simple and easy way to use the interface for Treesitter in Neovim,
but also to add some functionalities to it:
Some of these features are :
  - [x] Incremental selection
  - [ ] Syntax based code folding
  - [x] Consistent syntax highlighting (the api is not quite stable yet)
  - [x] Statusline indicator (`require'nvim-treesitter'.statusline(size)`)

You can find the roadmap [here](https://github.com/nvim-treesitter/nvim-treesitter/projects/1).
The roadmap and all features of this plugin are open to change, and any suggestion will be highly appreciated!

## Api

Nvim-treesitter exposes an api to extend node capabilites. You can retrieve the api like this:
```lua
local ts_node_api = require 'nvim-treesitter'.get_node_api()
```

You can also retrieve the current state of the current buffer with:
```lua
local buf_state = require'nvim-treesitter'.get_buf_state()
```

More information is available in neovim documentation (`:help nvim-treesitter-api`).

## Supported Languages

For treesitter to work, we need to use query files such as those you can find in `queries/{lang}/{locals,highlights}.scm`

We are looking for maintainers to write query files for their languages.

List of currently supported languages:
- [x] lua  (maintained by @vigoux)
- [x] ruby (maintained by @TravonteD)
- [x] c (maintained by @vigoux)
- [ ] go
- [ ] cpp
- [ ] rust
- [x] python (maintained by @theHamsta)
- [ ] javascript
- [ ] typescript
- [ ] tsx
- [ ] json
- [ ] html
- [ ] csharp
- [ ] swift
- [ ] java
- [ ] ocaml
- [ ] css
- [ ] julia
- [ ] php
- [ ] bash
- [ ] scala
- [ ] haskell
- [ ] toml
- [ ] vue
- [ ] elm
- [ ] yaml
- [ ] nix
- [ ] markdown

## Troubleshooting
Before doing anything run `:checkhealth nvim_treesitter`. This will help you find where the bug might come from.

### Feature `X` does not work for language `Y`...
First, check the `## Y parser healthcheck` section of `:checkhealth` if you have any warning.
If you do, it's highly possible that this is the cause of the problem.
If everything is okay, then it might be an actual error.

In both cases, feel free to open an issue here.
