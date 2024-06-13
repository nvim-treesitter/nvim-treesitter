# Roadmap

This document lists the planned and finished changes in this rewrite towards [Nvim-treesitter 1.0](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767).

## TODO

- [ ] **`parsers.lua`:** allow specifying version in addition to commit hash (for Tier 1)
- [ ] **`parsers.lua`:** add WASM support (tier 1)
- [ ] **`parsers.lua`:** update tiers (stable, dev, unmaintained, broken)
- [ ] **tests:** fix, update (remove custom crate, plenary dependency)
- [ ] **documentation:** consolidate, autogenerate?
- [ ] **documentation:** migration guide
- [ ] **indents:** rewrite (Helix compatible)
- [ ] **textobjects:** include simple(!) `node`, `scope` (using `locals`) objects
- [ ] **downstream:** adapt to breaking changes (`nvim-treesitter-refactor`)

## DONE

- [X] remove module framework
- [X] remove extra utilities
- [X] refactor `indent.lua` into standalone
- [X] refactor `locals.lua` into standalone
- [X] refactor commands, predicates, filetypes registration to plugin/
- [X] support installing tiers of parsers
- [X] install parsers to standard directory by default
- [X] remove bundled queries from runtimepath; copy on parser install
- [X] general refactor and cleanup
- [X] rewrite installation using async module (drop support for sync; use callback instead)
- [X] switch to upstream injection format
- [X] remove locals from highlighting (cf. https://github.com/nvim-treesitter/nvim-treesitter/issues/3944#issuecomment-1458782497)
