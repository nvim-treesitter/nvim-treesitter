# Supported languages

The following is a list of languages for which a parser can be installed through `:TSInstall`.

Legend:
- **Tier:** _core_, _stable_, _community_, or _unstable_
- **CLI:** `:TSInstall` requires `tree-sitter` CLI installed
- **NPM:** `:TSInstallFromGrammar` requires `node` installed
- **Queries** available for **H**ighlights, **I**ndents, **F**olds, In**J**ections

<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
Language | Tier | Queries | CLI | NPM | Maintainer
-------- |:----:|:-------:|:---:|:---:| ----------
[ada](https://github.com/briot/tree-sitter-ada) |  | `HF  ` |  |  | @briot
[agda](https://github.com/tree-sitter/tree-sitter-agda) |  | `HF  ` |  |  | @Decodetalkers
[apex](https://github.com/aheber/tree-sitter-sfapex) | community | `HF  ` |  |  | @aheber
[arduino](https://github.com/ObserverOfTime/tree-sitter-arduino) |  | `HFIJ` |  |  | @ObserverOfTime
[astro](https://github.com/virchau13/tree-sitter-astro) |  | `HFIJ` |  |  | @virchau13
[authzed](https://github.com/mleonidas/tree-sitter-authzed) | community | `H  J` |  |  | @mattpolzin
[awk](https://github.com/Beaglefoot/tree-sitter-awk) |  | `H  J` |  |  | 
[bash](https://github.com/tree-sitter/tree-sitter-bash) |  | `HF J` |  |  | @TravonteD
[bass](https://github.com/amaanq/tree-sitter-bass) |  | `HFIJ` |  |  | @amaanq
[beancount](https://github.com/polarmutex/tree-sitter-beancount) |  | `HF  ` |  |  | @polarmutex
[bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) | community | `HFI ` |  |  | @theHamsta, @clason
[bicep](https://github.com/amaanq/tree-sitter-bicep) |  | `HFIJ` |  |  | @amaanq
[bitbake](https://github.com/amaanq/tree-sitter-bitbake) | stable | `HFIJ` |  |  | @amaanq
[blueprint](https://gitlab.com/gabmus/tree-sitter-blueprint.git) | unstable | `H   ` |  |  | @gabmus
[c](https://github.com/tree-sitter/tree-sitter-c) | core | `HFIJ` |  |  | @amaanq
[c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) |  | `HF J` |  |  | @Luxed
[cairo](https://github.com/amaanq/tree-sitter-cairo) | stable | `HFIJ` |  |  | @amaanq
[capnp](https://github.com/amaanq/tree-sitter-capnp) |  | `HFIJ` |  |  | @amaanq
[chatito](https://github.com/ObserverOfTime/tree-sitter-chatito) |  | `HFIJ` |  |  | @ObserverOfTime
[clojure](https://github.com/sogaiu/tree-sitter-clojure) |  | `HF J` |  |  | @NoahTheDuke
[cmake](https://github.com/uyha/tree-sitter-cmake) |  | `HFI ` |  |  | @uyha
[comment](https://github.com/stsewd/tree-sitter-comment) | stable | `H   ` |  |  | @stsewd
[commonlisp](https://github.com/theHamsta/tree-sitter-commonlisp) |  | `HF  ` |  | ✓ | @theHamsta
[cooklang](https://github.com/addcninblue/tree-sitter-cooklang) |  | `H   ` |  |  | @addcninblue
[corn](https://github.com/jakestanger/tree-sitter-corn) | community | `HFI ` |  |  | @jakestanger
[cpon](https://github.com/amaanq/tree-sitter-cpon) |  | `HFIJ` |  |  | @amaanq
[cpp](https://github.com/tree-sitter/tree-sitter-cpp) |  | `HFIJ` |  | ✓ | @theHamsta
[css](https://github.com/tree-sitter/tree-sitter-css) |  | `HFIJ` |  |  | @TravonteD
[csv](https://github.com/amaanq/tree-sitter-csv) | stable | `H   ` |  |  | @amaanq
[cuda](https://github.com/theHamsta/tree-sitter-cuda) |  | `HFIJ` |  | ✓ | @theHamsta
[cue](https://github.com/eonpatapon/tree-sitter-cue) |  | `HFIJ` |  |  | @amaanq
[d](https://github.com/CyberShadow/tree-sitter-d) | unstable | `HFIJ` | ✓ |  | @nawordar
[dart](https://github.com/UserNobody14/tree-sitter-dart) |  | `HFIJ` |  |  | @akinsho
[devicetree](https://github.com/joelspadin/tree-sitter-devicetree) |  | `HFIJ` |  |  | @jedrzejboczar
[dhall](https://github.com/jbellerb/tree-sitter-dhall) |  | `HF J` |  |  | @amaanq
[diff](https://github.com/the-mikedavis/tree-sitter-diff) |  | `H   ` |  |  | @gbprod
[dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) |  | `H  J` |  |  | @camdencheek
[dot](https://github.com/rydesun/tree-sitter-dot) |  | `H  J` |  |  | @rydesun
[doxygen](https://github.com/amaanq/tree-sitter-doxygen) | stable | `H IJ` |  |  | @amaanq
[dtd](https://github.com/ObserverOfTime/tree-sitter-xml) | stable | `HF J` |  |  | @ObserverOfTime
[ebnf](https://github.com/RubixDev/ebnf) | unstable | `H   ` |  |  | @RubixDev
[eds](https://github.com/uyha/tree-sitter-eds) | community | `HF  ` |  |  | @uyha
[eex](https://github.com/connorlay/tree-sitter-eex) |  | `H  J` |  |  | @connorlay
[elixir](https://github.com/elixir-lang/tree-sitter-elixir) |  | `HFIJ` |  |  | @connorlay
[elm](https://github.com/elm-tooling/tree-sitter-elm) |  | `H  J` |  |  | @zweimach
[elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) |  | `HFIJ` |  |  | @glapa-grossklag, @amaanq
[elvish](https://github.com/elves/tree-sitter-elvish) |  | `H  J` |  |  | @elves
[embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template) |  | `H  J` |  |  | 
[erlang](https://github.com/WhatsApp/tree-sitter-erlang) |  | `HF  ` |  |  | @filmor
[fennel](https://github.com/travonted/tree-sitter-fennel) |  | `HF J` |  |  | @TravonteD
[firrtl](https://github.com/amaanq/tree-sitter-firrtl) |  | `HFIJ` |  |  | @amaanq
[fish](https://github.com/ram02z/tree-sitter-fish) |  | `HFIJ` |  |  | @ram02z
[foam](https://github.com/FoamScience/tree-sitter-foam) | unstable | `HFIJ` |  |  | @FoamScience
[forth](https://github.com/AlexanderBrevig/tree-sitter-forth) | stable | `HFIJ` |  |  | @amaanq
[fortran](https://github.com/stadelmanma/tree-sitter-fortran) |  | `HFI ` |  |  | @amaanq
[fsh](https://github.com/mgramigna/tree-sitter-fsh) |  | `H   ` |  |  | @mgramigna
[func](https://github.com/amaanq/tree-sitter-func) |  | `H   ` |  |  | @amaanq
[fusion](https://gitlab.com/jirgn/tree-sitter-fusion.git) |  | `HFI ` |  |  | @jirgn
[gdscript](https://github.com/PrestonKnopp/tree-sitter-gdscript)[^gdscript] |  | `HFIJ` |  |  | @PrestonKnopp
[git_config](https://github.com/the-mikedavis/tree-sitter-git-config)[^git_config] |  | `HF  ` |  |  | @amaanq
[git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) |  | `H  J` |  |  | @gbprod
[gitattributes](https://github.com/ObserverOfTime/tree-sitter-gitattributes) |  | `H  J` |  |  | @ObserverOfTime
[gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) |  | `H  J` |  |  | @gbprod
[gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) |  | `H   ` |  |  | @theHamsta
[gleam](https://github.com/gleam-lang/tree-sitter-gleam) |  | `HFIJ` |  |  | @amaanq
[glimmer](https://github.com/alexlafroscia/tree-sitter-glimmer)[^glimmer] |  | `HFI ` |  |  | @NullVoxPopuli
[glsl](https://github.com/theHamsta/tree-sitter-glsl) |  | `HFIJ` |  | ✓ | @theHamsta
[gn](https://github.com/amaanq/tree-sitter-gn) | stable | `HFIJ` |  |  | @amaanq
[go](https://github.com/tree-sitter/tree-sitter-go) |  | `HFIJ` |  |  | @theHamsta, @WinWisely268
[godot_resource](https://github.com/PrestonKnopp/tree-sitter-godot-resource)[^godot_resource] |  | `HF  ` |  |  | @pierpo
[gomod](https://github.com/camdencheek/tree-sitter-go-mod) |  | `H  J` |  |  | @camdencheek
[gosum](https://github.com/amaanq/tree-sitter-go-sum) |  | `H   ` |  |  | @amaanq
[gowork](https://github.com/omertuc/tree-sitter-go-work) |  | `H  J` |  |  | @omertuc
[gpg](https://github.com/ObserverOfTime/tree-sitter-gpg-config) | stable | `H  J` |  |  | @ObserverOfTime
[graphql](https://github.com/bkegley/tree-sitter-graphql) |  | `H IJ` |  |  | @bkegley
[groovy](https://github.com/Decodetalkers/tree-sitter-groovy) | community | `H  J` |  |  | @Decodetalkers
[gstlaunch](https://github.com/theHamsta/tree-sitter-gstlaunch) | stable | `H   ` |  |  | @theHamsta
[hack](https://github.com/slackhq/tree-sitter-hack) |  | `H   ` |  |  | 
[hare](https://github.com/amaanq/tree-sitter-hare) |  | `HFIJ` |  |  | @amaanq
[haskell](https://github.com/tree-sitter/tree-sitter-haskell) |  | `HF J` |  |  | @mrcjkb
[haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) |  | `HF  ` |  |  | @lykahb
[hcl](https://github.com/MichaHoffmann/tree-sitter-hcl) |  | `HFIJ` |  |  | @MichaHoffmann
[heex](https://github.com/connorlay/tree-sitter-heex) |  | `HFIJ` |  |  | @connorlay
[hjson](https://github.com/winston0410/tree-sitter-hjson) |  | `HFIJ` |  | ✓ | @winston0410
[hlsl](https://github.com/theHamsta/tree-sitter-hlsl) |  | `HFIJ` |  | ✓ | @theHamsta
[hocon](https://github.com/antosha417/tree-sitter-hocon) |  | `H  J` |  | ✓ | @antosha417
[hoon](https://github.com/urbit-pilled/tree-sitter-hoon) | unstable | `HF  ` |  |  | @urbit-pilled
[html](https://github.com/tree-sitter/tree-sitter-html) |  | `HFIJ` |  |  | @TravonteD
[htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) | unstable | `HFIJ` |  |  | @ObserverOfTime
[http](https://github.com/rest-nvim/tree-sitter-http) |  | `H  J` |  | ✓ | @amaanq
[hurl](https://github.com/pfeiferj/tree-sitter-hurl) | community | `HFIJ` |  |  | @pfeiferj
[ini](https://github.com/justinmk/tree-sitter-ini) | unstable | `HF  ` |  |  | @theHamsta
[ispc](https://github.com/fab4100/tree-sitter-ispc) |  | `HFIJ` |  | ✓ | @fab4100
[janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) |  | `HF J` |  |  | @sogaiu
[java](https://github.com/tree-sitter/tree-sitter-java) |  | `HFIJ` |  |  | @p00f
[javascript](https://github.com/tree-sitter/tree-sitter-javascript) |  | `HFIJ` |  |  | @steelsojka
[jq](https://github.com/flurie/tree-sitter-jq) |  | `H  J` |  |  | @ObserverOfTime
[jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) |  | `H   ` |  |  | @steelsojka
[json](https://github.com/tree-sitter/tree-sitter-json) |  | `HFI ` |  |  | @steelsojka
[json5](https://github.com/Joakker/tree-sitter-json5) |  | `H  J` |  |  | @Joakker
[jsonc](https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git)[^jsonc] |  | `HFIJ` |  | ✓ | @WhyNotHugo
[jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) |  | `HF  ` |  |  | @nawordar
[julia](https://github.com/tree-sitter/tree-sitter-julia) | community | `HFIJ` |  |  | @theHamsta
[kconfig](https://github.com/amaanq/tree-sitter-kconfig) | stable | `HFIJ` |  |  | @amaanq
[kdl](https://github.com/amaanq/tree-sitter-kdl) |  | `HFIJ` |  |  | @amaanq
[kotlin](https://github.com/fwcd/tree-sitter-kotlin) |  | `HF J` |  |  | @SalBakraa
[lalrpop](https://github.com/traxys/tree-sitter-lalrpop) |  | `H  J` |  |  | @traxys
[latex](https://github.com/latex-lsp/tree-sitter-latex) | community | `HF J` |  |  | @theHamsta, @clason
[ledger](https://github.com/cbarrete/tree-sitter-ledger) |  | `HFIJ` |  |  | @cbarrete
[leo](https://github.com/r001/tree-sitter-leo) | community | `H  J` |  |  | @r001
[liquidsoap](https://github.com/savonet/tree-sitter-liquidsoap) | community | `HFI ` |  |  | @toots
[llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) |  | `H   ` |  |  | @benwilliamgraham
[lua](https://github.com/MunifTanjim/tree-sitter-lua) | core | `HFIJ` |  |  | @muniftanjim
[luadoc](https://github.com/amaanq/tree-sitter-luadoc) |  | `H   ` |  |  | @amaanq
[luap](https://github.com/amaanq/tree-sitter-luap)[^luap] |  | `H   ` |  |  | @amaanq
[luau](https://github.com/amaanq/tree-sitter-luau) |  | `HFIJ` |  |  | @amaanq
[m68k](https://github.com/grahambates/tree-sitter-m68k) |  | `HF J` |  |  | @grahambates
[make](https://github.com/alemuller/tree-sitter-make) |  | `HF J` |  |  | @lewis6991
[markdown](https://github.com/MDeiml/tree-sitter-markdown)[^markdown] | core | `HFIJ` |  |  | @MDeiml
[markdown_inline](https://github.com/MDeiml/tree-sitter-markdown)[^markdown_inline] | core | `H  J` |  |  | @MDeiml
[matlab](https://github.com/acristoffers/tree-sitter-matlab) |  | `HFIJ` |  |  | @acristoffers
[menhir](https://github.com/Kerl13/tree-sitter-menhir) |  | `H  J` |  |  | @Kerl13
[mermaid](https://github.com/monaqa/tree-sitter-mermaid) | unstable | `H   ` |  |  | 
[meson](https://github.com/Decodetalkers/tree-sitter-meson) |  | `HF J` |  |  | @Decodetalkers
[mlir](https://github.com/artagnon/tree-sitter-mlir) | unstable | `H   ` | ✓ |  | @artagnon
[nasm](https://github.com/naclsn/tree-sitter-nasm) | stable | `H  J` |  |  | @ObserverOfTime
[nickel](https://github.com/nickel-lang/tree-sitter-nickel) |  | `H I ` |  |  | 
[nim](https://github.com/alaviss/tree-sitter-nim) | community | `HF J` |  |  | @aMOPel
[nim_format_string](https://github.com/aMOPel/tree-sitter-nim-format-string) | community | `H  J` |  |  | @aMOPel
[ninja](https://github.com/alemuller/tree-sitter-ninja) |  | `HFI ` |  |  | @alemuller
[nix](https://github.com/cstrahan/tree-sitter-nix) |  | `HF J` |  |  | @leo60228
[norg](https://github.com/nvim-neorg/tree-sitter-norg) | unstable | `    ` |  |  | @JoeyGrajciar, @vhyrro
[nqc](https://github.com/amaanq/tree-sitter-nqc) | stable | `HFIJ` |  |  | @amaanq
[objc](https://github.com/amaanq/tree-sitter-objc) |  | `HFIJ` |  |  | @amaanq
[objdump](https://github.com/ColinKennedy/tree-sitter-objdump) | community | `H  J` |  |  | @ColinKennedy
[ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) |  | `HFIJ` |  |  | @undu
[ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) |  | `HFIJ` |  |  | @undu
[ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) |  | `H  J` | ✓ |  | @undu
[odin](https://github.com/amaanq/tree-sitter-odin) |  | `HFIJ` |  |  | @amaanq
[org](https://github.com/milisims/tree-sitter-org) |  | `    ` |  |  | 
[pascal](https://github.com/Isopod/tree-sitter-pascal.git) |  | `HFIJ` |  |  | @Isopod
[passwd](https://github.com/ath3/tree-sitter-passwd) |  | `H   ` |  |  | @amaanq
[pem](https://github.com/ObserverOfTime/tree-sitter-pem) | stable | `HF J` |  |  | @ObserverOfTime
[perl](https://github.com/tree-sitter-perl/tree-sitter-perl) |  | `HF J` |  |  | @RabbiVeesh, @LeoNerd
[php](https://github.com/tree-sitter/tree-sitter-php) |  | `HFIJ` |  |  | @tk-shirasaka
[phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) | unstable | `H   ` |  | ✓ | @mikehaertl
[pioasm](https://github.com/leo60228/tree-sitter-pioasm) |  | `H  J` |  |  | @leo60228
[po](https://github.com/erasin/tree-sitter-po) |  | `HF J` |  |  | @amaanq
[pod](https://github.com/tree-sitter-perl/tree-sitter-pod) | community | `H   ` |  |  | @RabbiVeesh, @LeoNerd
[poe_filter](https://github.com/ObserverOfTime/tree-sitter-poe-filter)[^poe_filter] | unstable | `HFIJ` |  |  | @ObserverOfTime
[pony](https://github.com/amaanq/tree-sitter-pony) |  | `HFIJ` |  |  | @amaanq, @mfelsche
[prisma](https://github.com/victorhqc/tree-sitter-prisma) |  | `HF  ` |  |  | @elianiva
[promql](https://github.com/MichaHoffmann/tree-sitter-promql) | unstable | `H  J` |  |  | @MichaHoffmann
[proto](https://github.com/treywood/tree-sitter-proto) |  | `HF  ` |  |  | @treywood
[prql](https://github.com/PRQL/tree-sitter-prql) |  | `H  J` |  |  | @matthias-Q
[psv](https://github.com/amaanq/tree-sitter-csv) | stable | `H   ` |  |  | @amaanq
[pug](https://github.com/zealot128/tree-sitter-pug) | unstable | `H  J` |  |  | @zealot128
[puppet](https://github.com/amaanq/tree-sitter-puppet) |  | `HFIJ` |  |  | @amaanq
[pymanifest](https://github.com/ObserverOfTime/tree-sitter-pymanifest) | stable | `H  J` |  |  | @ObserverOfTime
[python](https://github.com/tree-sitter/tree-sitter-python) |  | `HFIJ` |  |  | @stsewd, @theHamsta
[ql](https://github.com/tree-sitter/tree-sitter-ql) |  | `HFIJ` |  |  | @pwntester
[qmldir](https://github.com/Decodetalkers/tree-sitter-qmldir) |  | `H  J` |  |  | @amaanq
[qmljs](https://github.com/yuja/tree-sitter-qmljs) |  | `HF  ` |  |  | @Decodetalkers
[query](https://github.com/nvim-treesitter/tree-sitter-query)[^query] | core | `HFIJ` |  |  | @steelsojka
[r](https://github.com/r-lib/tree-sitter-r) |  | `H IJ` |  |  | @echasnovski
[racket](https://github.com/6cdh/tree-sitter-racket) | unstable | `HF J` |  |  | 
[rasi](https://github.com/Fymyte/tree-sitter-rasi) |  | `HFI ` |  |  | @Fymyte
[re2c](https://github.com/amaanq/tree-sitter-re2c) | stable | `HFIJ` |  |  | @amaanq
[regex](https://github.com/tree-sitter/tree-sitter-regex) |  | `H   ` |  |  | @theHamsta
[rego](https://github.com/FallenAngel97/tree-sitter-rego) |  | `H  J` |  |  | @FallenAngel97
[requirements](https://github.com/ObserverOfTime/tree-sitter-requirements) | stable | `H  J` |  |  | @ObserverOfTime
[rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) |  | ` F J` |  |  | @bamonroe
[robot](https://github.com/Hubro/tree-sitter-robot) | community | `HFI ` |  |  | @Hubro
[ron](https://github.com/amaanq/tree-sitter-ron) |  | `HFIJ` |  |  | @amaanq
[rst](https://github.com/stsewd/tree-sitter-rst) |  | `H  J` |  |  | @stsewd
[ruby](https://github.com/tree-sitter/tree-sitter-ruby) |  | `HFIJ` |  |  | @TravonteD
[rust](https://github.com/tree-sitter/tree-sitter-rust) |  | `HFIJ` |  |  | @amaanq
[scala](https://github.com/tree-sitter/tree-sitter-scala) |  | `HF J` |  |  | @stevanmilic
[scfg](https://git.sr.ht/~rockorager/tree-sitter-scfg) | community | `H  J` | ✓ |  | @WhyNotHugo
[scheme](https://github.com/6cdh/tree-sitter-scheme) | unstable | `HF J` |  |  | 
[scss](https://github.com/serenadeai/tree-sitter-scss) |  | `HFI ` |  |  | @elianiva
[slint](https://github.com/jrmoulton/tree-sitter-slint) | unstable | `H I ` |  |  | @jrmoulton
[smali](https://git.sr.ht/~yotam/tree-sitter-smali) |  | `HFIJ` |  |  | @amaanq
[smithy](https://github.com/indoorvivants/tree-sitter-smithy) |  | `H   ` |  |  | @amaanq, @keynmol
[snakemake](https://github.com/osthomas/tree-sitter-snakemake) | unstable | `HF J` |  |  | 
[solidity](https://github.com/JoranHonig/tree-sitter-solidity) |  | `HF  ` |  |  | @amaanq
[soql](https://github.com/aheber/tree-sitter-sfapex) | community | `H   ` |  |  | @aheber
[sosl](https://github.com/aheber/tree-sitter-sfapex) |  | `H   ` |  |  | @aheber
[sparql](https://github.com/BonaBeavis/tree-sitter-sparql) |  | `HFIJ` |  |  | @BonaBeavis
[sql](https://github.com/derekstride/tree-sitter-sql) |  | `H IJ` |  |  | @derekstride
[squirrel](https://github.com/amaanq/tree-sitter-squirrel) |  | `HFIJ` |  |  | @amaanq
[ssh_config](https://github.com/ObserverOfTime/tree-sitter-ssh-config) | stable | `HFIJ` |  |  | @ObserverOfTime
[starlark](https://github.com/amaanq/tree-sitter-starlark) |  | `HFIJ` |  |  | @amaanq
[strace](https://github.com/sigmaSd/tree-sitter-strace) | stable | `H  J` |  |  | @amaanq
[supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) |  | `HFIJ` |  |  | @madskjeldgaard
[surface](https://github.com/connorlay/tree-sitter-surface) |  | `HFIJ` |  |  | @connorlay
[svelte](https://github.com/Himujjal/tree-sitter-svelte) |  | `HFIJ` |  |  | @elianiva
[swift](https://github.com/alex-pinkus/tree-sitter-swift) |  | `H I ` | ✓ |  | @alex-pinkus
[sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) |  | `HF J` |  |  | @RaafatTurki
[systemtap](https://github.com/ok-ryoko/tree-sitter-systemtap) | community | `HF J` |  |  | @ok-ryoko
[t32](https://gitlab.com/xasc/tree-sitter-t32.git) | community | `HFIJ` |  |  | @xasc
[tablegen](https://github.com/amaanq/tree-sitter-tablegen) |  | `HFIJ` |  |  | @amaanq
[teal](https://github.com/euclidianAce/tree-sitter-teal) |  | `HFIJ` | ✓ |  | @euclidianAce
[terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) |  | `HFIJ` |  |  | @MichaHoffmann
[textproto](https://github.com/PorterAtGoogle/tree-sitter-textproto) | community | `HFI ` |  |  | @Porter
[thrift](https://github.com/duskmoon314/tree-sitter-thrift) |  | `HFIJ` |  |  | @amaanq, @duskmoon314
[tiger](https://github.com/ambroisie/tree-sitter-tiger) |  | `HFIJ` |  |  | @ambroisie
[tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) |  | `HF J` |  |  | @ahelwer, @susliko
[todotxt](https://github.com/arnarg/tree-sitter-todotxt.git) | unstable | `H   ` |  |  | @arnarg
[toml](https://github.com/ikatyang/tree-sitter-toml) |  | `HFIJ` |  | ✓ | @tk-shirasaka
[tsv](https://github.com/amaanq/tree-sitter-csv) | stable | `H   ` |  |  | @amaanq
[tsx](https://github.com/tree-sitter/tree-sitter-typescript) |  | `HFIJ` |  | ✓ | @steelsojka
[turtle](https://github.com/BonaBeavis/tree-sitter-turtle) |  | `HFIJ` |  |  | @BonaBeavis
[twig](https://github.com/gbprod/tree-sitter-twig) |  | `H  J` |  |  | @gbprod
[typescript](https://github.com/tree-sitter/tree-sitter-typescript) |  | `HFIJ` |  | ✓ | @steelsojka
[typoscript](https://github.com/Teddytrombone/tree-sitter-typoscript) | community | `HFIJ` |  |  | @Teddytrombone
[ungrammar](https://github.com/Philipp-M/tree-sitter-ungrammar) |  | `HFIJ` |  |  | @Philipp-M, @amaanq
[unison](https://github.com/kylegoetz/tree-sitter-unison) | unstable | `H  J` | ✓ |  | @tapegram
[usd](https://github.com/ColinKennedy/tree-sitter-usd) |  | `HFI ` |  |  | @ColinKennedy
[uxntal](https://github.com/amaanq/tree-sitter-uxntal)[^uxntal] |  | `HFIJ` |  |  | @amaanq
[v](https://github.com/v-analyzer/v-analyzer) |  | `HFIJ` |  |  | @kkharji, @amaanq
[vala](https://github.com/vala-lang/tree-sitter-vala) |  | `HF  ` |  |  | @Prince781
[verilog](https://github.com/tree-sitter/tree-sitter-verilog) |  | `HF J` |  |  | @zegervdv
[vhs](https://github.com/charmbracelet/tree-sitter-vhs) |  | `H   ` |  |  | @caarlos0
[vim](https://github.com/neovim/tree-sitter-vim) | core | `HF J` |  |  | @clason
[vimdoc](https://github.com/neovim/tree-sitter-vimdoc) | core | `H  J` |  |  | @clason
[vue](https://github.com/ikatyang/tree-sitter-vue) |  | `HFIJ` |  |  | @WhyNotHugo
[wgsl](https://github.com/szebniok/tree-sitter-wgsl) |  | `HFI ` |  |  | @szebniok
[wgsl_bevy](https://github.com/theHamsta/tree-sitter-wgsl-bevy) |  | `HFI ` |  | ✓ | @theHamsta
[wing](https://github.com/winglang/wing) | unstable | `HF  ` | ✓ |  | @gshpychka
[xml](https://github.com/ObserverOfTime/tree-sitter-xml) | stable | `HFIJ` |  |  | @ObserverOfTime
[yaml](https://github.com/ikatyang/tree-sitter-yaml) |  | `HFIJ` |  |  | @stsewd
[yang](https://github.com/Hubro/tree-sitter-yang) |  | `HFIJ` |  |  | @Hubro
[yuck](https://github.com/Philipp-M/tree-sitter-yuck) |  | `HFIJ` |  |  | @Philipp-M, @amaanq
[zig](https://github.com/maxxnino/tree-sitter-zig) |  | `HFIJ` |  |  | @maxxnino
[^gdscript]: Godot
[^git_config]: git_config
[^glimmer]: Glimmer and Ember
[^godot_resource]: Godot Resources
[^jsonc]: JSON with comments
[^luap]: Lua patterns
[^markdown]: basic highlighting
[^markdown_inline]: needed for full highlighting
[^poe_filter]: Path of Exile item filter
[^query]: Tree-sitter query language
[^uxntal]: uxn tal
<!--parserinfo-->
