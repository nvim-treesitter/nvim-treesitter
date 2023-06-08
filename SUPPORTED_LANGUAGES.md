# Supported languages

The following is a list of languages for which a parser can be installed through `:TSInstall`.

Legend:
- **Tier:** _core_, _stable_, _community_, or _unstable_
- **CLI:** `:TSInstall` requires `tree-sitter` CLI installed
- **NPM:** `:TSInstallFromGrammar` requires `node` installed
- **Queries** available for **H**ighlights, **I**ndents, **F**olds, In**J**ections, **L**ocals

<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
Language | Tier | Queries | CLI | NPM | Maintainer
-------- |:----:|:-------:|:---:|:---:| ----------
[ada](https://github.com/briot/tree-sitter-ada) |  | `HF  L` |  |  | @briot
[agda](https://github.com/AusCyberman/tree-sitter-agda) |  | `HF   ` |  |  | @Decodetalkers
[arduino](https://github.com/ObserverOfTime/tree-sitter-arduino) |  | `HFIJL` |  |  | @ObserverOfTime
[astro](https://github.com/virchau13/tree-sitter-astro) |  | `HFIJL` |  |  | @virchau13
[awk](https://github.com/Beaglefoot/tree-sitter-awk) |  | `H  J ` |  |  | 
[bash](https://github.com/tree-sitter/tree-sitter-bash) |  | `HF JL` |  |  | @TravonteD
[bass](https://github.com/amaanq/tree-sitter-bass) |  | `HFIJL` |  |  | @amaanq
[beancount](https://github.com/polarmutex/tree-sitter-beancount) |  | `HF   ` |  |  | @polarmutex
[bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) | community | `HFI  ` |  |  | @theHamsta, @clason
[bicep](https://github.com/amaanq/tree-sitter-bicep) |  | `HFIJL` |  |  | @amaanq
[blueprint](https://gitlab.com/gabmus/tree-sitter-blueprint.git) | unstable | `H    ` |  |  | @gabmus
[c](https://github.com/tree-sitter/tree-sitter-c) | core | `HFIJL` |  |  | @amaanq
[c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) |  | `HF JL` |  |  | @Luxed
[capnp](https://github.com/amaanq/tree-sitter-capnp) |  | `HFIJL` |  |  | @amaanq
[chatito](https://github.com/ObserverOfTime/tree-sitter-chatito) |  | `HFIJL` |  |  | @ObserverOfTime
[clojure](https://github.com/sogaiu/tree-sitter-clojure) |  | `HF JL` |  |  | @sogaiu
[cmake](https://github.com/uyha/tree-sitter-cmake) |  | `HFI  ` |  |  | @uyha
[comment](https://github.com/stsewd/tree-sitter-comment) | stable | `H    ` |  |  | @stsewd
[commonlisp](https://github.com/theHamsta/tree-sitter-commonlisp) |  | `HF  L` |  | ✓ | @theHamsta
[cooklang](https://github.com/addcninblue/tree-sitter-cooklang) |  | `H    ` |  |  | @addcninblue
[corn](https://github.com/jakestanger/tree-sitter-corn) | community | `HFI L` |  |  | @jakestanger
[cpon](https://github.com/amaanq/tree-sitter-cpon) |  | `HFIJL` |  |  | @amaanq
[cpp](https://github.com/tree-sitter/tree-sitter-cpp) |  | `HFIJL` |  | ✓ | @theHamsta
[css](https://github.com/tree-sitter/tree-sitter-css) |  | `HFIJ ` |  |  | @TravonteD
[cuda](https://github.com/theHamsta/tree-sitter-cuda) |  | `HFIJL` |  | ✓ | @theHamsta
[cue](https://github.com/eonpatapon/tree-sitter-cue) |  | `HFIJL` |  |  | @amaanq
[d](https://github.com/CyberShadow/tree-sitter-d) | unstable | `HFIJ ` | ✓ |  | @nawordar
[dart](https://github.com/UserNobody14/tree-sitter-dart) |  | `HFIJL` |  |  | @akinsho
[devicetree](https://github.com/joelspadin/tree-sitter-devicetree) |  | `HFIJL` |  |  | @jedrzejboczar
[dhall](https://github.com/jbellerb/tree-sitter-dhall) |  | `HF J ` |  |  | @amaanq
[diff](https://github.com/the-mikedavis/tree-sitter-diff) |  | `H    ` |  |  | @gbprod
[dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) |  | `H  J ` |  |  | @camdencheek
[dot](https://github.com/rydesun/tree-sitter-dot) |  | `H  J ` |  |  | @rydesun
[ebnf](https://github.com/RubixDev/ebnf) | unstable | `H    ` |  |  | @RubixDev
ecma (queries only)[^ecma] |  | `HFIJL` |  |  | @steelsojka
[eex](https://github.com/connorlay/tree-sitter-eex) |  | `H  J ` |  |  | @connorlay
[elixir](https://github.com/elixir-lang/tree-sitter-elixir) |  | `HFIJL` |  |  | @connorlay
[elm](https://github.com/elm-tooling/tree-sitter-elm) |  | `H  J ` |  |  | @zweimach
[elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) |  | `HFIJL` |  |  | @glapa-grossklag, @amaanq
[elvish](https://github.com/ckafi/tree-sitter-elvish) |  | `H  J ` |  |  | @ckafi
[embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template) | unstable | `H  J ` |  |  | 
[erlang](https://github.com/WhatsApp/tree-sitter-erlang) |  | `HF   ` |  |  | @filmor
[fennel](https://github.com/travonted/tree-sitter-fennel) |  | `HF JL` |  |  | @TravonteD
[firrtl](https://github.com/amaanq/tree-sitter-firrtl) |  | `HFIJL` |  |  | @amaanq
[fish](https://github.com/ram02z/tree-sitter-fish) |  | `HFIJL` |  |  | @ram02z
[foam](https://github.com/FoamScience/tree-sitter-foam) | unstable | `HFIJL` |  |  | @FoamScience
[fortran](https://github.com/stadelmanma/tree-sitter-fortran) |  | `HFI  ` |  |  | @amaanq
[fsh](https://github.com/mgramigna/tree-sitter-fsh) |  | `H    ` |  |  | @mgramigna
[func](https://github.com/amaanq/tree-sitter-func) |  | `H    ` |  |  | @amaanq
[fusion](https://gitlab.com/jirgn/tree-sitter-fusion.git) |  | `HFI L` |  |  | @jirgn
[gdscript](https://github.com/PrestonKnopp/tree-sitter-gdscript)[^gdscript] |  | `HFIJL` |  |  | @PrestonKnopp
[git_config](https://github.com/the-mikedavis/tree-sitter-git-config)[^git_config] |  | `HF   ` |  |  | @amaanq
[git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) |  | `H  J ` |  |  | @gbprod
[gitattributes](https://github.com/ObserverOfTime/tree-sitter-gitattributes) |  | `H  J ` |  |  | @ObserverOfTime
[gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) |  | `H  J ` |  |  | @gbprod
[gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) |  | `H    ` |  |  | @theHamsta
[gleam](https://github.com/gleam-lang/tree-sitter-gleam) |  | `HFIJL` |  |  | @amaanq
[glimmer](https://github.com/alexlafroscia/tree-sitter-glimmer)[^glimmer] |  | `HFI L` |  |  | @NullVoxPopuli
[glsl](https://github.com/theHamsta/tree-sitter-glsl) |  | `HFIJL` |  | ✓ | @theHamsta
[go](https://github.com/tree-sitter/tree-sitter-go) |  | `HFIJL` |  |  | @theHamsta, @WinWisely268
[godot_resource](https://github.com/PrestonKnopp/tree-sitter-godot-resource)[^godot_resource] |  | `HF  L` |  |  | @pierpo
[gomod](https://github.com/camdencheek/tree-sitter-go-mod) |  | `H  J ` |  |  | @camdencheek
[gosum](https://github.com/amaanq/tree-sitter-go-sum) |  | `H    ` |  |  | @amaanq
[gowork](https://github.com/omertuc/tree-sitter-go-work) |  | `H  J ` |  |  | @omertuc
[graphql](https://github.com/bkegley/tree-sitter-graphql) |  | `H IJ ` |  |  | @bkegley
[groovy](https://github.com/Decodetalkers/tree-sitter-groovy) | community | `H  J ` |  |  | @Decodetalkers
[hack](https://github.com/slackhq/tree-sitter-hack) | unstable | `H    ` |  |  | 
[hare](https://github.com/amaanq/tree-sitter-hare) |  | `HFIJL` |  |  | @amaanq
[haskell](https://github.com/tree-sitter/tree-sitter-haskell) | unstable | `HF J ` |  |  | 
[haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) |  | `HF   ` |  |  | @lykahb
[hcl](https://github.com/MichaHoffmann/tree-sitter-hcl) |  | `HFIJ ` |  |  | @MichaHoffmann
[heex](https://github.com/connorlay/tree-sitter-heex) |  | `HFIJL` |  |  | @connorlay
[hjson](https://github.com/winston0410/tree-sitter-hjson) |  | `HFIJL` |  | ✓ | @winston0410
[hlsl](https://github.com/theHamsta/tree-sitter-hlsl) |  | `HFIJL` |  | ✓ | @theHamsta
[hocon](https://github.com/antosha417/tree-sitter-hocon) |  | `H  J ` |  | ✓ | @antosha417
[hoon](https://github.com/urbit-pilled/tree-sitter-hoon) | unstable | `HF  L` |  |  | @urbit-pilled
[html](https://github.com/tree-sitter/tree-sitter-html) |  | `HFIJL` |  |  | @TravonteD
html_tags (queries only)[^html_tags] |  | `H IJ ` |  |  | @TravonteD
[htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) | unstable | `HFIJ ` |  |  | @ObserverOfTime
[http](https://github.com/rest-nvim/tree-sitter-http) |  | `H  J ` |  | ✓ | @amaanq
[ini](https://github.com/justinmk/tree-sitter-ini) | unstable | `HF   ` |  |  | @theHamsta
[ispc](https://github.com/fab4100/tree-sitter-ispc) |  | `HFIJL` |  | ✓ | @fab4100
[janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) |  | `HF JL` |  |  | @sogaiu
[java](https://github.com/tree-sitter/tree-sitter-java) |  | `HFIJL` |  |  | @p00f
[javascript](https://github.com/tree-sitter/tree-sitter-javascript) |  | `HFIJL` |  |  | @steelsojka
[jq](https://github.com/flurie/tree-sitter-jq) |  | `H  J ` |  |  | @ObserverOfTime
[jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) |  | `H    ` |  |  | @steelsojka
[json](https://github.com/tree-sitter/tree-sitter-json) |  | `HFI L` |  |  | @steelsojka
[json5](https://github.com/Joakker/tree-sitter-json5) |  | `H  J ` |  |  | @Joakker
[jsonc](https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git) |  | `HFIJL` |  | ✓ | @WhyNotHugo
[jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) |  | `H    ` |  |  | @nawordar
jsx (queries only)[^jsx] |  | `HFIJ ` |  |  | @steelsojka
[julia](https://github.com/tree-sitter/tree-sitter-julia) | community | `HFIJL` |  |  | @theHamsta
[kdl](https://github.com/amaanq/tree-sitter-kdl) |  | `HFIJL` |  |  | @amaanq
[kotlin](https://github.com/fwcd/tree-sitter-kotlin) |  | `HF JL` |  |  | @SalBakraa
[lalrpop](https://github.com/traxys/tree-sitter-lalrpop) |  | `H  JL` |  |  | @traxys
[latex](https://github.com/latex-lsp/tree-sitter-latex) | community | `HF J ` |  |  | @theHamsta, @clason
[ledger](https://github.com/cbarrete/tree-sitter-ledger) |  | `HFIJ ` |  |  | @cbarrete
[llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) |  | `H    ` |  |  | @benwilliamgraham
[lua](https://github.com/MunifTanjim/tree-sitter-lua) | core | `HFIJL` |  |  | @muniftanjim
[luadoc](https://github.com/amaanq/tree-sitter-luadoc) |  | `H    ` |  |  | @amaanq
[luap](https://github.com/amaanq/tree-sitter-luap)[^luap] |  | `H    ` |  |  | @amaanq
[luau](https://github.com/amaanq/tree-sitter-luau) |  | `HFIJL` |  |  | @amaanq
[m68k](https://github.com/grahambates/tree-sitter-m68k) |  | `HF JL` |  |  | @grahambates
[make](https://github.com/alemuller/tree-sitter-make) |  | `HF J ` |  |  | @lewis6991
[markdown](https://github.com/MDeiml/tree-sitter-markdown)[^markdown] | core | `HFIJ ` |  |  | @MDeiml
[markdown_inline](https://github.com/MDeiml/tree-sitter-markdown)[^markdown_inline] | core | `H  J ` |  |  | @MDeiml
[matlab](https://github.com/acristoffers/tree-sitter-matlab) |  | `HFIJL` |  |  | @acristoffers
[menhir](https://github.com/Kerl13/tree-sitter-menhir) |  | `H  J ` |  |  | @Kerl13
[mermaid](https://github.com/monaqa/tree-sitter-mermaid) | unstable | `H    ` |  |  | 
[meson](https://github.com/Decodetalkers/tree-sitter-meson) |  | `HF J ` |  |  | @Decodetalkers
[mlir](https://github.com/artagnon/tree-sitter-mlir) | unstable | `H   L` | ✓ |  | @artagnon
[nickel](https://github.com/nickel-lang/tree-sitter-nickel) | unstable | `H I  ` |  |  | 
[ninja](https://github.com/alemuller/tree-sitter-ninja) |  | `HFI  ` |  |  | @alemuller
[nix](https://github.com/cstrahan/tree-sitter-nix) |  | `HF JL` |  |  | @leo60228
[objc](https://github.com/amaanq/tree-sitter-objc) |  | `HFIJL` |  |  | @amaanq
[ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) |  | `HFIJL` |  |  | @undu
[ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) |  | `HFIJL` |  |  | @undu
[ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) |  | `H  J ` | ✓ |  | @undu
[odin](https://github.com/amaanq/tree-sitter-odin) |  | `HFIJL` |  |  | @amaanq
[org](https://github.com/milisims/tree-sitter-org) | unstable | `     ` |  |  | 
[pascal](https://github.com/Isopod/tree-sitter-pascal.git) |  | `HFIJL` |  |  | @Isopod
[passwd](https://github.com/ath3/tree-sitter-passwd) |  | `H    ` |  |  | @amaanq
[pem](https://github.com/ObserverOfTime/tree-sitter-pem) | stable | `HF J ` |  |  | @ObserverOfTime
[perl](https://github.com/ganezdragon/tree-sitter-perl) |  | `HF J ` |  |  | @lcrownover
[php](https://github.com/tree-sitter/tree-sitter-php) |  | `HFIJL` |  |  | @tk-shirasaka
[phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) | unstable | `H    ` |  | ✓ | @mikehaertl
[pioasm](https://github.com/leo60228/tree-sitter-pioasm) |  | `H  J ` |  |  | @leo60228
[po](https://github.com/erasin/tree-sitter-po) |  | `HF J ` |  |  | @amaanq
[poe_filter](https://github.com/ObserverOfTime/tree-sitter-poe-filter)[^poe_filter] | unstable | `HFIJ ` |  |  | @ObserverOfTime
[pony](https://github.com/amaanq/tree-sitter-pony) |  | `HFIJL` |  |  | @amaanq, @mfelsche
[prisma](https://github.com/victorhqc/tree-sitter-prisma) |  | `H    ` |  |  | @elianiva
[proto](https://github.com/mitchellh/tree-sitter-proto) |  | `HF   ` |  |  | @fsouza
[prql](https://github.com/PRQL/tree-sitter-prql) |  | `H  J ` |  |  | @matthias-Q
[pug](https://github.com/zealot128/tree-sitter-pug) | unstable | `H  J ` |  |  | @zealot128
[puppet](https://github.com/amaanq/tree-sitter-puppet) |  | `HFIJL` |  |  | @amaanq
[python](https://github.com/tree-sitter/tree-sitter-python) |  | `HFIJL` |  |  | @stsewd, @theHamsta
[ql](https://github.com/tree-sitter/tree-sitter-ql) |  | `HFIJL` |  |  | @pwntester
[qmldir](https://github.com/Decodetalkers/tree-sitter-qmldir) |  | `H  J ` |  |  | @amaanq
[qmljs](https://github.com/yuja/tree-sitter-qmljs) |  | `HF   ` |  |  | @Decodetalkers
[query](https://github.com/nvim-treesitter/tree-sitter-query)[^query] | core | `HFIJL` |  |  | @steelsojka
[r](https://github.com/r-lib/tree-sitter-r) |  | `H IJL` |  |  | @echasnovski
[racket](https://github.com/6cdh/tree-sitter-racket) | unstable | `HF J ` |  |  | 
[rasi](https://github.com/Fymyte/tree-sitter-rasi) |  | `HFI L` |  |  | @Fymyte
[regex](https://github.com/tree-sitter/tree-sitter-regex) |  | `H    ` |  |  | @theHamsta
[rego](https://github.com/FallenAngel97/tree-sitter-rego) |  | `H  J ` |  |  | @FallenAngel97
[rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) |  | `HF J ` |  |  | @bamonroe
[ron](https://github.com/amaanq/tree-sitter-ron) |  | `HFIJL` |  |  | @amaanq
[rst](https://github.com/stsewd/tree-sitter-rst) |  | `H  JL` |  |  | @stsewd
[ruby](https://github.com/tree-sitter/tree-sitter-ruby) |  | `HFIJL` |  |  | @TravonteD
[rust](https://github.com/tree-sitter/tree-sitter-rust) |  | `HFIJL` |  |  | @amaanq
[scala](https://github.com/tree-sitter/tree-sitter-scala) |  | `HF JL` |  |  | @stevanmilic
[scheme](https://github.com/6cdh/tree-sitter-scheme) | unstable | `HF J ` |  |  | 
[scss](https://github.com/serenadeai/tree-sitter-scss) | community | `HFI  ` |  |  | @elianiva
[slint](https://github.com/jrmoulton/tree-sitter-slint) | unstable | `H I  ` |  |  | @jrmoulton
[smali](https://git.sr.ht/~yotam/tree-sitter-smali) |  | `HFIJL` |  |  | @amaanq
[smithy](https://github.com/indoorvivants/tree-sitter-smithy) |  | `H    ` |  |  | @amaanq, @keynmol
[solidity](https://github.com/JoranHonig/tree-sitter-solidity) |  | `H    ` |  |  | @amaanq
[sparql](https://github.com/BonaBeavis/tree-sitter-sparql) |  | `HFIJL` |  |  | @BonaBeavis
[sql](https://github.com/derekstride/tree-sitter-sql) |  | `H IJ ` |  |  | @derekstride
[squirrel](https://github.com/amaanq/tree-sitter-squirrel) |  | `HFIJL` |  |  | @amaanq
[starlark](https://github.com/amaanq/tree-sitter-starlark) |  | `HFIJL` |  |  | @amaanq
[supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) |  | `HFIJL` |  |  | @madskjeldgaard
[surface](https://github.com/connorlay/tree-sitter-surface) |  | `HFIJ ` |  |  | @connorlay
[svelte](https://github.com/Himujjal/tree-sitter-svelte) |  | `HFIJ ` |  |  | @elianiva
[swift](https://github.com/alex-pinkus/tree-sitter-swift) |  | `H I L` | ✓ |  | @alex-pinkus
[sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) |  | `HF J ` |  |  | @RaafatTurki
[t32](https://codeberg.org/xasc/tree-sitter-t32) |  | `HFIJL` |  |  | @xasc
[tablegen](https://github.com/amaanq/tree-sitter-tablegen) |  | `HFIJL` |  |  | @amaanq
[teal](https://github.com/euclidianAce/tree-sitter-teal) |  | `HFIJL` | ✓ |  | @euclidianAce
[terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) | community | `HFIJ ` |  |  | @MichaHoffmann
[thrift](https://github.com/duskmoon314/tree-sitter-thrift) |  | `HFIJL` |  |  | @amaanq, @duskmoon314
[tiger](https://github.com/ambroisie/tree-sitter-tiger) |  | `HFIJL` |  |  | @ambroisie
[tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) |  | `HF JL` |  |  | @ahelwer, @susliko
[todotxt](https://github.com/arnarg/tree-sitter-todotxt.git) | unstable | `H    ` |  |  | @arnarg
[toml](https://github.com/ikatyang/tree-sitter-toml) |  | `HFIJL` |  | ✓ | @tk-shirasaka
[tsx](https://github.com/tree-sitter/tree-sitter-typescript) |  | `HFIJL` |  | ✓ | @steelsojka
[turtle](https://github.com/BonaBeavis/tree-sitter-turtle) |  | `HFIJL` |  |  | @BonaBeavis
[twig](https://github.com/gbprod/tree-sitter-twig) |  | `H  J ` |  |  | @gbprod
[typescript](https://github.com/tree-sitter/tree-sitter-typescript) |  | `HFIJL` |  | ✓ | @steelsojka
[ungrammar](https://github.com/Philipp-M/tree-sitter-ungrammar) |  | `HFIJL` |  |  | @Philipp-M, @amaanq
[usd](https://github.com/ColinKennedy/tree-sitter-usd) |  | `HFI L` |  |  | @ColinKennedy
[uxntal](https://github.com/amaanq/tree-sitter-uxntal)[^uxntal] |  | `HFIJL` |  |  | @amaanq
[v](https://github.com/vlang/vls) |  | `HFIJL` |  |  | @kkharji
[vala](https://github.com/vala-lang/tree-sitter-vala) |  | `HF   ` |  |  | @Prince781
[verilog](https://github.com/tree-sitter/tree-sitter-verilog) |  | `HF JL` |  |  | @zegervdv
[vhs](https://github.com/charmbracelet/tree-sitter-vhs) |  | `H    ` |  |  | @caarlos0
[vim](https://github.com/neovim/tree-sitter-vim) | core | `HF JL` |  |  | @clason
[vimdoc](https://github.com/neovim/tree-sitter-vimdoc) | core | `H  J ` |  |  | @clason
[vue](https://github.com/ikatyang/tree-sitter-vue) |  | `HFIJ ` |  |  | @WhyNotHugo
[wgsl](https://github.com/szebniok/tree-sitter-wgsl) |  | `HFI  ` |  |  | @szebniok
[wgsl_bevy](https://github.com/theHamsta/tree-sitter-wgsl-bevy) |  | `HFI  ` |  | ✓ | @theHamsta
[wing](https://github.com/winglang/wing) | unstable | `HF  L` | ✓ |  | @gshpychka
[yaml](https://github.com/ikatyang/tree-sitter-yaml) |  | `HFIJL` |  |  | @stsewd
[yang](https://github.com/Hubro/tree-sitter-yang) |  | `HFIJ ` |  |  | @Hubro
[yuck](https://github.com/Philipp-M/tree-sitter-yuck) |  | `HFIJL` |  |  | @Philipp-M, @amaanq
[zig](https://github.com/maxxnino/tree-sitter-zig) |  | `HFIJL` |  |  | @maxxnino
[^ecma]: queries required by javascript, typescript, tsx, qmljs
[^gdscript]: Godot
[^git_config]: git_config
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
