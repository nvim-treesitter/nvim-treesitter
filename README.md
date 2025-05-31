<h1 align="center">
  <img src="https://github.com/nvim-treesitter/nvim-treesitter/assets/2361214/0513b223-c902-4f12-92ee-8ac4d8d6f41f" alt="nvim-treesitter">
</h1>

The `nvim-treesitter` plugin provides
1. functions for installing, updating, and removing [**tree-sitter parsers**](SUPPORTED_LANGUAGES.md);
2. a collection of **queries** for enabling tree-sitter features built into Neovim for these languages;
3. a staging ground for [treesitter-based features](#Supported-features) considered for upstreaming to Neovim.

For details on these and how to help improving them, see [CONTRIBUTING.md](./CONTRIBUTING.md).

>[!CAUTION]
> This is a full, incompatible, rewrite. If you can't or don't want to update, check out the [`master` branch](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md) (which is locked but will remain available for backward compatibility).

# Quickstart

## Requirements

- Neovim 0.11.0 or later (nightly)
- `tar` and `curl` in your path
- [`tree-sitter`](https://github.com/tree-sitter/tree-sitter) CLI (0.25.0 or later)
- a C compiler in your path (see <https://docs.rs/cc/latest/cc/#compile-time-requirements>)
- `Node` (23.0.0 or later) for some parsers (see the [list of supported languages](SUPPORTED_LANGUAGES.md))

>[!IMPORTANT]
> The **support policy** for Neovim is
> 1. the _latest_ [stable release](https://github.com/neovim/neovim/releases/tag/stable);
> 2. the _latest_ [nightly prerelease](https://github.com/neovim/neovim/releases/tag/nightly).
> Other versions may work but are neither tested nor considered for fixes. In general, compatibility with Nvim 0.X is removed after the release of Nvim 0.(X+1).1.

## Installation

You can install `nvim-treesitter` with your favorite package manager (or using the native `package` feature of vim, see `:h packages`).

This plugin is only guaranteed to work with specific versions of language parsers** (as specified in the `parser.lua` table). **When upgrading the plugin, you must make sure that all installed parsers are updated to the latest version** via `:TSUpdate`.
It is strongly recommended to automate this; e.g., using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require('lazy').setup({
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate'
})
```

>[!IMPORTANT]
> This plugin does not support lazy-loading.

>[!IMPORTANT]
> Make sure to specify the `main` branch since (for now) the default branch is [`master`](https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md).

## Setup

`nvim-treesitter` can be configured by calling `setup`. The following snippet lists the available options and their default values. **You do not need to call `setup` for `nvim-treesitter` to work using default values.**

```lua
require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site'
}
```

Parsers and queries can then be installed with

```lua
require'nvim-treesitter'.install { 'rust', 'javascript', 'zig' }
```

(This is a no-op if the parsers are already installed.) Note that this function runs asynchronously; for synchronous installation in a script context ("bootstrapping"), you need to `wait()` for it to finish:

```lua
require('nvim-treesitter').install({ 'rust', 'javascript', 'zig' }):wait(300000) -- wait max. 5 minutes
```

Check [`:h nvim-treesitter-commands`](doc/nvim-treesitter.txt) for a list of all available commands.

# Supported languages

For `nvim-treesitter` to support a specific feature for a specific language requires both a parser for that language and an appropriate language-specific query file for that feature.

A list of the currently supported languages can be found [on this page](SUPPORTED_LANGUAGES.md). If you wish to add a new language or improve the queries for an existing one, please see our [contributing guide](CONTRIBUTING.md).

For related information on the supported languages, including related plugins, see [this wiki page](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Supported-Languages-Information).

# Supported features

`nvim-treesitter` provides queries for the following features. **These are not automatically enabled.**

## Highlighting

Treesitter highlighting is provided by Neovim, see `:h treesitter-highlight`. To enable it for a filetype, put `vim.treesitter.start()` in a `ftplugin/<filetype>.lua` in your config directory, or place the following in your `init.lua`:

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
```

## Folds

Treesitter-based folding is provided by Neovim. To enable it, put the following in your `ftplugin` or `FileType` autocommand:

```lua
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
```

## Indentation

Treesitter-based indentation is provided by this plugin but considered **experimental**. To enable it, put the following in your `ftplugin` or `FileType` autocommand:

```lua
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
```

(Note the specific quotes used.)

## Injections

Injections are used for multi-language documents, see `:h treesitter-language-injections`. No setup is needed.

## Locals

These queries can be used to look up definitions and references to identifiers in a given scope. They are not used in this plugin and are provided for (limited) backward compatibility.

# Advanced setup

## Adding custom languages

If you have a parser that is not on the list of supported languages (either as a repository on Github or in a local directory), you can add it manually for use by `nvim-treesitter` as follows:

1. Add the following snippet in a `User TSUpdate` autocommand:

```lua
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').zimbu = {
    install_info = {
      url = 'https://github.com/zimbulang/tree-sitter-zimbu',
      revision = <sha>, -- commit hash for revision to check out; HEAD if missing
      -- optional entries:
      branch = 'develop', -- only needed if different from default branch
      location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
      generate = true, -- only needed if repo does not contain pre-generated `src/parser.c`
      generate_from_json = false, -- only needed if repo does not contain `src/grammar.json` either
      queries = 'queries/neovim', -- also install queries from given directory
    },
  }
end})
```

Alternatively, if you have a local checkout, you can instead use

```lua
    install_info = {
      path = '~/parsers/tree-sitter-zimbu',
      -- optional entries
      location = 'parser',
      generate = true,
      generate_from_json = false,
      queries = 'queries/neovim', -- symlink queries from given directory
    },
```
This will always use the state of the directory as-is (i.e., `branch` and `revision` will be ignored).

2. If the parser name differs from the filetype(s) used by Neovim, you need to register the parser via

```lua
vim.treesitter.language.register('zimbu', { 'zu' })
```

If Neovim does not detect your language's filetype by default, you can use [Neovim's `vim.filetype.add()`](<https://neovim.io/doc/user/lua.html#vim.filetype.add()>) to add a custom detection rule.

3. Start `nvim` and `:TSInstall zimbu`.

>[!IMPORTANT]
> Parsers using external scanner need to be written in C.

### Modifying parsers

You can use the same approach for overriding parser information. E.g., if you always want to generate the `lua` parser from grammar, add

```lua
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').lua.install_info.generate = true
end})
```

## Adding queries

Queries can be placed anywhere in your `runtimepath` under `queries/<language>`, with earlier directories taking precedence unless the queries are marked with `; extends`; see [`:h treesitter-query-modelines`](https://neovim.io/doc/user/treesitter.html#treesitter-query-modeline).
