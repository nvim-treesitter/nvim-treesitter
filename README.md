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
  -- A list of parser names or tiers ('core', 'stable', 'community', 'unstable')
  ensure_install = { },

  -- List of parsers to ignore installing
  ignore_install = { },

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

<<<<<<< HEAD
<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
- [x] [ada](https://github.com/briot/tree-sitter-ada) (maintained by @briot)
- [x] [agda](https://github.com/tree-sitter/tree-sitter-agda) (maintained by @Decodetalkers)
- [x] [angular](https://github.com/dlvandenberg/tree-sitter-angular) (experimental, maintained by @dlvandenberg)
- [x] [apex](https://github.com/aheber/tree-sitter-sfapex) (maintained by @aheber)
- [x] [arduino](https://github.com/ObserverOfTime/tree-sitter-arduino) (maintained by @ObserverOfTime)
- [x] [asm](https://github.com/RubixDev/tree-sitter-asm) (maintained by @RubixDev)
- [x] [astro](https://github.com/virchau13/tree-sitter-astro) (maintained by @virchau13)
- [x] [authzed](https://github.com/mleonidas/tree-sitter-authzed) (maintained by @mattpolzin)
- [ ] [awk](https://github.com/Beaglefoot/tree-sitter-awk)
- [x] [bash](https://github.com/tree-sitter/tree-sitter-bash) (maintained by @TravonteD)
- [x] [bass](https://github.com/vito/tree-sitter-bass) (maintained by @amaanq)
- [x] [beancount](https://github.com/polarmutex/tree-sitter-beancount) (maintained by @polarmutex)
- [x] [bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) (maintained by @theHamsta, @clason)
- [x] [bicep](https://github.com/amaanq/tree-sitter-bicep) (maintained by @amaanq)
- [x] [bitbake](https://github.com/amaanq/tree-sitter-bitbake) (maintained by @amaanq)
- [x] [blueprint](https://gitlab.com/gabmus/tree-sitter-blueprint.git) (experimental, maintained by @gabmus)
- [x] [bp](https://github.com/ambroisie/tree-sitter-bp) (maintained by @ambroisie)
- [x] [c](https://github.com/tree-sitter/tree-sitter-c) (maintained by @amaanq)
- [x] [c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) (maintained by @amaanq)
- [x] [cairo](https://github.com/amaanq/tree-sitter-cairo) (maintained by @amaanq)
- [x] [capnp](https://github.com/amaanq/tree-sitter-capnp) (maintained by @amaanq)
- [x] [chatito](https://github.com/ObserverOfTime/tree-sitter-chatito) (maintained by @ObserverOfTime)
- [x] [clojure](https://github.com/sogaiu/tree-sitter-clojure) (maintained by @NoahTheDuke)
- [x] [cmake](https://github.com/uyha/tree-sitter-cmake) (maintained by @uyha)
- [x] [comment](https://github.com/stsewd/tree-sitter-comment) (maintained by @stsewd)
- [x] [commonlisp](https://github.com/theHamsta/tree-sitter-commonlisp) (maintained by @theHamsta)
- [x] [cooklang](https://github.com/addcninblue/tree-sitter-cooklang) (maintained by @addcninblue)
- [x] [corn](https://github.com/jakestanger/tree-sitter-corn) (maintained by @jakestanger)
- [x] [cpon](https://github.com/amaanq/tree-sitter-cpon) (maintained by @amaanq)
- [x] [cpp](https://github.com/tree-sitter/tree-sitter-cpp) (maintained by @theHamsta)
- [x] [css](https://github.com/tree-sitter/tree-sitter-css) (maintained by @TravonteD)
- [x] [csv](https://github.com/amaanq/tree-sitter-csv) (maintained by @amaanq)
- [x] [cuda](https://github.com/theHamsta/tree-sitter-cuda) (maintained by @theHamsta)
- [x] [cue](https://github.com/eonpatapon/tree-sitter-cue) (maintained by @amaanq)
- [x] [d](https://github.com/gdamore/tree-sitter-d) (maintained by @amaanq)
- [x] [dart](https://github.com/UserNobody14/tree-sitter-dart) (maintained by @akinsho)
- [x] [devicetree](https://github.com/joelspadin/tree-sitter-devicetree) (maintained by @jedrzejboczar)
- [x] [dhall](https://github.com/jbellerb/tree-sitter-dhall) (maintained by @amaanq)
- [x] [diff](https://github.com/the-mikedavis/tree-sitter-diff) (maintained by @gbprod)
- [x] [disassembly](https://github.com/ColinKennedy/tree-sitter-disassembly) (maintained by @ColinKennedy)
- [x] [djot](https://github.com/treeman/tree-sitter-djot) (maintained by @NoahTheDuke)
- [x] [dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) (maintained by @camdencheek)
- [x] [dot](https://github.com/rydesun/tree-sitter-dot) (maintained by @rydesun)
- [x] [doxygen](https://github.com/amaanq/tree-sitter-doxygen) (maintained by @amaanq)
- [x] [dtd](https://github.com/tree-sitter-grammars/tree-sitter-xml) (maintained by @ObserverOfTime)
- [x] [earthfile](https://github.com/glehmann/tree-sitter-earthfile) (maintained by @glehmann)
- [x] [ebnf](https://github.com/RubixDev/ebnf) (experimental, maintained by @RubixDev)
- [x] [editorconfig](https://github.com/ValdezFOmar/tree-sitter-editorconfig) (maintained by @ValdezFOmar)
- [x] [eds](https://github.com/uyha/tree-sitter-eds) (maintained by @uyha)
- [x] [eex](https://github.com/connorlay/tree-sitter-eex) (maintained by @connorlay)
- [x] [elixir](https://github.com/elixir-lang/tree-sitter-elixir) (maintained by @connorlay)
- [x] [elm](https://github.com/elm-tooling/tree-sitter-elm) (maintained by @zweimach)
- [x] [elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) (maintained by @glapa-grossklag, @amaanq)
- [x] [elvish](https://github.com/elves/tree-sitter-elvish) (maintained by @elves)
- [ ] [embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template)
- [x] [erlang](https://github.com/WhatsApp/tree-sitter-erlang) (maintained by @filmor)
- [x] [facility](https://github.com/FacilityApi/tree-sitter-facility) (maintained by @bryankenote)
- [x] [faust](https://github.com/khiner/tree-sitter-faust) (maintained by @khiner)
- [x] [fennel](https://github.com/alexmozaidze/tree-sitter-fennel) (maintained by @alexmozaidze)
- [x] [fidl](https://github.com/google/tree-sitter-fidl) (maintained by @chaopeng)
- [x] [firrtl](https://github.com/amaanq/tree-sitter-firrtl) (maintained by @amaanq)
- [x] [fish](https://github.com/ram02z/tree-sitter-fish) (maintained by @ram02z)
- [x] [foam](https://github.com/FoamScience/tree-sitter-foam) (experimental, maintained by @FoamScience)
- [x] [forth](https://github.com/AlexanderBrevig/tree-sitter-forth) (maintained by @amaanq)
- [x] [fortran](https://github.com/stadelmanma/tree-sitter-fortran) (maintained by @amaanq)
- [x] [fsh](https://github.com/mgramigna/tree-sitter-fsh) (maintained by @mgramigna)
- [x] [func](https://github.com/amaanq/tree-sitter-func) (maintained by @amaanq)
- [x] [fusion](https://gitlab.com/jirgn/tree-sitter-fusion.git) (maintained by @jirgn)
- [x] [Godot (gdscript)](https://github.com/PrestonKnopp/tree-sitter-gdscript) (maintained by @PrestonKnopp)
- [x] [gdshader](https://github.com/GodOfAvacyn/tree-sitter-gdshader) (maintained by @godofavacyn)
- [x] [git_config](https://github.com/the-mikedavis/tree-sitter-git-config) (maintained by @amaanq)
- [x] [git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) (maintained by @gbprod)
- [x] [gitattributes](https://github.com/ObserverOfTime/tree-sitter-gitattributes) (maintained by @ObserverOfTime)
- [x] [gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) (maintained by @gbprod)
- [x] [gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) (maintained by @theHamsta)
- [x] [gleam](https://github.com/gleam-lang/tree-sitter-gleam) (maintained by @amaanq)
- [x] [Glimmer and Ember](https://github.com/alexlafroscia/tree-sitter-glimmer) (maintained by @NullVoxPopuli)
- [x] [glsl](https://github.com/theHamsta/tree-sitter-glsl) (maintained by @theHamsta)
- [x] [GN (Generate Ninja)](https://github.com/amaanq/tree-sitter-gn) (maintained by @amaanq)
- [x] [gnuplot](https://github.com/dpezto/tree-sitter-gnuplot) (maintained by @dpezto)
- [x] [go](https://github.com/tree-sitter/tree-sitter-go) (maintained by @theHamsta, @WinWisely268)
- [x] [goctl](https://github.com/chaozwn/tree-sitter-goctl) (maintained by @chaozwn)
- [x] [Godot Resources (gdresource)](https://github.com/PrestonKnopp/tree-sitter-godot-resource) (maintained by @pierpo)
- [x] [gomod](https://github.com/camdencheek/tree-sitter-go-mod) (maintained by @camdencheek)
- [x] [gosum](https://github.com/amaanq/tree-sitter-go-sum) (maintained by @amaanq)
- [x] [gotmpl](https://github.com/ngalaiko/tree-sitter-go-template) (maintained by @qvalentin)
- [x] [gowork](https://github.com/omertuc/tree-sitter-go-work) (maintained by @omertuc)
- [x] [gpg](https://github.com/ObserverOfTime/tree-sitter-gpg-config) (maintained by @ObserverOfTime)
- [x] [graphql](https://github.com/bkegley/tree-sitter-graphql) (maintained by @bkegley)
- [x] [groovy](https://github.com/murtaza64/tree-sitter-groovy) (maintained by @murtaza64)
- [x] [gstlaunch](https://github.com/theHamsta/tree-sitter-gstlaunch) (maintained by @theHamsta)
- [ ] [hack](https://github.com/slackhq/tree-sitter-hack)
- [x] [hare](https://github.com/amaanq/tree-sitter-hare) (maintained by @amaanq)
- [x] [haskell](https://github.com/tree-sitter/tree-sitter-haskell) (maintained by @mrcjkb)
- [x] [haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) (maintained by @lykahb)
- [x] [hcl](https://github.com/MichaHoffmann/tree-sitter-hcl) (maintained by @MichaHoffmann)
- [x] [heex](https://github.com/connorlay/tree-sitter-heex) (maintained by @connorlay)
- [x] [helm](https://github.com/ngalaiko/tree-sitter-go-template) (maintained by @qvalentin)
- [x] [hjson](https://github.com/winston0410/tree-sitter-hjson) (maintained by @winston0410)
- [x] [hlsl](https://github.com/theHamsta/tree-sitter-hlsl) (maintained by @theHamsta)
- [x] [hlsplaylist](https://github.com/Freed-Wu/tree-sitter-hlsplaylist) (maintained by @Freed-Wu)
- [x] [hocon](https://github.com/antosha417/tree-sitter-hocon) (maintained by @antosha417)
- [x] [hoon](https://github.com/urbit-pilled/tree-sitter-hoon) (experimental, maintained by @urbit-pilled)
- [x] [html](https://github.com/tree-sitter/tree-sitter-html) (maintained by @TravonteD)
- [x] [htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) (experimental, maintained by @ObserverOfTime)
- [x] [http](https://github.com/rest-nvim/tree-sitter-http) (maintained by @amaanq, @NTBBloodbath)
- [x] [hurl](https://github.com/pfeiferj/tree-sitter-hurl) (maintained by @pfeiferj)
- [x] [hyprlang](https://github.com/luckasRanarison/tree-sitter-hyprlang) (maintained by @luckasRanarison)
- [x] [idl](https://github.com/cathaysia/tree-sitter-idl) (maintained by @cathaysia)
- [x] [ini](https://github.com/justinmk/tree-sitter-ini) (experimental, maintained by @theHamsta)
- [x] [inko](https://github.com/inko-lang/tree-sitter-inko) (maintained by @yorickpeterse)
- [x] [ispc](https://github.com/fab4100/tree-sitter-ispc) (maintained by @fab4100)
- [x] [janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) (maintained by @sogaiu)
- [x] [java](https://github.com/tree-sitter/tree-sitter-java) (maintained by @p00f)
- [x] [javascript](https://github.com/tree-sitter/tree-sitter-javascript) (maintained by @steelsojka)
- [x] [jq](https://github.com/flurie/tree-sitter-jq) (maintained by @ObserverOfTime)
- [x] [jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) (maintained by @steelsojka)
- [x] [json](https://github.com/tree-sitter/tree-sitter-json) (maintained by @steelsojka)
- [x] [json5](https://github.com/Joakker/tree-sitter-json5) (maintained by @Joakker)
- [x] [JSON with comments](https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git) (maintained by @WhyNotHugo)
- [x] [jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) (maintained by @nawordar)
- [x] [julia](https://github.com/tree-sitter/tree-sitter-julia) (maintained by @theHamsta)
- [x] [just](https://github.com/IndianBoy42/tree-sitter-just) (maintained by @Hubro)
- [x] [kconfig](https://github.com/amaanq/tree-sitter-kconfig) (maintained by @amaanq)
- [x] [kdl](https://github.com/amaanq/tree-sitter-kdl) (maintained by @amaanq)
- [x] [kotlin](https://github.com/fwcd/tree-sitter-kotlin) (maintained by @SalBakraa)
- [x] [koto](https://github.com/koto-lang/tree-sitter-koto) (maintained by @irh)
- [x] [kusto](https://github.com/Willem-J-an/tree-sitter-kusto) (maintained by @Willem-J-an)
- [x] [lalrpop](https://github.com/traxys/tree-sitter-lalrpop) (maintained by @traxys)
- [x] [latex](https://github.com/latex-lsp/tree-sitter-latex) (maintained by @theHamsta, @clason)
- [x] [ledger](https://github.com/cbarrete/tree-sitter-ledger) (maintained by @cbarrete)
- [x] [leo](https://github.com/r001/tree-sitter-leo) (maintained by @r001)
- [x] [linkerscript](https://github.com/amaanq/tree-sitter-linkerscript) (maintained by @amaanq)
- [x] [liquid](https://github.com/hankthetank27/tree-sitter-liquid) (maintained by @hankthetank27)
- [x] [liquidsoap](https://github.com/savonet/tree-sitter-liquidsoap) (maintained by @toots)
- [x] [llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) (maintained by @benwilliamgraham)
- [x] [lua](https://github.com/MunifTanjim/tree-sitter-lua) (maintained by @muniftanjim)
- [x] [luadoc](https://github.com/amaanq/tree-sitter-luadoc) (maintained by @amaanq)
- [x] [lua patterns](https://github.com/amaanq/tree-sitter-luap) (maintained by @amaanq)
- [x] [luau](https://github.com/amaanq/tree-sitter-luau) (maintained by @amaanq)
- [x] [m68k](https://github.com/grahambates/tree-sitter-m68k) (maintained by @grahambates)
- [x] [make](https://github.com/alemuller/tree-sitter-make) (maintained by @lewis6991)
- [x] [markdown (basic highlighting)](https://github.com/MDeiml/tree-sitter-markdown) (experimental, maintained by @MDeiml)
- [x] [markdown_inline (needed for full highlighting)](https://github.com/MDeiml/tree-sitter-markdown) (experimental, maintained by @MDeiml)
- [x] [matlab](https://github.com/acristoffers/tree-sitter-matlab) (maintained by @acristoffers)
- [x] [menhir](https://github.com/Kerl13/tree-sitter-menhir) (maintained by @Kerl13)
- [ ] [mermaid](https://github.com/monaqa/tree-sitter-mermaid) (experimental)
- [x] [meson](https://github.com/Decodetalkers/tree-sitter-meson) (maintained by @Decodetalkers)
- [x] [mlir](https://github.com/artagnon/tree-sitter-mlir) (experimental, maintained by @artagnon)
- [x] [muttrc](https://github.com/neomutt/tree-sitter-muttrc) (maintained by @Freed-Wu)
- [x] [nasm](https://github.com/naclsn/tree-sitter-nasm) (maintained by @ObserverOfTime)
- [x] [nginx](https://github.com/opa-oz/tree-sitter-nginx) (maintained by @opa-oz)
- [ ] [nickel](https://github.com/nickel-lang/tree-sitter-nickel)
- [x] [nim](https://github.com/alaviss/tree-sitter-nim) (maintained by @aMOPel)
- [x] [nim_format_string](https://github.com/aMOPel/tree-sitter-nim-format-string) (maintained by @aMOPel)
- [x] [ninja](https://github.com/alemuller/tree-sitter-ninja) (maintained by @alemuller)
- [x] [nix](https://github.com/cstrahan/tree-sitter-nix) (maintained by @leo60228)
- [x] [norg](https://github.com/nvim-neorg/tree-sitter-norg) (maintained by @JoeyGrajciar, @vhyrro)
- [x] [nqc](https://github.com/amaanq/tree-sitter-nqc) (maintained by @amaanq)
- [x] [objc](https://github.com/amaanq/tree-sitter-objc) (maintained by @amaanq)
- [x] [objdump](https://github.com/ColinKennedy/tree-sitter-objdump) (maintained by @ColinKennedy)
- [x] [ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) (maintained by @undu)
- [x] [ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) (maintained by @undu)
- [x] [ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) (maintained by @undu)
- [x] [odin](https://github.com/amaanq/tree-sitter-odin) (maintained by @amaanq)
- [ ] [org](https://github.com/milisims/tree-sitter-org)
- [x] [pascal](https://github.com/Isopod/tree-sitter-pascal) (maintained by @Isopod)
- [x] [passwd](https://github.com/ath3/tree-sitter-passwd) (maintained by @amaanq)
- [x] [pem](https://github.com/ObserverOfTime/tree-sitter-pem) (maintained by @ObserverOfTime)
- [x] [perl](https://github.com/tree-sitter-perl/tree-sitter-perl) (maintained by @RabbiVeesh, @LeoNerd)
- [x] [php](https://github.com/tree-sitter/tree-sitter-php) (maintained by @tk-shirasaka)
- [x] [php_only](https://github.com/tree-sitter/tree-sitter-php) (maintained by @tk-shirasaka)
- [x] [phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) (experimental, maintained by @mikehaertl)
- [x] [pioasm](https://github.com/leo60228/tree-sitter-pioasm) (maintained by @leo60228)
- [x] [po](https://github.com/erasin/tree-sitter-po) (maintained by @amaanq)
- [x] [pod](https://github.com/tree-sitter-perl/tree-sitter-pod) (maintained by @RabbiVeesh, @LeoNerd)
- [x] [Path of Exile item filter](https://github.com/ObserverOfTime/tree-sitter-poe-filter) (experimental, maintained by @ObserverOfTime)
- [x] [pony](https://github.com/amaanq/tree-sitter-pony) (maintained by @amaanq, @mfelsche)
- [x] [printf](https://github.com/ObserverOfTime/tree-sitter-printf) (maintained by @ObserverOfTime)
- [x] [prisma](https://github.com/victorhqc/tree-sitter-prisma) (maintained by @elianiva)
- [x] [problog](https://github.com/foxyseta/tree-sitter-prolog) (maintained by @foxyseta)
- [x] [prolog](https://github.com/foxyseta/tree-sitter-prolog) (maintained by @foxyseta)
- [x] [promql](https://github.com/MichaHoffmann/tree-sitter-promql) (maintained by @MichaHoffmann)
- [x] [properties](https://github.com/tree-sitter-grammars/tree-sitter-properties) (maintained by @ObserverOfTime)
- [x] [proto](https://github.com/treywood/tree-sitter-proto) (maintained by @treywood)
- [x] [prql](https://github.com/PRQL/tree-sitter-prql) (maintained by @matthias-Q)
- [x] [psv](https://github.com/amaanq/tree-sitter-csv) (maintained by @amaanq)
- [x] [pug](https://github.com/zealot128/tree-sitter-pug) (experimental, maintained by @zealot128)
- [x] [puppet](https://github.com/amaanq/tree-sitter-puppet) (maintained by @amaanq)
- [x] [purescript](https://github.com/postsolar/tree-sitter-purescript) (maintained by @postsolar)
- [x] [PyPA manifest](https://github.com/ObserverOfTime/tree-sitter-pymanifest) (maintained by @ObserverOfTime)
- [x] [python](https://github.com/tree-sitter/tree-sitter-python) (maintained by @stsewd, @theHamsta)
- [x] [ql](https://github.com/tree-sitter/tree-sitter-ql) (maintained by @pwntester)
- [x] [qmldir](https://github.com/Decodetalkers/tree-sitter-qmldir) (maintained by @amaanq)
- [x] [qmljs](https://github.com/yuja/tree-sitter-qmljs) (maintained by @Decodetalkers)
- [x] [Tree-Sitter query language](https://github.com/nvim-treesitter/tree-sitter-query) (maintained by @steelsojka)
- [x] [r](https://github.com/r-lib/tree-sitter-r) (maintained by @ribru17)
- [ ] [racket](https://github.com/6cdh/tree-sitter-racket)
- [x] [ralph](https://github.com/alephium/tree-sitter-ralph) (maintained by @tdroxler)
- [x] [rasi](https://github.com/Fymyte/tree-sitter-rasi) (maintained by @Fymyte)
- [x] [rbs](https://github.com/joker1007/tree-sitter-rbs) (maintained by @joker1007)
- [x] [re2c](https://github.com/amaanq/tree-sitter-re2c) (maintained by @amaanq)
- [x] [readline](https://github.com/ribru17/tree-sitter-readline) (maintained by @ribru17)
- [x] [regex](https://github.com/tree-sitter/tree-sitter-regex) (maintained by @theHamsta)
- [x] [rego](https://github.com/FallenAngel97/tree-sitter-rego) (maintained by @FallenAngel97)
- [x] [pip requirements](https://github.com/ObserverOfTime/tree-sitter-requirements) (maintained by @ObserverOfTime)
- [x] [rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) (maintained by @bamonroe)
- [x] [robot](https://github.com/Hubro/tree-sitter-robot) (maintained by @Hubro)
- [x] [robots](https://github.com/opa-oz/tree-sitter-robots-txt) (maintained by @opa-oz)
- [x] [roc](https://github.com/faldor20/tree-sitter-roc) (maintained by @nat-418)
- [x] [ron](https://github.com/amaanq/tree-sitter-ron) (maintained by @amaanq)
- [x] [rst](https://github.com/stsewd/tree-sitter-rst) (maintained by @stsewd)
- [x] [ruby](https://github.com/tree-sitter/tree-sitter-ruby) (maintained by @TravonteD)
- [x] [rust](https://github.com/tree-sitter/tree-sitter-rust) (maintained by @amaanq)
- [x] [scala](https://github.com/tree-sitter/tree-sitter-scala) (maintained by @stevanmilic)
- [x] [scfg](https://github.com/rockorager/tree-sitter-scfg) (maintained by @WhyNotHugo)
- [ ] [scheme](https://github.com/6cdh/tree-sitter-scheme)
- [x] [scss](https://github.com/serenadeai/tree-sitter-scss) (maintained by @elianiva)
- [x] [slang](https://github.com/theHamsta/tree-sitter-slang) (experimental, maintained by @theHamsta)
- [x] [slint](https://github.com/slint-ui/tree-sitter-slint) (maintained by @hunger)
- [x] [smali](https://github.com/tree-sitter-grammars/tree-sitter-smali) (maintained by @amaanq)
- [x] [smithy](https://github.com/indoorvivants/tree-sitter-smithy) (maintained by @amaanq, @keynmol)
- [ ] [snakemake](https://github.com/osthomas/tree-sitter-snakemake) (experimental)
- [x] [solidity](https://github.com/JoranHonig/tree-sitter-solidity) (maintained by @amaanq)
- [x] [soql](https://github.com/aheber/tree-sitter-sfapex) (maintained by @aheber)
- [x] [sosl](https://github.com/aheber/tree-sitter-sfapex) (maintained by @aheber)
- [x] [sourcepawn](https://github.com/nilshelmig/tree-sitter-sourcepawn) (maintained by @Sarrus1)
- [x] [sparql](https://github.com/GordianDziwis/tree-sitter-sparql) (maintained by @GordianDziwis)
- [x] [sql](https://github.com/derekstride/tree-sitter-sql) (maintained by @derekstride)
- [x] [squirrel](https://github.com/amaanq/tree-sitter-squirrel) (maintained by @amaanq)
- [x] [ssh_config](https://github.com/ObserverOfTime/tree-sitter-ssh-config) (maintained by @ObserverOfTime)
- [x] [starlark](https://github.com/amaanq/tree-sitter-starlark) (maintained by @amaanq)
- [x] [strace](https://github.com/sigmaSd/tree-sitter-strace) (maintained by @amaanq)
- [x] [styled](https://github.com/mskelton/tree-sitter-styled) (maintained by @mskelton)
- [x] [supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) (maintained by @madskjeldgaard)
- [x] [surface](https://github.com/connorlay/tree-sitter-surface) (maintained by @connorlay)
- [x] [svelte](https://github.com/tree-sitter-grammars/tree-sitter-svelte) (maintained by @amaanq)
- [x] [swift](https://github.com/alex-pinkus/tree-sitter-swift) (maintained by @alex-pinkus)
- [x] [sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) (maintained by @RaafatTurki)
- [x] [systemtap](https://github.com/ok-ryoko/tree-sitter-systemtap) (maintained by @ok-ryoko)
- [x] [systemverilog](https://github.com/zhangwwpeng/tree-sitter-systemverilog) (maintained by @zhangwwpeng)
- [x] [t32](https://gitlab.com/xasc/tree-sitter-t32.git) (maintained by @xasc)
- [x] [tablegen](https://github.com/amaanq/tree-sitter-tablegen) (maintained by @amaanq)
- [x] [tact](https://github.com/tact-lang/tree-sitter-tact) (maintained by @novusnota)
- [x] [tcl](https://github.com/tree-sitter-grammars/tree-sitter-tcl) (maintained by @lewis6991)
- [x] [teal](https://github.com/euclidianAce/tree-sitter-teal) (maintained by @euclidianAce)
- [x] [templ](https://github.com/vrischmann/tree-sitter-templ) (maintained by @vrischmann)
- [x] [terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) (maintained by @MichaHoffmann)
- [x] [textproto](https://github.com/PorterAtGoogle/tree-sitter-textproto) (maintained by @Porter)
- [x] [thrift](https://github.com/duskmoon314/tree-sitter-thrift) (maintained by @amaanq, @duskmoon314)
- [x] [tiger](https://github.com/ambroisie/tree-sitter-tiger) (maintained by @ambroisie)
- [x] [tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) (maintained by @ahelwer, @susliko)
- [x] [tmux](https://github.com/Freed-Wu/tree-sitter-tmux) (maintained by @Freed-Wu)
- [x] [todotxt](https://github.com/arnarg/tree-sitter-todotxt) (experimental, maintained by @arnarg)
- [x] [toml](https://github.com/tree-sitter-grammars/tree-sitter-toml) (maintained by @tk-shirasaka)
- [x] [tsv](https://github.com/amaanq/tree-sitter-csv) (maintained by @amaanq)
- [x] [tsx](https://github.com/tree-sitter/tree-sitter-typescript) (maintained by @steelsojka)
- [x] [turtle](https://github.com/GordianDziwis/tree-sitter-turtle) (maintained by @GordianDziwis)
- [x] [twig](https://github.com/gbprod/tree-sitter-twig) (maintained by @gbprod)
- [x] [typescript](https://github.com/tree-sitter/tree-sitter-typescript) (maintained by @steelsojka)
- [x] [typespec](https://github.com/happenslol/tree-sitter-typespec) (maintained by @happenslol)
- [x] [typoscript](https://github.com/Teddytrombone/tree-sitter-typoscript) (maintained by @Teddytrombone)
- [x] [typst](https://github.com/uben0/tree-sitter-typst) (maintained by @uben0, @RaafatTurki)
- [x] [udev](https://github.com/ObserverOfTime/tree-sitter-udev) (maintained by @ObserverOfTime)
- [x] [ungrammar](https://github.com/Philipp-M/tree-sitter-ungrammar) (maintained by @Philipp-M, @amaanq)
- [x] [unison](https://github.com/kylegoetz/tree-sitter-unison) (maintained by @tapegram)
- [x] [usd](https://github.com/ColinKennedy/tree-sitter-usd) (maintained by @ColinKennedy)
- [x] [uxn tal](https://github.com/amaanq/tree-sitter-uxntal) (maintained by @amaanq)
- [x] [v](https://github.com/vlang/v-analyzer) (maintained by @kkharji, @amaanq)
- [x] [vala](https://github.com/vala-lang/tree-sitter-vala) (maintained by @Prince781)
- [x] [vento](https://github.com/ventojs/tree-sitter-vento) (maintained by @wrapperup, @oscarotero)
- [x] [verilog](https://github.com/tree-sitter/tree-sitter-verilog) (maintained by @zegervdv)
- [x] [vhs](https://github.com/charmbracelet/tree-sitter-vhs) (maintained by @caarlos0)
- [x] [vim](https://github.com/neovim/tree-sitter-vim) (maintained by @clason)
- [x] [vimdoc](https://github.com/neovim/tree-sitter-vimdoc) (maintained by @clason)
- [x] [vue](https://github.com/tree-sitter-grammars/tree-sitter-vue) (maintained by @WhyNotHugo, @lucario387)
- [x] [wgsl](https://github.com/szebniok/tree-sitter-wgsl) (maintained by @szebniok)
- [x] [wgsl_bevy](https://github.com/theHamsta/tree-sitter-wgsl-bevy) (maintained by @theHamsta)
- [x] [wing](https://github.com/winglang/tree-sitter-wing) (maintained by @gshpychka, @MarkMcCulloh)
- [x] [wit](https://github.com/liamwh/tree-sitter-wit) (maintained by @liamwh)
- [x] [xcompose](https://github.com/ObserverOfTime/tree-sitter-xcompose) (maintained by @ObserverOfTime)
- [x] [xml](https://github.com/tree-sitter-grammars/tree-sitter-xml) (maintained by @ObserverOfTime)
- [x] [yaml](https://github.com/tree-sitter-grammars/tree-sitter-yaml) (maintained by @amaanq)
- [x] [yang](https://github.com/Hubro/tree-sitter-yang) (maintained by @Hubro)
- [x] [yuck](https://github.com/Philipp-M/tree-sitter-yuck) (maintained by @Philipp-M, @amaanq)
- [x] [zathurarc](https://github.com/Freed-Wu/tree-sitter-zathurarc) (maintained by @Freed-Wu)
- [x] [zig](https://github.com/maxxnino/tree-sitter-zig) (maintained by @maxxnino)
<!--parserinfo-->

=======
>>>>>>> 24162165 (feat!: drop modules, general refactor and cleanup)
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

1. Clone the repository or [create a new project](https://tree-sitter.github.io/tree-sitter/creating-parsers#project-setup) in, say, `~/projects/tree-sitter-zimbu`. Make sure that the `tree-sitter-cli` executable is installed and in your path; see <https://tree-sitter.github.io/tree-sitter/creating-parsers#installation> for installation instructions.
2. Run `tree-sitter generate` in this directory (followed by `tree-sitter test` for good measure).
3. Add the following snippet to your `init.lua`:

```lua
local parser_config = require "nvim-treesitter.parsers".configs
parser_config.zimbu = {
  install_info = {
    url = "~/projects/tree-sitter-zimbu", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "develop", -- only needed if different from default branch
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
}
```
If you use a git repository for your parser and want to use a specific version, you can set the `revision` key
in the `install_info` table for you parser config.

4. If the parser name differs from the filetype(s) used by Neovim, you need to register the parser via

```lua
vim.treesitter.language.register('zimbu', { 'zu' })
```

If Neovim does not detect your language's filetype by default, you can use [Neovim's `vim.filetype.add()`](<https://neovim.io/doc/user/lua.html#vim.filetype.add()>) to add a custom detection rule.

5. Start `nvim` and `:TSInstall zimbu`.

You can also skip step 2 and use `:TSInstallFromGrammar zimbu` to install directly from a `grammar.js` in the top-level directory specified by `url`.
Once the parser is installed, you can update it (from the latest revision of the `main` branch if `url` is a Github repository) with `:TSUpdate zimbu`.


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
for _, config in pairs(require("nvim-treesitter.parsers").configs) do
  config.install_info.url = config.install_info.url:gsub("https://github.com/", "something else")
end

require'nvim-treesitter'.setup {
    --
    --
}
```
