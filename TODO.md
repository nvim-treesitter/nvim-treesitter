# Roadmap

This document lists the planned and finished changes in this rewrite towards [Nvim-treesitter 1.0](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767).

## TODO

- [ ] **`config.lua`:** drop ensure_install (replace with install), ignore_install
- [ ] **`install.lua`:** simply skip Tier 4 parsers (`get_install_info`)
- [ ] **`parsers.lua`:** allow specifying version in addition to commit hash (for Tier 1)
- [ ] **`parsers.lua`:** add WASM support (tier 1)
- [ ] **`install.lua`:** migrate to async v2
- [ ] **tests:** fix, update (remove custom crate, plenary dependency)
- [ ] **CI:** switch to ts_query_ls, add update readme as check (remove update job)
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
