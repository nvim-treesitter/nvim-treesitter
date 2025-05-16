# Roadmap

This document lists the planned and finished changes in this rewrite towards [Nvim-treesitter 1.0](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767).

## TODO

- [ ] **tests:** remove custom crate, plenary dependency
- [ ] **indents:** rewrite (Helix or Zed compatible)
- [ ] **textobjects:** include simple(!) `node`, `scope` (using `locals`) objects

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
- [X] drop ensure_install (replace with install)
- [X] **CI:** switch to ts_query_ls, add update readme as check (remove update job)
- [X] **CI:** track versioned releases for tier 1
- [X] **`install.lua`:** migrate to async v2
