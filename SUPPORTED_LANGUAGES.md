# Supported languages

The following is a list of languages for which a parser can be installed through `:TSInstall`.

Legend:
- **Tier:** _stable_ (updates follow semver releases), _unstable_ (updates follow HEAD), _unmaintained_ (no automatic updates), or _unsupported_ (known to be broken, cannot be installed)
- **Queries** available for **H**ighlights, **I**ndents, **F**olds, In**J**ections, **L**ocals
- **Node:** Parser requires `node` for installation
- **Maintainer** of queries in nvim-treesitter (may be different from parser maintainer!)

<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
Language | Tier | Queries | Node | Maintainer
-------- |:----:|:-------:|:----:| ----------
[ada](https://github.com/briot/tree-sitter-ada) | unstable | `HF JL` |   | @briot
[agda](https://github.com/tree-sitter/tree-sitter-agda) | unstable | `HF J ` |   | @Decodetalkers
[angular](https://github.com/dlvandenberg/tree-sitter-angular) | unstable | `HFIJL` |   | @dlvandenberg
[apex](https://github.com/aheber/tree-sitter-sfapex) | unstable | `HF JL` |   | @aheber, @xixiafinland
[arduino](https://github.com/tree-sitter-grammars/tree-sitter-arduino) | unstable | `HFIJL` |   | @ObserverOfTime
[asm](https://github.com/RubixDev/tree-sitter-asm) | unstable | `H  J ` |   | @RubixDev
[astro](https://github.com/virchau13/tree-sitter-astro) | unstable | `HFIJL` |   | @virchau13
[authzed](https://github.com/mleonidas/tree-sitter-authzed) | unstable | `H  J ` |   | @mattpolzin
[awk](https://github.com/Beaglefoot/tree-sitter-awk) | unstable | `H  J ` |   | 
[bash](https://github.com/tree-sitter/tree-sitter-bash) | unstable | `HF JL` |   | @TravonteD
[bass](https://github.com/vito/tree-sitter-bass) | unstable | `HFIJL` |   | @amaanq
[beancount](https://github.com/polarmutex/tree-sitter-beancount) | unstable | `HF J ` |   | @polarmutex
[bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) | unstable | `HFIJ ` |   | @theHamsta, @clason
[bicep](https://github.com/tree-sitter-grammars/tree-sitter-bicep) | unstable | `HFIJL` |   | @amaanq
[bitbake](https://github.com/tree-sitter-grammars/tree-sitter-bitbake) | unstable | `HFIJL` |   | @amaanq
[blade](https://github.com/EmranMR/tree-sitter-blade) | unstable | `HFIJ ` |   | @calebdw
[blueprint](https://gitlab.com/gabmus/tree-sitter-blueprint) | unstable | `H  J ` |   | @gabmus
[bp](https://github.com/ambroisie/tree-sitter-bp)[^bp] | unstable | `HFIJL` |   | @ambroisie
[brightscript](https://github.com/ajdelcimmuto/tree-sitter-brightscript) | unstable | `HFIJ ` |   | @ajdelcimmuto
[c](https://github.com/tree-sitter/tree-sitter-c) | unstable | `HFIJL` |   | @amaanq
[c3](https://github.com/c3lang/tree-sitter-c3) | unstable | `HFIJ ` |   | @cbuttner
[c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) | unstable | `HF JL` |   | @amaanq
[caddy](https://github.com/opa-oz/tree-sitter-caddy) | unmaintained | `HFIJ ` |   | @opa-oz
[cairo](https://github.com/tree-sitter-grammars/tree-sitter-cairo) | unstable | `HFIJL` |   | @amaanq
[capnp](https://github.com/tree-sitter-grammars/tree-sitter-capnp) | unstable | `HFIJL` |   | @amaanq
[chatito](https://github.com/tree-sitter-grammars/tree-sitter-chatito) | unstable | `HFIJL` |   | @ObserverOfTime
[circom](https://github.com/Decurity/tree-sitter-circom) | unstable | `HF JL` |   | @alexandr-martirosyan
[clojure](https://github.com/sogaiu/tree-sitter-clojure) | unstable | `HF JL` |   | @NoahTheDuke
[cmake](https://github.com/uyha/tree-sitter-cmake) | unstable | `HFIJ ` |   | @uyha
[comment](https://github.com/stsewd/tree-sitter-comment) | unstable | `H    ` |   | @stsewd
[commonlisp](https://github.com/tree-sitter-grammars/tree-sitter-commonlisp) | unstable | `HF JL` |   | @theHamsta
[cooklang](https://github.com/addcninblue/tree-sitter-cooklang) | unstable | `H  J ` |   | @addcninblue
[corn](https://github.com/jakestanger/tree-sitter-corn) | unstable | `HFIJL` |   | @jakestanger
[cpon](https://github.com/tree-sitter-grammars/tree-sitter-cpon) | unstable | `HFIJL` |   | @amaanq
[cpp](https://github.com/tree-sitter/tree-sitter-cpp) | unstable | `HFIJL` |   | @theHamsta
[css](https://github.com/tree-sitter/tree-sitter-css) | unstable | `HFIJ ` |   | @TravonteD
[csv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    ` |   | @amaanq
[cuda](https://github.com/tree-sitter-grammars/tree-sitter-cuda) | unstable | `HFIJL` |   | @theHamsta
[cue](https://github.com/eonpatapon/tree-sitter-cue) | unstable | `HFIJL` |   | @amaanq
[cylc](https://github.com/elliotfontaine/tree-sitter-cylc) | unstable | `HFIJ ` |   | @elliotfontaine
[d](https://github.com/gdamore/tree-sitter-d) | unstable | `HFIJL` |   | @amaanq
[dart](https://github.com/UserNobody14/tree-sitter-dart) | unstable | `HFIJL` |   | @akinsho
[desktop](https://github.com/ValdezFOmar/tree-sitter-desktop) | unstable | `HF J ` |   | @ValdezFOmar
[devicetree](https://github.com/joelspadin/tree-sitter-devicetree) | unstable | `HFIJL` |   | @jedrzejboczar
[dhall](https://github.com/jbellerb/tree-sitter-dhall) | unstable | `HF J ` |   | @amaanq
[diff](https://github.com/the-mikedavis/tree-sitter-diff) | unstable | `HF J ` |   | @gbprod
[disassembly](https://github.com/ColinKennedy/tree-sitter-disassembly) | unstable | `H  J ` |   | @ColinKennedy
[djot](https://github.com/treeman/tree-sitter-djot) | unstable | `HFIJL` |   | @NoahTheDuke
[dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) | unstable | `H  J ` |   | @camdencheek
[dot](https://github.com/rydesun/tree-sitter-dot) | unstable | `HFIJ ` |   | @rydesun
[doxygen](https://github.com/tree-sitter-grammars/tree-sitter-doxygen) | unstable | `H IJ ` |   | @amaanq
[dtd](https://github.com/tree-sitter-grammars/tree-sitter-xml) | unstable | `HF JL` |   | @ObserverOfTime
[earthfile](https://github.com/glehmann/tree-sitter-earthfile) | unstable | `H  J ` |   | @glehmann
[ebnf](https://github.com/RubixDev/ebnf) | unstable | `H  J ` |   | @RubixDev
ecma (queries only)[^ecma] | unstable | `HFIJL` |   | @steelsojka
[editorconfig](https://github.com/ValdezFOmar/tree-sitter-editorconfig) | unstable | `HF J ` |   | @ValdezFOmar
[eds](https://github.com/uyha/tree-sitter-eds) | unstable | `HF   ` |   | @uyha
[eex](https://github.com/connorlay/tree-sitter-eex) | unstable | `H  J ` |   | @connorlay
[elixir](https://github.com/elixir-lang/tree-sitter-elixir) | unstable | `HFIJL` |   | @connorlay
[elm](https://github.com/elm-tooling/tree-sitter-elm) | unstable | `HF J ` |   | @zweimach
[elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) | unstable | `HFIJL` |   | @glapa-grossklag, @amaanq
[elvish](https://github.com/elves/tree-sitter-elvish) | unstable | `H  J ` |   | @elves
[embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template) | unstable | `H  J ` |   | 
[enforce](https://github.com/simonvic/tree-sitter-enforce) | unstable | `HFIJL` |   | @simonvic
[erlang](https://github.com/WhatsApp/tree-sitter-erlang) | unstable | `HF J ` |   | @filmor
[facility](https://github.com/FacilityApi/tree-sitter-facility) | unstable | `HFIJ ` |   | @bryankenote
[faust](https://github.com/khiner/tree-sitter-faust) | unstable | `H  J ` |   | @khiner
[fennel](https://github.com/alexmozaidze/tree-sitter-fennel) | unstable | `HF JL` |   | @alexmozaidze
[fidl](https://github.com/google/tree-sitter-fidl) | unstable | `HF J ` |   | @chaopeng
[firrtl](https://github.com/tree-sitter-grammars/tree-sitter-firrtl) | unstable | `HFIJL` |   | @amaanq
[fish](https://github.com/ram02z/tree-sitter-fish) | unstable | `HFIJL` |   | @ram02z
[foam](https://github.com/FoamScience/tree-sitter-foam) | unstable | `HFIJL` |   | @FoamScience
[forth](https://github.com/AlexanderBrevig/tree-sitter-forth) | unstable | `HFIJL` |   | @amaanq
[fortran](https://github.com/stadelmanma/tree-sitter-fortran) | unstable | `HFIJ ` |   | @amaanq
[fsh](https://github.com/mgramigna/tree-sitter-fsh) | unstable | `H  J ` |   | @mgramigna
[fsharp](https://github.com/ionide/tree-sitter-fsharp) | unstable | `H  J ` |   | @nsidorenco
[func](https://github.com/tree-sitter-grammars/tree-sitter-func) | unstable | `H  J ` |   | @amaanq
[fusion](https://gitlab.com/jirgn/tree-sitter-fusion) | unstable | `HFIJL` |   | @jirgn
[gap](https://github.com/gap-system/tree-sitter-gap)[^gap] | unstable | `HF JL` |   | @reiniscirpons
[gaptst](https://github.com/gap-system/tree-sitter-gaptst)[^gaptst] | unstable | `HF J ` |   | @reiniscirpons
[gdscript](https://github.com/PrestonKnopp/tree-sitter-gdscript)[^gdscript] | unstable | `HFIJL` |   | @PrestonKnopp
[gdshader](https://github.com/GodOfAvacyn/tree-sitter-gdshader) | unstable | `H  J ` |   | @godofavacyn
[git_config](https://github.com/the-mikedavis/tree-sitter-git-config) | unstable | `HF J ` |   | @amaanq
[git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) | unstable | `H  J ` |   | @gbprod
[gitattributes](https://github.com/tree-sitter-grammars/tree-sitter-gitattributes) | unstable | `H  JL` |   | @ObserverOfTime
[gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) | unstable | `H  J ` |   | @gbprod
[gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) | unstable | `H  J ` |   | @theHamsta
[gleam](https://github.com/gleam-lang/tree-sitter-gleam) | unstable | `HFIJL` |   | @amaanq
[glimmer](https://github.com/ember-tooling/tree-sitter-glimmer)[^glimmer] | unstable | `HFIJL` |   | @NullVoxPopuli
[glimmer_javascript](https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript) | unstable | `HFIJL` |   | @NullVoxPopuli
[glimmer_typescript](https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript) | unstable | `HFIJ ` |   | @NullVoxPopuli
[glsl](https://github.com/tree-sitter-grammars/tree-sitter-glsl) | unstable | `HFIJL` |   | @theHamsta
[gn](https://github.com/tree-sitter-grammars/tree-sitter-gn) | unstable | `HFIJL` |   | @amaanq
[gnuplot](https://github.com/dpezto/tree-sitter-gnuplot) | unstable | `H  J ` |   | @dpezto
[go](https://github.com/tree-sitter/tree-sitter-go) | unstable | `HFIJL` |   | @theHamsta, @WinWisely268
[goctl](https://github.com/chaozwn/tree-sitter-goctl) | unstable | `HFIJ ` |   | @chaozwn
[godot_resource](https://github.com/PrestonKnopp/tree-sitter-godot-resource)[^godot_resource] | unstable | `HF JL` |   | @pierpo
[gomod](https://github.com/camdencheek/tree-sitter-go-mod) | unstable | `H  J ` |   | @camdencheek
[gosum](https://github.com/tree-sitter-grammars/tree-sitter-go-sum) | unstable | `H    ` |   | @amaanq
[gotmpl](https://github.com/ngalaiko/tree-sitter-go-template) | unstable | `HF JL` |   | @qvalentin
[gowork](https://github.com/omertuc/tree-sitter-go-work) | unstable | `H  J ` |   | @omertuc
[gpg](https://github.com/tree-sitter-grammars/tree-sitter-gpg-config) | unstable | `H  J ` |   | @ObserverOfTime
[graphql](https://github.com/bkegley/tree-sitter-graphql) | unstable | `H IJ ` |   | @bkegley
[gren](https://github.com/MaeBrooks/tree-sitter-gren) | unstable | `H  J ` |   | @MaeBrooks
[groovy](https://github.com/murtaza64/tree-sitter-groovy) | unstable | `HFIJL` |   | @murtaza64
[groq](https://github.com/ajrussellaudio/tree-sitter-groq) | unstable | `HFIJ ` |   | @ajrussellaudio
[gstlaunch](https://github.com/tree-sitter-grammars/tree-sitter-gstlaunch) | unstable | `H    ` |   | @theHamsta
[hack](https://github.com/slackhq/tree-sitter-hack) | unstable | `H  J ` |   | 
[hare](https://github.com/tree-sitter-grammars/tree-sitter-hare) | unstable | `HFIJL` |   | @amaanq
[haskell](https://github.com/tree-sitter/tree-sitter-haskell) | unstable | `HF JL` |   | @mrcjkb
[haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) | unstable | `HF   ` |   | @lykahb
[hcl](https://github.com/tree-sitter-grammars/tree-sitter-hcl) | unstable | `HFIJ ` |   | @MichaHoffmann
[heex](https://github.com/connorlay/tree-sitter-heex) | unstable | `HFIJL` |   | @connorlay
[helm](https://github.com/ngalaiko/tree-sitter-go-template) | unstable | `HF JL` |   | @qvalentin
[hjson](https://github.com/winston0410/tree-sitter-hjson) | unstable | `HFIJL` |   | @winston0410
[hlsl](https://github.com/tree-sitter-grammars/tree-sitter-hlsl) | unstable | `HFIJL` |   | @theHamsta
[hlsplaylist](https://github.com/Freed-Wu/tree-sitter-hlsplaylist) | unstable | `H  J ` |   | @Freed-Wu
[hocon](https://github.com/antosha417/tree-sitter-hocon) | unstable | `HF J ` |   | @antosha417
[hoon](https://github.com/urbit-pilled/tree-sitter-hoon) | unstable | `HF JL` |   | @urbit-pilled
[html](https://github.com/tree-sitter/tree-sitter-html) | unstable | `HFIJL` |   | @TravonteD
html_tags (queries only)[^html_tags] | unstable | `H IJ ` |   | @TravonteD
[htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) | unstable | `HFIJ ` |   | @ObserverOfTime
[http](https://github.com/rest-nvim/tree-sitter-http) | unstable | `HF J ` |   | @amaanq, @NTBBloodbath
[hurl](https://github.com/pfeiferj/tree-sitter-hurl) | unstable | `HFIJ ` |   | @pfeiferj
[hyprlang](https://github.com/tree-sitter-grammars/tree-sitter-hyprlang) | unstable | `HFIJ ` |   | @luckasRanarison
[idl](https://github.com/cathaysia/tree-sitter-idl) | unstable | `H IJ ` |   | @cathaysia
[idris](https://github.com/kayhide/tree-sitter-idris) | unstable | `HF JL` |   | 
[ini](https://github.com/justinmk/tree-sitter-ini) | unstable | `HF J ` |   | @theHamsta
[inko](https://github.com/inko-lang/tree-sitter-inko) | unstable | `HFIJL` |   | @yorickpeterse
[ispc](https://github.com/tree-sitter-grammars/tree-sitter-ispc) | unstable | `HFIJL` |   | @fab4100
[janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) | unstable | `HF JL` |   | @sogaiu
[java](https://github.com/tree-sitter/tree-sitter-java) | unstable | `HFIJL` |   | @p00f
[javadoc](https://github.com/rmuir/tree-sitter-javadoc) | unstable | `H IJ ` |   | @rmuir
[javascript](https://github.com/tree-sitter/tree-sitter-javascript) | unstable | `HFIJL` |   | @steelsojka
[jinja](https://github.com/cathaysia/tree-sitter-jinja)[^jinja] | unstable | `H  J ` |   | @cathaysia
[jinja_inline](https://github.com/cathaysia/tree-sitter-jinja)[^jinja_inline] | unstable | `H  J ` |   | @cathaysia
[jq](https://github.com/flurie/tree-sitter-jq) | unstable | `H  JL` |   | @ObserverOfTime
[jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) | unstable | `H    ` |   | @steelsojka
[json](https://github.com/tree-sitter/tree-sitter-json) | unstable | `HFI L` |   | @steelsojka
[json5](https://github.com/Joakker/tree-sitter-json5) | unstable | `H  J ` |   | @Joakker
[jsonc](https://gitlab.com/WhyNotHugo/tree-sitter-jsonc) | unstable | `HFIJL` |   | @WhyNotHugo
[jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) | unstable | `HF JL` |   | @nawordar
jsx (queries only)[^jsx] | unstable | `HFIJ ` |   | @steelsojka
[julia](https://github.com/tree-sitter/tree-sitter-julia) | unstable | `HFIJL` |   | @fredrikekre
[just](https://github.com/IndianBoy42/tree-sitter-just) | unstable | `HFIJL` |   | @Hubro
[kcl](https://github.com/kcl-lang/tree-sitter-kcl) | unstable | `HF J ` |   | @bertbaron
[kconfig](https://github.com/tree-sitter-grammars/tree-sitter-kconfig) | unstable | `HFIJL` |   | @amaanq
[kdl](https://github.com/tree-sitter-grammars/tree-sitter-kdl) | unstable | `HFIJL` |   | @amaanq
[kotlin](https://github.com/fwcd/tree-sitter-kotlin) | unstable | `HF JL` |   | @SalBakraa
[koto](https://github.com/koto-lang/tree-sitter-koto) | unstable | `HF JL` |   | @irh
[kusto](https://github.com/Willem-J-an/tree-sitter-kusto) | unstable | `H  J ` |   | @Willem-J-an
[lalrpop](https://github.com/traxys/tree-sitter-lalrpop) | unstable | `HF JL` |   | @traxys
[latex](https://github.com/latex-lsp/tree-sitter-latex) | unstable | `HF J ` |   | @theHamsta, @clason
[ledger](https://github.com/cbarrete/tree-sitter-ledger) | unstable | `HFIJ ` |   | @cbarrete
[leo](https://github.com/r001/tree-sitter-leo) | unstable | `H IJ ` |   | @r001
[linkerscript](https://github.com/tree-sitter-grammars/tree-sitter-linkerscript) | unstable | `HFIJL` |   | @amaanq
[liquid](https://github.com/hankthetank27/tree-sitter-liquid) | unstable | `H  J ` |   | @hankthetank27
[liquidsoap](https://github.com/savonet/tree-sitter-liquidsoap) | unstable | `HFIJL` |   | @toots
[llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) | unstable | `H  J ` |   | @benwilliamgraham
[lua](https://github.com/tree-sitter-grammars/tree-sitter-lua) | unstable | `HFIJL` |   | @muniftanjim
[luadoc](https://github.com/tree-sitter-grammars/tree-sitter-luadoc) | unstable | `H    ` |   | @amaanq
[luap](https://github.com/tree-sitter-grammars/tree-sitter-luap)[^luap] | unstable | `H    ` |   | @amaanq
[luau](https://github.com/tree-sitter-grammars/tree-sitter-luau) | unstable | `HFIJL` |   | @amaanq
[m68k](https://github.com/grahambates/tree-sitter-m68k) | unstable | `HF JL` |   | @grahambates
[make](https://github.com/alemuller/tree-sitter-make) | unstable | `HF J ` |   | @lewis6991
[markdown](https://github.com/tree-sitter-grammars/tree-sitter-markdown)[^markdown] | unstable | `HFIJ ` |   | @MDeiml
[markdown_inline](https://github.com/tree-sitter-grammars/tree-sitter-markdown)[^markdown_inline] | unstable | `H  J ` |   | @MDeiml
[matlab](https://github.com/acristoffers/tree-sitter-matlab) | unstable | `HFIJL` |   | @acristoffers
[menhir](https://github.com/Kerl13/tree-sitter-menhir) | unstable | `H  J ` |   | @Kerl13
[mermaid](https://github.com/monaqa/tree-sitter-mermaid) | unstable | `HFIJ ` |   | 
[meson](https://github.com/tree-sitter-grammars/tree-sitter-meson) | unstable | `HFIJ ` |   | @Decodetalkers
[mlir](https://github.com/artagnon/tree-sitter-mlir) | unstable | `H  JL` |   | @artagnon
[muttrc](https://github.com/neomutt/tree-sitter-muttrc) | unstable | `H  J ` |   | @Freed-Wu
[nasm](https://github.com/naclsn/tree-sitter-nasm) | unstable | `H  J ` |   | @ObserverOfTime
[nginx](https://github.com/opa-oz/tree-sitter-nginx) | unstable | `HF J ` |   | @opa-oz
[nickel](https://github.com/nickel-lang/tree-sitter-nickel) | unstable | `H IJ ` |   | 
[nim](https://github.com/alaviss/tree-sitter-nim) | unstable | `HF JL` |   | @aMOPel
[nim_format_string](https://github.com/aMOPel/tree-sitter-nim-format-string) | unstable | `H  J ` |   | @aMOPel
[ninja](https://github.com/alemuller/tree-sitter-ninja) | unstable | `HFIJ ` |   | @alemuller
[nix](https://github.com/nix-community/tree-sitter-nix) | unstable | `HFIJL` |   | @leo60228, @zimbatm
[nqc](https://github.com/tree-sitter-grammars/tree-sitter-nqc) | unstable | `HFIJL` |   | @amaanq
[nu](https://github.com/nushell/tree-sitter-nu) | unstable | `HFIJ ` |   | @abhisheksingh0x558
[objc](https://github.com/tree-sitter-grammars/tree-sitter-objc) | unstable | `HFIJL` |   | @amaanq
[objdump](https://github.com/ColinKennedy/tree-sitter-objdump) | unstable | `H  J ` |   | @ColinKennedy
[ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) | unstable | `HFIJL` |   | @undu
[ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) | unstable | `HFIJL` |   | @undu
[ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) | unstable | `H  J ` |   | @undu
[odin](https://github.com/tree-sitter-grammars/tree-sitter-odin) | unstable | `HFIJL` |   | @amaanq
[pascal](https://github.com/Isopod/tree-sitter-pascal) | unstable | `HFIJL` |   | @Isopod
[passwd](https://github.com/ath3/tree-sitter-passwd) | unstable | `H    ` |   | @amaanq
[pem](https://github.com/tree-sitter-grammars/tree-sitter-pem) | unstable | `HF J ` |   | @ObserverOfTime
[perl](https://github.com/tree-sitter-perl/tree-sitter-perl) | unstable | `HF J ` |   | @RabbiVeesh, @LeoNerd
[php](https://github.com/tree-sitter/tree-sitter-php)[^php] | unstable | `HFIJL` |   | @tk-shirasaka, @calebdw
[php_only](https://github.com/tree-sitter/tree-sitter-php)[^php_only] | unstable | `HFIJL` |   | @tk-shirasaka, @calebdw
[phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) | unstable | `H    ` |   | @mikehaertl
[pioasm](https://github.com/leo60228/tree-sitter-pioasm) | unstable | `H  J ` |   | @leo60228
[pkl](https://github.com/apple/tree-sitter-pkl) | unstable | `HF J ` |   | @ribru17
[po](https://github.com/tree-sitter-grammars/tree-sitter-po) | unstable | `HF J ` |   | @amaanq
[pod](https://github.com/tree-sitter-perl/tree-sitter-pod) | unstable | `H    ` |   | @RabbiVeesh, @LeoNerd
[poe_filter](https://github.com/tree-sitter-grammars/tree-sitter-poe-filter)[^poe_filter] | unstable | `HFIJ ` |   | @ObserverOfTime
[pony](https://github.com/tree-sitter-grammars/tree-sitter-pony) | unstable | `HFIJL` |   | @amaanq, @mfelsche
[powershell](https://github.com/airbus-cert/tree-sitter-powershell) | unstable | `HFIJL` |   | @L2jLiga
[printf](https://github.com/tree-sitter-grammars/tree-sitter-printf) | unstable | `H    ` |   | @ObserverOfTime
[prisma](https://github.com/victorhqc/tree-sitter-prisma) | unstable | `HF J ` |   | @elianiva
[problog](https://github.com/foxyseta/tree-sitter-prolog) | unstable | `HFIJ ` |   | @foxyseta
[prolog](https://github.com/foxyseta/tree-sitter-prolog) | unstable | `HFIJ ` |   | @foxyseta
[promql](https://github.com/MichaHoffmann/tree-sitter-promql) | unstable | `H  J ` |   | @MichaHoffmann
[properties](https://github.com/tree-sitter-grammars/tree-sitter-properties)[^properties] | unstable | `H  JL` |   | @ObserverOfTime
[proto](https://github.com/treywood/tree-sitter-proto) | unstable | `HFIJ ` |   | @treywood
[prql](https://github.com/PRQL/tree-sitter-prql) | unstable | `H  J ` |   | @matthias-Q
[psv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    ` |   | @amaanq
[pug](https://github.com/zealot128/tree-sitter-pug) | unstable | `H  J ` |   | @zealot128
[puppet](https://github.com/tree-sitter-grammars/tree-sitter-puppet) | unstable | `HFIJL` |   | @amaanq
[purescript](https://github.com/postsolar/tree-sitter-purescript) | unstable | `H  JL` |   | @postsolar
[pymanifest](https://github.com/tree-sitter-grammars/tree-sitter-pymanifest) | unstable | `H  J ` |   | @ObserverOfTime
[python](https://github.com/tree-sitter/tree-sitter-python) | unstable | `HFIJL` |   | @stsewd, @theHamsta
[ql](https://github.com/tree-sitter/tree-sitter-ql) | unstable | `HFIJL` |   | @pwntester
[qmldir](https://github.com/tree-sitter-grammars/tree-sitter-qmldir) | unstable | `H  J ` |   | @amaanq
[qmljs](https://github.com/yuja/tree-sitter-qmljs) | unstable | `HF J ` |   | @Decodetalkers
[query](https://github.com/tree-sitter-grammars/tree-sitter-query)[^query] | unstable | `HFIJL` |   | @steelsojka
[r](https://github.com/r-lib/tree-sitter-r) | unstable | `H IJL` |   | @ribru17
[racket](https://github.com/6cdh/tree-sitter-racket) | unstable | `HF J ` |   | 
[ralph](https://github.com/alephium/tree-sitter-ralph) | unstable | `H  J ` |   | @tdroxler
[rasi](https://github.com/Fymyte/tree-sitter-rasi) | unstable | `HFIJL` |   | @Fymyte
[razor](https://github.com/tris203/tree-sitter-razor) | unstable | `HF J ` |   | @tris203
[rbs](https://github.com/joker1007/tree-sitter-rbs) | unstable | `HFIJ ` |   | @joker1007
[re2c](https://github.com/tree-sitter-grammars/tree-sitter-re2c) | unstable | `HFIJL` |   | @amaanq
[readline](https://github.com/tree-sitter-grammars/tree-sitter-readline) | unstable | `HFIJ ` |   | @ribru17
[regex](https://github.com/tree-sitter/tree-sitter-regex) | unstable | `H    ` |   | @theHamsta
[rego](https://github.com/FallenAngel97/tree-sitter-rego) | unstable | `H  J ` |   | @FallenAngel97
[requirements](https://github.com/tree-sitter-grammars/tree-sitter-requirements) | unstable | `H  J ` |   | @ObserverOfTime
[rescript](https://github.com/rescript-lang/tree-sitter-rescript) | unstable | `HFIJL` |   | @ribru17
[rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) | unstable | `HF J ` |   | @bamonroe
[robot](https://github.com/Hubro/tree-sitter-robot) | unstable | `HFIJ ` |   | @Hubro
[robots](https://github.com/opa-oz/tree-sitter-robots-txt) | unstable | `H  J ` |   | @opa-oz
[roc](https://github.com/faldor20/tree-sitter-roc) | unstable | `H IJL` |   | @nat-418
[ron](https://github.com/tree-sitter-grammars/tree-sitter-ron) | unstable | `HFIJL` |   | @amaanq
[rst](https://github.com/stsewd/tree-sitter-rst) | unstable | `H  JL` |   | @stsewd
[ruby](https://github.com/tree-sitter/tree-sitter-ruby) | unstable | `HFIJL` |   | @TravonteD
[runescript](https://github.com/2004Scape/tree-sitter-runescript) | unstable | `H  J ` |   | @2004Scape
[rust](https://github.com/tree-sitter/tree-sitter-rust) | unstable | `HFIJL` |   | @amaanq
[scala](https://github.com/tree-sitter/tree-sitter-scala) | unstable | `HF JL` |   | @stevanmilic
[scfg](https://github.com/rockorager/tree-sitter-scfg) | unstable | `H  J ` | X | @WhyNotHugo
[scheme](https://github.com/6cdh/tree-sitter-scheme) | unstable | `HF J ` |   | 
[scss](https://github.com/serenadeai/tree-sitter-scss) | unstable | `HFIJ ` |   | @elianiva
[sflog](https://github.com/aheber/tree-sitter-sfapex)[^sflog] | unstable | `H    ` |   | @aheber, @xixiaofinland
[slang](https://github.com/tree-sitter-grammars/tree-sitter-slang)[^slang] | unstable | `HFIJL` |   | @theHamsta
[slim](https://github.com/theoo/tree-sitter-slim) | unstable | `HFIJL` |   | @theoo
[slint](https://github.com/slint-ui/tree-sitter-slint) | unstable | `HFIJL` |   | @hunger
[smali](https://github.com/tree-sitter-grammars/tree-sitter-smali) | unstable | `HFIJL` |   | @amaanq
[smithy](https://github.com/indoorvivants/tree-sitter-smithy) | unstable | `H  J ` |   | @amaanq, @keynmol
[snakemake](https://github.com/osthomas/tree-sitter-snakemake) | unstable | `HFIJL` |   | @osthomas
[solidity](https://github.com/JoranHonig/tree-sitter-solidity) | unstable | `HF J ` |   | @amaanq
[soql](https://github.com/aheber/tree-sitter-sfapex) | unstable | `H    ` |   | @aheber, @xixiafinland
[sosl](https://github.com/aheber/tree-sitter-sfapex) | unstable | `H    ` |   | @aheber, @xixiafinland
[sourcepawn](https://github.com/nilshelmig/tree-sitter-sourcepawn) | unstable | `H  JL` |   | @Sarrus1
[sparql](https://github.com/GordianDziwis/tree-sitter-sparql) | unstable | `HFIJL` |   | @GordianDziwis
[sproto](https://github.com/hanxi/tree-sitter-sproto) | unstable | `HFIJ ` |   | @hanxi
[sql](https://github.com/derekstride/tree-sitter-sql) | unstable | `HFIJ ` |   | @derekstride
[squirrel](https://github.com/tree-sitter-grammars/tree-sitter-squirrel) | unstable | `HFIJL` |   | @amaanq
[ssh_config](https://github.com/tree-sitter-grammars/tree-sitter-ssh-config) | unstable | `HFIJL` |   | @ObserverOfTime
[starlark](https://github.com/tree-sitter-grammars/tree-sitter-starlark) | unstable | `HFIJL` |   | @amaanq
[strace](https://github.com/sigmaSd/tree-sitter-strace) | unstable | `H  J ` |   | @amaanq
[styled](https://github.com/mskelton/tree-sitter-styled) | unstable | `HFIJ ` |   | @mskelton
[supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) | unstable | `HFIJL` |   | @madskjeldgaard
[superhtml](https://github.com/kristoff-it/superhtml) | unstable | `H  J ` |   | @rockorager
[surface](https://github.com/connorlay/tree-sitter-surface) | unstable | `HFIJ ` |   | @connorlay
[svelte](https://github.com/tree-sitter-grammars/tree-sitter-svelte) | unstable | `HFIJL` |   | @amaanq
[sway](https://github.com/FuelLabs/tree-sitter-sway.git) | unstable | `HFIJL` |   | @ribru17
[swift](https://github.com/alex-pinkus/tree-sitter-swift) | unstable | `HFIJL` |   | @alex-pinkus
[sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) | unstable | `HF J ` |   | @RaafatTurki
[systemtap](https://github.com/ok-ryoko/tree-sitter-systemtap) | unstable | `HF JL` |   | @ok-ryoko
[systemverilog](https://github.com/gmlarumbe/tree-sitter-systemverilog) | unstable | `HF J ` |   | @zhangwwpeng
[t32](https://gitlab.com/xasc/tree-sitter-t32) | unstable | `HFIJL` |   | @xasc
[tablegen](https://github.com/tree-sitter-grammars/tree-sitter-tablegen) | unstable | `HFIJL` |   | @amaanq
[tact](https://github.com/tact-lang/tree-sitter-tact) | unstable | `HFIJL` |   | @novusnota
[tcl](https://github.com/tree-sitter-grammars/tree-sitter-tcl) | unstable | `HFIJ ` |   | @lewis6991
[teal](https://github.com/euclidianAce/tree-sitter-teal) | unstable | `HFIJL` |   | @euclidianAce
[templ](https://github.com/vrischmann/tree-sitter-templ) | unstable | `HF J ` |   | @vrischmann
[tera](https://github.com/uncenter/tree-sitter-tera) | unstable | `H  J ` |   | @uncenter
[terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) | unstable | `HFIJ ` |   | @MichaHoffmann
[textproto](https://github.com/PorterAtGoogle/tree-sitter-textproto) | unstable | `HFIJ ` |   | @Porter
[thrift](https://github.com/tree-sitter-grammars/tree-sitter-thrift) | unstable | `HFIJL` |   | @amaanq, @duskmoon314
[tiger](https://github.com/ambroisie/tree-sitter-tiger) | unstable | `HFIJL` |   | @ambroisie
[tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) | unstable | `HF JL` |   | @ahelwer, @susliko
[tmux](https://github.com/Freed-Wu/tree-sitter-tmux) | unstable | `H  J ` |   | @Freed-Wu
[todotxt](https://github.com/arnarg/tree-sitter-todotxt) | unstable | `H    ` |   | @arnarg
[toml](https://github.com/tree-sitter-grammars/tree-sitter-toml) | unstable | `HFIJL` |   | @tk-shirasaka
[tsv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    ` |   | @amaanq
[tsx](https://github.com/tree-sitter/tree-sitter-typescript) | unstable | `HFIJL` |   | @steelsojka
[turtle](https://github.com/GordianDziwis/tree-sitter-turtle) | unstable | `HFIJL` |   | @GordianDziwis
[twig](https://github.com/gbprod/tree-sitter-twig) | unstable | `H  J ` |   | @gbprod
[typescript](https://github.com/tree-sitter/tree-sitter-typescript) | unstable | `HFIJL` |   | @steelsojka
[typespec](https://github.com/happenslol/tree-sitter-typespec) | unstable | `H IJ ` |   | @happenslol
[typoscript](https://github.com/Teddytrombone/tree-sitter-typoscript) | unstable | `HFIJ ` |   | @Teddytrombone
[typst](https://github.com/uben0/tree-sitter-typst) | unstable | `HFIJ ` |   | @uben0, @RaafatTurki
[udev](https://github.com/tree-sitter-grammars/tree-sitter-udev) | unstable | `H  JL` |   | @ObserverOfTime
[ungrammar](https://github.com/tree-sitter-grammars/tree-sitter-ungrammar) | unstable | `HFIJL` |   | @Philipp-M, @amaanq
[unison](https://github.com/kylegoetz/tree-sitter-unison) | unstable | `HF J ` |   | @tapegram
[usd](https://github.com/ColinKennedy/tree-sitter-usd) | unstable | `HFIJL` |   | @ColinKennedy
[uxntal](https://github.com/tree-sitter-grammars/tree-sitter-uxntal) | unstable | `HFIJL` |   | @amaanq
[v](https://github.com/vlang/v-analyzer) | unstable | `HFIJL` |   | @kkharji, @amaanq
[vala](https://github.com/vala-lang/tree-sitter-vala) | unstable | `HF J ` |   | @Prince781
[vento](https://github.com/ventojs/tree-sitter-vento) | unstable | `H  J ` |   | @wrapperup, @oscarotero
[vhdl](https://github.com/jpt13653903/tree-sitter-vhdl) | unstable | `HF J ` |   | @jpt13653903
[vhs](https://github.com/charmbracelet/tree-sitter-vhs) | unstable | `H  J ` |   | @caarlos0
[vim](https://github.com/tree-sitter-grammars/tree-sitter-vim) | unstable | `HF JL` |   | @clason
[vimdoc](https://github.com/neovim/tree-sitter-vimdoc) | unstable | `H  J ` |   | @clason
[vrl](https://github.com/belltoy/tree-sitter-vrl) | unstable | `HFIJL` |   | @belltoy
[vue](https://github.com/tree-sitter-grammars/tree-sitter-vue) | unstable | `HFIJ ` |   | @WhyNotHugo, @lucario387
[wgsl](https://github.com/szebniok/tree-sitter-wgsl) | unstable | `HFIJ ` |   | @szebniok
[wgsl_bevy](https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy) | unstable | `HFI  ` |   | @theHamsta
[wing](https://github.com/winglang/tree-sitter-wing) | unstable | `HF JL` |   | @gshpychka, @MarkMcCulloh
[wit](https://github.com/bytecodealliance/tree-sitter-wit) | unstable | `HF J ` |   | @mkatychev
[xcompose](https://github.com/tree-sitter-grammars/tree-sitter-xcompose) | unstable | `H  JL` |   | @ObserverOfTime
[xml](https://github.com/tree-sitter-grammars/tree-sitter-xml) | unstable | `HFIJL` |   | @ObserverOfTime
[xresources](https://github.com/ValdezFOmar/tree-sitter-xresources) | unstable | `HF JL` |   | @ValdezFOmar
[yaml](https://github.com/tree-sitter-grammars/tree-sitter-yaml) | unstable | `HFIJL` |   | @amaanq
[yang](https://github.com/Hubro/tree-sitter-yang) | unstable | `HFIJ ` |   | @Hubro
[yuck](https://github.com/tree-sitter-grammars/tree-sitter-yuck) | unstable | `HFIJL` |   | @Philipp-M, @amaanq
[zathurarc](https://github.com/Freed-Wu/tree-sitter-zathurarc) | unstable | `H  J ` |   | @Freed-Wu
[zig](https://github.com/tree-sitter-grammars/tree-sitter-zig) | unstable | `HFIJL` |   | @amaanq
[ziggy](https://github.com/kristoff-it/ziggy) | unstable | `H I  ` |   | @rockorager
[ziggy_schema](https://github.com/kristoff-it/ziggy) | unstable | `H I  ` |   | @rockorager
[^bp]: Android Blueprint
[^ecma]: queries required by javascript, typescript, tsx, qmljs
[^gap]: GAP system
[^gaptst]: GAP system test files
[^gdscript]: Godot
[^glimmer]: Glimmer and Ember
[^godot_resource]: Godot Resources
[^html_tags]: queries required by html, astro, vue, svelte
[^jinja]: basic highlighting
[^jinja_inline]: needed for full highlighting
[^jsx]: queries required by javascript, tsx
[^luap]: Lua patterns
[^markdown]: basic highlighting
[^markdown_inline]: needed for full highlighting
[^php]: PHP with embedded HTML
[^php_only]: PHP without embedded HTML
[^poe_filter]: Path of Exile item filter
[^properties]: Java properties files
[^query]: Tree-sitter query language
[^sflog]: Salesforce debug log
[^slang]: Shader Slang
<!--parserinfo-->
