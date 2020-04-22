[![Gitter](https://badges.gitter.im/nvim-treesitter/community.svg)](https://gitter.im/nvim-treesitter/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
# nvim-treesitter
Treesitter configurations and abstraction layer for Neovim.

# Quickstart

## Requirements
  - Neovim nightly ([more](https://github.com/neovim/neovim#install-from-source))
  - `git` in you path.
  - A C compiler in you path.

## Installation

You can install `nvim-treesitter` with you favorite package manager, or even using the default `pack` feature of neovim !

### Using a package manager

Simply add these lines to your `init.vim` :
```vim
Plug 'nvim-treesitter/nvim-treesitter'
```

### Using neovim `pack` feature

As this is a bit more advanced, we highly recommend reading `:h packages`, but you can also follow these steps:
```sh
$ mkdir -p ~/.local/share/nvim/site/pack/nvim-treesitter/start
$ cd ~/.local/share/nvim/site/pack/nvim-treesitter/start
$ git clone https://github.com/nvim-treesitter/nvim-treesitter.git
```

## Adding parsers

Treesitter is based on a _parser_ for each language. Installing them can be quite a pain, but fortunately `nvim-treesitter` provides two
command to tackle this for you :
  - `TSInstall` to install a given parser.
  - `TSInstallInfo` to know which parser is installed.

Let's say you want to have a parser for `lua`, `c`, and `python`, here is how to use the commands :
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

Cool, let's check which parser is installed now:
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

And now you should be able to use every functionnality `nvim-treesitter` provides !

## Features and Roadmap

The goal of `nvim-treesitter` is both to provide a simple and easy to use interface to treesitter in neovim, and to add some
functionnalities to use it out of the box.
Some of these features are :
  - [ ] Incremental selection
  - [ ] Syntax based code folding
  - [ ] Consistent syntax highlighting

You can find the roadmap [here](https://github.com/nvim-treesitter/nvim-treesitter/projects/1). This roadmap and all features
of this plugin are everything but definitively determined, and any suggestion will be highly apreciated !

## Troubleshooting
Before doing anything run `:checkhealth nvim_treesitter`. This will give a better overview of which part of the plugin is the
source of the bug.

### Feature `X` does not work for language `Y`...
First, check in the `## Y parser healthcheck` section of `:checkhealth` if you have any warning.
If you do, it is highly possible that this is the cause of the problem.
If everything is okay, then it might be an actual error.

In both cases, feel free to open an issue here.


