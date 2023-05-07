# Roadmap

This document lists the planned and finished changes in this rewrite towards [Nvim-treesitter 1.0](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767).

## TODO

- [ ] **`query_predicates.lua`:** upstream/remove
- [ ] **`parsers.lua`:** modularize?
- [ ] **`parsers.lua`:** assign tiers
- [ ] **`install.lua`:** simplify, use Nvim/Luv API as much as possible (@lewis6991)
- [ ] **`indent.lua`:** replace vim.fn by Nvim API
- [ ] **`locals.lua`:** move to `nvim-treesitter-refactor`
- [ ] **update-lockfile:** allow specifying version in addition to commit hash (for Tier 1)
- [ ] **tests/scripts:** test, fix
- [ ] **documentation:** consolidate, autogenerate?
- [ ] **documentation:** migration guide
- [ ] **downstream:** adapt to breaking changes (`nvim-treesitter-textobjects`, `nvim-treesitter-refactor`)

## DONE

- [X] remove module framework
- [X] remove extra utilities
- [X] refactor `indent.lua` into standalone
- [X] refactor commands, predicates, filetypes registration to plugin/
- [X] support installing tiers of parsers
- [X] install parsers to standard directory by default
- [X] remove bundled queries from runtimepath; copy on parser install
- [X] general refactor and cleanup
