<h1 align="center">
  <img src="https://github.com/nvim-treesitter/nvim-treesitter/assets/2361214/0513b223-c902-4f12-92ee-8ac4d8d6f41f" alt="nvim-treesitter">
</h1>
<div align="center">
  <p>
    <a href="https://matrix.to/#/#nvim-treesitter:matrix.org">
      <img alt="Matrix Chat" src="https://img.shields.io/matrix/nvim-treesitter:matrix.org" />
    </a>
    <a href="https://github.com/nvim-treesitter/nvim-treesitter/actions?query=workflow%3A%22Linting+and+style+checking%22+branch%3Amaster">
      <img alt="Linting and Style" src="https://github.com/nvim-treesitter/nvim-treesitter/workflows/Linting%20and%20style%20checking/badge.svg" />
    </a>
    <a href="https://github.com/nvim-treesitter/nvim-treesitter/actions?query=workflow%3A%22Check+loading+of+syntax+files%22+branch%3Amaster">
      <img alt="Syntax files" src="https://github.com/nvim-treesitter/nvim-treesitter/workflows/Check%20loading%20of%20syntax%20files/badge.svg" />
    </a>
  </p>
</div>

# WARNING

**This branch is a [full, incompatible, rewrite of `nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767) and [work in progress](TODO.md). This branch REQUIRES (the latest commit on) Neovim `master`.**

The `nvim-treesitter` plugin provides
1. functions for installing, updating, and removing [**tree-sitter parsers**](SUPPORTED_LANGUAGES.md);
2. a collection of **queries** for enabling tree-sitter features built into Neovim for these languages.

# Quickstart

## Requirements

- Neovim 0.10.0 or later (nightly)
- `tar` and `curl` in your path (or alternatively `git`)
- a C compiler in your path and libstdc++ installed ([Windows users please read this!](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support))
- optional: `tree-sitter` CLI and `node`

## Installation

You can install `nvim-treesitter` with your favorite package manager (or using the native `package` feature of vim, see `:h packages`).

**NOTE: This plugin is only guaranteed to work with specific versions of language parsers** (as specified in the `lockfile.json`). **When upgrading the plugin, you must make sure that all installed parsers are updated to the latest version** via `:TSUpdate`.
It is strongly recommended to automate this; e.g., using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
require('lazy').setup(
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', lazy = false }
)
```

**NOTE: This plugin does not support lazy-loading.**

## Setup

`nvim-treesitter` can be configured by calling `setup`. The following snippet lists the available options and their default values. **You do not need to call `setup` for `nvim-treesitter` to work using default values.**

```lua
require'nvim-treesitter'.setup {
  -- A list of parser names or tiers ('stable', 'core', 'community', 'unsupported')
  ensure_install = { },

  -- List of parsers to ignore installing
  ignore_install = { 'unsupported' },

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site'
}
```

Check [`:h nvim-treesitter-commands`](doc/nvim-treesitter.txt) for a list of all available commands.

# Supported languages

For `nvim-treesitter` to support a specific feature for a specific language requires both a parser for that language and an appropriate language-specific query file for that feature.

A list of the currently supported languages can be found [on this page](SUPPORTED_LANGUAGES.md).

We are looking for maintainers to add more parsers and to write query files for their languages. Check our [tracking issue](https://github.com/nvim-treesitter/nvim-treesitter/issues/2282) for open language requests.

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

These queries can be used to look up definitions and references to identifiers in a given scope. They are used, e.g., by the `nvim-treesitter-refactor` plugin.

# Advanced setup

## Adding parsers

If you have a parser that is not on the list of supported languages (either as a repository on Github or in a local directory), you can add it manually for use by `nvim-treesitter` as follows:

1. Add the following snippet in a `User TSUpdate` autocommand:

```lua
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').zimbu = {
    install_info = {
      url = 'https://github.com/zimbulang/tree-sitter-zimbu',
      files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c
      revision = <sha>, -- commit hash for revision to check out; HEAD if missing
      -- optional entries:
      branch = 'develop', -- only needed if different from default branch
      location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
      generate = true, -- only needed if repo does not contain pre-generated src/parser.c
      generate_from_json = true, -- only needed if parser has npm dependencies
    },
  }
end})
```

Alternatively, if you have a local checkout, you can instead use
```lua
    install_info = {
      path = '~/parsers/tree-sitter-zimbu',
      files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c
      -- optional entries
      location = 'parser', -- only needed if the parser is in subdirectory of a "monorepo"
      generate = true, -- only needed if repo does not contain pre-generated src/parser.c
      generate_from_json = true, -- only needed if parser has npm dependencies
    },
```
This will always use the state of the directory as-is (i.e., `branch` and `revision` will be ignored).

2. If the parser name differs from the filetype(s) used by Neovim, you need to register the parser via

```lua
vim.treesitter.language.register('zimbu', { 'zu' })
```

If Neovim does not detect your language's filetype by default, you can use [Neovim's `vim.filetype.add()`](<https://neovim.io/doc/user/lua.html#vim.filetype.add()>) to add a custom detection rule.

3. Start `nvim` and `:TSInstall zimbu`.

**Note:** Parsers using external scanner need to be written in C. C++ scanners are no longer supported.

### Modifying parsers

You can use the same approach for overriding parser information. E.g., if you always want to generate the `lua` parser from grammar, add
```lua
vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').lua.install_info.generate = true
end})
```

## Adding queries

Queries can be placed anywhere in your `runtimepath` under `queries/<language>`, with earlier directories taking precedence unless the queries are marked with `; extends`; see `:h treesitter-query`.

E.g., to add queries for `zimbu`, put `highlights.scm` etc. under
```lua
vim.fn.stdpath('data') .. 'site/queries/zimbu'
```

# Troubleshooting

Before doing anything, make sure you have the latest version of this plugin and run `:checkhealth nvim-treesitter`.
It can also help to update the parsers via `:TSUpdate`.

#### Feature `{X}` does not work for `{language}`...

1. Check the `nvim-treesitter` section of `:checkhealth` for any warning, and make sure that the query for `{X}` is listed for `{language}`.

2. Ensure that the feature is enabled as explained above.

3. Ensure Neovim is correctly identifying your language's filetype using the `:echo &filetype` command while one of your language's files is open in Neovim.

#### I get `Error detected while processing .../plugin/nvim-treesitter.vim` every time I open Neovim

This is probably due to a change in a parser's grammar or its queries.
Try updating the parser that you suspect has changed (`:TSUpdate {language}`) or all of them (`:TSUpdate`).
If the error persists after updating all parsers,
please [open an issue](https://github.com/nvim-treesitter/nvim-treesitter/issues/new/choose).

#### I get `query error: invalid node type at position`

This could be due a query file outside this plugin using outdated nodes,
or due to an outdated parser.

- Make sure you have the parsers up to date with `:TSUpdate`
- Make sure you don't have more than one `parser` runtime directory.
  You can execute this command `:= vim.api.nvim_get_runtime_file('parser', true)` to find all runtime directories.
  If you get more than one path, remove the ones that are outside this plugin (`nvim-treesitter` directory),
  so the correct version of the parser is used.

#### I want to use Git instead of curl for downloading the parsers

In your Lua config:

```lua
require("nvim-treesitter.install").prefer_git = true
```

#### I want to use a HTTP proxy for downloading the parsers

You can either configure curl to use additional CLI arguments in your Lua config:

```lua
require("nvim-treesitter.install").command_extra_args = {
    curl = { "--proxy", "<proxy url>" },
}
```

or you can configure git via `.gitconfig` and use git instead of curl

```lua
require("nvim-treesitter.install").prefer_git = true
```

#### I want to use a mirror instead of "https://github.com/"

In your Lua config:

```lua
for _, config in pairs(require("nvim-treesitter.parsers")) do
  config.install_info.url = config.install_info.url:gsub("https://github.com/", "something else")
end

require'nvim-treesitter'.setup {
    --
    --
}
```
