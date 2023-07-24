# Supported languages

The following is a list of languages for which a parser can be installed through `:TSInstall`.

Legend:
- **Tier:** _stable_, _core_, _community_, or _unsupported_
- **CLI:** `:TSInstall` requires `tree-sitter` CLI installed
- **NPM:** `:TSInstallFromGrammar` requires `node` installed
- **Queries** available for **H**ighlights, **I**ndents, **F**olds, In**J**ections, **L**ocals

<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
Language | Tier | Queries | CLI | NPM | Maintainer
-------- |:----:|:-------:|:---:|:---:| ----------
[ada](https://github.com/briot/tree-sitter-ada) | community | `HF  L` |  |  | @briot
[agda](https://github.com/AusCyberman/tree-sitter-agda) | community | `HF   ` |  |  | @Decodetalkers
[arduino](https://github.com/ObserverOfTime/tree-sitter-arduino) | core | `HFIJL` |  |  | @ObserverOfTime
[astro](https://github.com/virchau13/tree-sitter-astro) | community | `HFIJL` |  |  | @virchau13
[awk](https://github.com/Beaglefoot/tree-sitter-awk) | unsupported | `H  J ` |  |  | 
[bash](https://github.com/tree-sitter/tree-sitter-bash) | community | `HF JL` |  |  | @TravonteD
[bass](https://github.com/amaanq/tree-sitter-bass) | core | `HFIJL` |  |  | @amaanq
[beancount](https://github.com/polarmutex/tree-sitter-beancount) | community | `HF   ` |  |  | @polarmutex
[bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) | core | `HFI  ` |  |  | @theHamsta, @clason
[bicep](https://github.com/amaanq/tree-sitter-bicep) | core | `HFIJL` |  |  | @amaanq
[blueprint](https://gitlab.com/gabmus/tree-sitter-blueprint.git) | unsupported | `H    ` |  |  | @gabmus
[c](https://github.com/tree-sitter/tree-sitter-c) | stable | `HFIJL` |  |  | @amaanq
[c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) | community | `HF JL` |  |  | @Luxed
[cairo](https://github.com/amaanq/tree-sitter-cairo) | core | `HFIJL` |  |  | @amaanq
[capnp](https://github.com/amaanq/tree-sitter-capnp) | core | `HFIJL` |  |  | @amaanq
[chatito](https://github.com/ObserverOfTime/tree-sitter-chatito) | core | `HFIJL` |  |  | @ObserverOfTime
[clojure](https://github.com/sogaiu/tree-sitter-clojure) | community | `HF JL` |  |  | @sogaiu
[cmake](https://github.com/uyha/tree-sitter-cmake) | unsupported | `HFI  ` |  |  | @uyha
[comment](https://github.com/stsewd/tree-sitter-comment) | core | `H    ` |  |  | @stsewd
[commonlisp](https://github.com/theHamsta/tree-sitter-commonlisp) | core | `HF  L` |  | ✓ | @theHamsta
[cooklang](https://github.com/addcninblue/tree-sitter-cooklang) | community | `H    ` |  |  | @addcninblue
[corn](https://github.com/jakestanger/tree-sitter-corn) | community | `HFI L` |  |  | @jakestanger
[cpon](https://github.com/amaanq/tree-sitter-cpon) | core | `HFIJL` |  |  | @amaanq
[cpp](https://github.com/tree-sitter/tree-sitter-cpp) | stable | `HFIJL` |  | ✓ | @theHamsta
[css](https://github.com/tree-sitter/tree-sitter-css) | community | `HFIJ ` |  |  | @TravonteD
[cuda](https://github.com/theHamsta/tree-sitter-cuda) | core | `HFIJL` |  | ✓ | @theHamsta
[cue](https://github.com/eonpatapon/tree-sitter-cue) | core | `HFIJL` |  |  | @amaanq
[d](https://github.com/CyberShadow/tree-sitter-d) | unsupported | `HFIJ ` | ✓ |  | @nawordar
[dart](https://github.com/UserNobody14/tree-sitter-dart) | unsupported | `HFIJL` |  |  | @akinsho
[devicetree](https://github.com/joelspadin/tree-sitter-devicetree) | community | `HFIJL` |  |  | @jedrzejboczar
[dhall](https://github.com/jbellerb/tree-sitter-dhall) | core | `HF J ` |  |  | @amaanq
[diff](https://github.com/the-mikedavis/tree-sitter-diff) | community | `H    ` |  |  | @gbprod
[dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) | community | `H  J ` |  |  | @camdencheek
[dot](https://github.com/rydesun/tree-sitter-dot) | community | `H  J ` |  |  | @rydesun
[ebnf](https://github.com/RubixDev/ebnf) | unsupported | `H    ` |  |  | @RubixDev
ecma (queries only)[^ecma] | core | `HFIJL` |  |  | @steelsojka
[eex](https://github.com/connorlay/tree-sitter-eex) | community | `H  J ` |  |  | @connorlay
[elixir](https://github.com/elixir-lang/tree-sitter-elixir) | community | `HFIJL` |  |  | @connorlay
[elm](https://github.com/elm-tooling/tree-sitter-elm) | unsupported | `H  J ` |  |  | @zweimach
[elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) | core | `HFIJL` |  |  | @glapa-grossklag, @amaanq
[elvish](https://github.com/elves/tree-sitter-elvish) | community | `H  J ` |  |  | @elves
[embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template) | unsupported | `H  J ` |  |  | 
[erlang](https://github.com/WhatsApp/tree-sitter-erlang) | community | `HF   ` |  |  | @filmor
[fennel](https://github.com/travonted/tree-sitter-fennel) | community | `HF JL` |  |  | @TravonteD
[firrtl](https://github.com/amaanq/tree-sitter-firrtl) | core | `HFIJL` |  |  | @amaanq
[fish](https://github.com/ram02z/tree-sitter-fish) | community | `HFIJL` |  |  | @ram02z
[foam](https://github.com/FoamScience/tree-sitter-foam) | community | `HFIJL` |  |  | @FoamScience
[fortran](https://github.com/stadelmanma/tree-sitter-fortran) | core | `HFI  ` |  |  | @amaanq
[fsh](https://github.com/mgramigna/tree-sitter-fsh) | community | `H    ` |  |  | @mgramigna
[func](https://github.com/amaanq/tree-sitter-func) | core | `H    ` |  |  | @amaanq
[fusion](https://gitlab.com/jirgn/tree-sitter-fusion.git) | community | `HFI L` |  |  | @jirgn
[gdscript](https://github.com/PrestonKnopp/tree-sitter-gdscript)[^gdscript] | community | `HFIJL` |  |  | @PrestonKnopp
[git_config](https://github.com/the-mikedavis/tree-sitter-git-config) | core | `HF   ` |  |  | @amaanq
[git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) | community | `H  J ` |  |  | @gbprod
[gitattributes](https://github.com/ObserverOfTime/tree-sitter-gitattributes) | core | `H  J ` |  |  | @ObserverOfTime
[gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) | community | `H  J ` |  |  | @gbprod
[gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) | core | `H    ` |  |  | @theHamsta
[gleam](https://github.com/gleam-lang/tree-sitter-gleam) | core | `HFIJL` |  |  | @amaanq
[glimmer](https://github.com/alexlafroscia/tree-sitter-glimmer)[^glimmer] | community | `HFI L` |  |  | @NullVoxPopuli
[glsl](https://github.com/theHamsta/tree-sitter-glsl) | core | `HFIJL` |  | ✓ | @theHamsta
[go](https://github.com/tree-sitter/tree-sitter-go) | stable | `HFIJL` |  |  | @theHamsta, @WinWisely268
[godot_resource](https://github.com/PrestonKnopp/tree-sitter-godot-resource)[^godot_resource] | community | `HF  L` |  |  | @pierpo
[gomod](https://github.com/camdencheek/tree-sitter-go-mod) | community | `H  J ` |  |  | @camdencheek
[gosum](https://github.com/amaanq/tree-sitter-go-sum) | core | `H    ` |  |  | @amaanq
[gowork](https://github.com/omertuc/tree-sitter-go-work) | community | `H  J ` |  |  | @omertuc
[graphql](https://github.com/bkegley/tree-sitter-graphql) | community | `H IJ ` |  |  | @bkegley
[groovy](https://github.com/Decodetalkers/tree-sitter-groovy) | community | `H  J ` |  |  | @Decodetalkers
[hack](https://github.com/slackhq/tree-sitter-hack) | unsupported | `H    ` |  |  | 
[hare](https://github.com/amaanq/tree-sitter-hare) | core | `HFIJL` |  |  | @amaanq
[haskell](https://github.com/tree-sitter/tree-sitter-haskell) | unsupported | `HF J ` |  |  | 
[haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) | community | `HF   ` |  |  | @lykahb
[hcl](https://github.com/MichaHoffmann/tree-sitter-hcl) | community | `HFIJ ` |  |  | @MichaHoffmann
[heex](https://github.com/connorlay/tree-sitter-heex) | community | `HFIJL` |  |  | @connorlay
[hjson](https://github.com/winston0410/tree-sitter-hjson) | community | `HFIJL` |  | ✓ | @winston0410
[hlsl](https://github.com/theHamsta/tree-sitter-hlsl) | core | `HFIJL` |  | ✓ | @theHamsta
[hocon](https://github.com/antosha417/tree-sitter-hocon) | unsupported | `H  J ` |  | ✓ | @antosha417
[hoon](https://github.com/urbit-pilled/tree-sitter-hoon) | unsupported | `HF  L` |  |  | @urbit-pilled
[html](https://github.com/tree-sitter/tree-sitter-html) | community | `HFIJL` |  |  | @TravonteD
html_tags (queries only)[^html_tags] | community | `H IJ ` |  |  | @TravonteD
[htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) | unsupported | `HFIJ ` |  |  | @ObserverOfTime
[http](https://github.com/rest-nvim/tree-sitter-http) | core | `H  J ` |  | ✓ | @amaanq
[hurl](https://github.com/pfeiferj/tree-sitter-hurl) | community | `HFIJ ` |  |  | @pfeiferj
[ini](https://github.com/justinmk/tree-sitter-ini) | unsupported | `HF   ` |  |  | @theHamsta
[ispc](https://github.com/fab4100/tree-sitter-ispc) | unsupported | `HFIJL` |  | ✓ | @fab4100
[janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) | community | `HF JL` |  |  | @sogaiu
[java](https://github.com/tree-sitter/tree-sitter-java) | community | `HFIJL` |  |  | @p00f
[javascript](https://github.com/tree-sitter/tree-sitter-javascript) | core | `HFIJL` |  |  | @steelsojka
[jq](https://github.com/flurie/tree-sitter-jq) | core | `H  J ` |  |  | @ObserverOfTime
[jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) | core | `H    ` |  |  | @steelsojka
[json](https://github.com/tree-sitter/tree-sitter-json) | core | `HFI L` |  |  | @steelsojka
[json5](https://github.com/Joakker/tree-sitter-json5) | community | `H  J ` |  |  | @Joakker
[jsonc](https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git) | community | `HFIJL` |  | ✓ | @WhyNotHugo
[jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) | community | `H    ` |  |  | @nawordar
jsx (queries only)[^jsx] | core | `HFIJ ` |  |  | @steelsojka
[julia](https://github.com/tree-sitter/tree-sitter-julia) | core | `HFIJL` |  |  | @theHamsta
[kdl](https://github.com/amaanq/tree-sitter-kdl) | core | `HFIJL` |  |  | @amaanq
[kotlin](https://github.com/fwcd/tree-sitter-kotlin) | community | `HF JL` |  |  | @SalBakraa
[lalrpop](https://github.com/traxys/tree-sitter-lalrpop) | community | `H  JL` |  |  | @traxys
[latex](https://github.com/latex-lsp/tree-sitter-latex) | core | `HF J ` |  |  | @theHamsta, @clason
[ledger](https://github.com/cbarrete/tree-sitter-ledger) | community | `HFIJ ` |  |  | @cbarrete
[llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) | community | `H    ` |  |  | @benwilliamgraham
[lua](https://github.com/MunifTanjim/tree-sitter-lua) | stable | `HFIJL` |  |  | @muniftanjim
[luadoc](https://github.com/amaanq/tree-sitter-luadoc) | core | `H    ` |  |  | @amaanq
[luap](https://github.com/amaanq/tree-sitter-luap)[^luap] | core | `H    ` |  |  | @amaanq
[luau](https://github.com/amaanq/tree-sitter-luau) | core | `HFIJL` |  |  | @amaanq
[m68k](https://github.com/grahambates/tree-sitter-m68k) | community | `HF JL` |  |  | @grahambates
[make](https://github.com/alemuller/tree-sitter-make) | core | `HF J ` |  |  | @lewis6991
[markdown](https://github.com/MDeiml/tree-sitter-markdown)[^markdown] | stable | `HFIJ ` |  |  | @MDeiml
[markdown_inline](https://github.com/MDeiml/tree-sitter-markdown)[^markdown_inline] | stable | `H  J ` |  |  | @MDeiml
[matlab](https://github.com/acristoffers/tree-sitter-matlab) | community | `HFIJL` |  |  | @acristoffers
[menhir](https://github.com/Kerl13/tree-sitter-menhir) | community | `H  J ` |  |  | @Kerl13
[mermaid](https://github.com/monaqa/tree-sitter-mermaid) | unsupported | `H    ` |  |  | 
[meson](https://github.com/Decodetalkers/tree-sitter-meson) | community | `HF J ` |  |  | @Decodetalkers
[mlir](https://github.com/artagnon/tree-sitter-mlir) | unsupported | `H   L` | ✓ |  | @artagnon
[nickel](https://github.com/nickel-lang/tree-sitter-nickel) | unsupported | `H I  ` |  |  | 
[ninja](https://github.com/alemuller/tree-sitter-ninja) | community | `HFI  ` |  |  | @alemuller
[nix](https://github.com/cstrahan/tree-sitter-nix) | community | `HF JL` |  |  | @leo60228
[objc](https://github.com/amaanq/tree-sitter-objc) | core | `HFIJL` |  |  | @amaanq
[ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) | community | `HFIJL` |  |  | @undu
[ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) | community | `HFIJL` |  |  | @undu
[ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) | community | `H  J ` | ✓ |  | @undu
[odin](https://github.com/amaanq/tree-sitter-odin) | core | `HFIJL` |  |  | @amaanq
[org](https://github.com/milisims/tree-sitter-org) | unsupported | `     ` |  |  | 
[pascal](https://github.com/Isopod/tree-sitter-pascal.git) | community | `HFIJL` |  |  | @Isopod
[passwd](https://github.com/ath3/tree-sitter-passwd) | community | `H    ` |  |  | @amaanq
[pem](https://github.com/ObserverOfTime/tree-sitter-pem) | core | `HF J ` |  |  | @ObserverOfTime
[perl](https://github.com/ganezdragon/tree-sitter-perl) | community | `HF J ` |  |  | @lcrownover
[php](https://github.com/tree-sitter/tree-sitter-php) | community | `HFIJL` |  |  | @tk-shirasaka
[phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) | unsupported | `H    ` |  | ✓ | @mikehaertl
[pioasm](https://github.com/leo60228/tree-sitter-pioasm) | community | `H  J ` |  |  | @leo60228
[po](https://github.com/erasin/tree-sitter-po) | core | `HF J ` |  |  | @amaanq
[poe_filter](https://github.com/ObserverOfTime/tree-sitter-poe-filter)[^poe_filter] | unsupported | `HFIJ ` |  |  | @ObserverOfTime
[pony](https://github.com/amaanq/tree-sitter-pony) | core | `HFIJL` |  |  | @amaanq, @mfelsche
[prisma](https://github.com/victorhqc/tree-sitter-prisma) | community | `H    ` |  |  | @elianiva
[promql](https://github.com/MichaHoffmann/tree-sitter-promql) | unsupported | `H  J ` |  |  | @MichaHoffmann
[proto](https://github.com/mitchellh/tree-sitter-proto) | community | `HF   ` |  |  | @fsouza
[prql](https://github.com/PRQL/tree-sitter-prql) | core | `H  J ` |  |  | @matthias-Q
[pug](https://github.com/zealot128/tree-sitter-pug) | unsupported | `H  J ` |  |  | @zealot128
[puppet](https://github.com/amaanq/tree-sitter-puppet) | core | `HFIJL` |  |  | @amaanq
[python](https://github.com/tree-sitter/tree-sitter-python) | stable | `HFIJL` |  |  | @stsewd, @theHamsta
[ql](https://github.com/tree-sitter/tree-sitter-ql) | community | `HFIJL` |  |  | @pwntester
[qmldir](https://github.com/Decodetalkers/tree-sitter-qmldir) | core | `H  J ` |  |  | @amaanq
[qmljs](https://github.com/yuja/tree-sitter-qmljs) | community | `HF   ` |  |  | @Decodetalkers
[query](https://github.com/nvim-treesitter/tree-sitter-query)[^query] | stable | `HFIJL` |  |  | @steelsojka
[r](https://github.com/r-lib/tree-sitter-r) | community | `H IJL` |  |  | @echasnovski
[racket](https://github.com/6cdh/tree-sitter-racket) | unsupported | `HF J ` |  |  | 
[rasi](https://github.com/Fymyte/tree-sitter-rasi) | community | `HFI L` |  |  | @Fymyte
[regex](https://github.com/tree-sitter/tree-sitter-regex) | stable | `H    ` |  |  | @theHamsta
[rego](https://github.com/FallenAngel97/tree-sitter-rego) | community | `H  J ` |  |  | @FallenAngel97
[rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) | community | `HF J ` |  |  | @bamonroe
[robot](https://github.com/Hubro/tree-sitter-robot) | unsupported | `H    ` |  |  | @ema2159
[ron](https://github.com/amaanq/tree-sitter-ron) | core | `HFIJL` |  |  | @amaanq
[rst](https://github.com/stsewd/tree-sitter-rst) | core | `H  JL` |  |  | @stsewd
[ruby](https://github.com/tree-sitter/tree-sitter-ruby) | community | `HFIJL` |  |  | @TravonteD
[rust](https://github.com/tree-sitter/tree-sitter-rust) | core | `HFIJL` |  |  | @amaanq
[scala](https://github.com/tree-sitter/tree-sitter-scala) | community | `HF JL` |  |  | @stevanmilic
[scheme](https://github.com/6cdh/tree-sitter-scheme) | unsupported | `HF J ` |  |  | 
[scss](https://github.com/serenadeai/tree-sitter-scss) | community | `HFI  ` |  |  | @elianiva
[slint](https://github.com/jrmoulton/tree-sitter-slint) | unsupported | `H I  ` |  |  | @jrmoulton
[smali](https://git.sr.ht/~yotam/tree-sitter-smali) | core | `HFIJL` |  |  | @amaanq
[smithy](https://github.com/indoorvivants/tree-sitter-smithy) | core | `H    ` |  |  | @amaanq, @keynmol
[solidity](https://github.com/JoranHonig/tree-sitter-solidity) | core | `H    ` |  |  | @amaanq
[sparql](https://github.com/BonaBeavis/tree-sitter-sparql) | community | `HFIJL` |  |  | @BonaBeavis
[sql](https://github.com/derekstride/tree-sitter-sql) | community | `H IJ ` |  |  | @derekstride
[squirrel](https://github.com/amaanq/tree-sitter-squirrel) | core | `HFIJL` |  |  | @amaanq
[starlark](https://github.com/amaanq/tree-sitter-starlark) | core | `HFIJL` |  |  | @amaanq
[supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) | community | `HFIJL` |  |  | @madskjeldgaard
[surface](https://github.com/connorlay/tree-sitter-surface) | community | `HFIJ ` |  |  | @connorlay
[svelte](https://github.com/Himujjal/tree-sitter-svelte) | community | `HFIJ ` |  |  | @elianiva
[swift](https://github.com/alex-pinkus/tree-sitter-swift) | community | `H I L` | ✓ |  | @alex-pinkus
[sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) | community | `HF J ` |  |  | @RaafatTurki
[systemtap](https://github.com/ok-ryoko/tree-sitter-systemtap) | community | `HF JL` |  |  | @ok-ryoko
[t32](https://codeberg.org/xasc/tree-sitter-t32) | unsupported | `HFIJL` |  |  | @xasc
[tablegen](https://github.com/amaanq/tree-sitter-tablegen) | core | `HFIJL` |  |  | @amaanq
[teal](https://github.com/euclidianAce/tree-sitter-teal) | community | `HFIJL` | ✓ |  | @euclidianAce
[terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) | community | `HFIJ ` |  |  | @MichaHoffmann
[thrift](https://github.com/duskmoon314/tree-sitter-thrift) | core | `HFIJL` |  |  | @amaanq, @duskmoon314
[tiger](https://github.com/ambroisie/tree-sitter-tiger) | community | `HFIJL` |  |  | @ambroisie
[tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) | community | `HF JL` |  |  | @ahelwer, @susliko
[todotxt](https://github.com/arnarg/tree-sitter-todotxt.git) | unsupported | `H    ` |  |  | @arnarg
[toml](https://github.com/ikatyang/tree-sitter-toml) | community | `HFIJL` |  | ✓ | @tk-shirasaka
[tsx](https://github.com/tree-sitter/tree-sitter-typescript) | core | `HFIJL` |  | ✓ | @steelsojka
[turtle](https://github.com/BonaBeavis/tree-sitter-turtle) | community | `HFIJL` |  |  | @BonaBeavis
[twig](https://github.com/gbprod/tree-sitter-twig) | community | `H  J ` |  |  | @gbprod
[typescript](https://github.com/tree-sitter/tree-sitter-typescript) | core | `HFIJL` |  | ✓ | @steelsojka
[ungrammar](https://github.com/Philipp-M/tree-sitter-ungrammar) | community | `HFIJL` |  |  | @Philipp-M, @amaanq
[usd](https://github.com/ColinKennedy/tree-sitter-usd) | community | `HFI L` |  |  | @ColinKennedy
[uxntal](https://github.com/amaanq/tree-sitter-uxntal)[^uxntal] | core | `HFIJL` |  |  | @amaanq
[v](https://github.com/v-analyzer/v-analyzer) | community | `HFIJL` |  |  | @kkharji, @amaanq
[vala](https://github.com/vala-lang/tree-sitter-vala) | community | `HF   ` |  |  | @Prince781
[verilog](https://github.com/tree-sitter/tree-sitter-verilog) | community | `HF JL` |  |  | @zegervdv
[vhs](https://github.com/charmbracelet/tree-sitter-vhs) | community | `H    ` |  |  | @caarlos0
[vim](https://github.com/neovim/tree-sitter-vim) | stable | `HF JL` |  |  | @clason
[vimdoc](https://github.com/neovim/tree-sitter-vimdoc) | stable | `H  J ` |  |  | @clason
[vue](https://github.com/ikatyang/tree-sitter-vue) | community | `HFIJ ` |  |  | @WhyNotHugo
[wgsl](https://github.com/szebniok/tree-sitter-wgsl) | community | `HFI  ` |  |  | @szebniok
[wgsl_bevy](https://github.com/theHamsta/tree-sitter-wgsl-bevy) | core | `HFI  ` |  | ✓ | @theHamsta
[wing](https://github.com/winglang/wing) | unsupported | `HF  L` | ✓ |  | @gshpychka
[yaml](https://github.com/ikatyang/tree-sitter-yaml) | core | `HFIJL` |  |  | @stsewd
[yang](https://github.com/Hubro/tree-sitter-yang) | community | `HFIJ ` |  |  | @Hubro
[yuck](https://github.com/Philipp-M/tree-sitter-yuck) | community | `HFIJL` |  |  | @Philipp-M, @amaanq
[zig](https://github.com/maxxnino/tree-sitter-zig) | community | `HFIJL` |  |  | @maxxnino
[^ecma]: queries required by javascript, typescript, tsx, qmljs
[^gdscript]: Godot
[^glimmer]: Glimmer and Ember
[^godot_resource]: Godot Resources
[^html_tags]: queries required by html, astro, vue, svelte
[^jsx]: queries required by javascript, tsx
[^luap]: Lua patterns
[^markdown]: basic highlighting
[^markdown_inline]: needed for full highlighting
[^poe_filter]: Path of Exile item filter
[^query]: Tree-sitter query language
[^uxntal]: uxn tal
<!--parserinfo-->
