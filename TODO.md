# Roadmap

This document lists the planned and finished changes in this rewrite towards [Nvim-treesitter 1.0](https://github.com/nvim-treesitter/nvim-treesitter/issues/4767).

## TODO

- [ ] **`query_predicates.lua`:** upstream/remove
- [ ] **`parsers.lua`:** assign tiers
- [ ] **`install.lua`:** simplify, use Nvim/Luv API as much as possible (@lewis6991)
- [ ] **`indent.lua`:** remove dependence on `ts_utils`, `query` (@lucario387)
- [ ] **`indent.lua`:** test, fix (@lucario387)
- [ ] **`locals.lua`:** move to `nvim-treesitter-refactor`
- [ ] **update-lockfile:** allow specifying version in addition to commit hash (for Tier 1)
- [ ] **tests/scripts:** test, fix
- [ ] **documentation:** consolidate, autogenerate?
- [ ] **downstream:** adapt to breaking changes (`nvim-treesitter-textobjects`, `nvim-treesitter-refactor`)

## DONE

...
