# Supported languages

The following is a list of languages for which a parser can be installed through `:TSInstall`.

Legend:
- **Tier:** _stable_ (updates follow semver releases), _unstable_ (updates follow HEAD), _unmaintained_ (no automatic updates), or _unsupported_ (known to be broken, cannot be installed)
- **Queries** available for **H**ighlights, **F**olds, **I**ndents, In**J**ections, **L**ocals

<!--This section of the README is automatically updated by a CI job-->
<!--parserinfo-->
Language | Tier | Queries
-------- |:----:|:-------:
[ada](https://github.com/briot/tree-sitter-ada) | unstable | `HF JL`
[agda](https://github.com/tree-sitter/tree-sitter-agda) | unstable | `HF J `
[angular](https://github.com/dlvandenberg/tree-sitter-angular) | unstable | `HFIJL`
[apex](https://github.com/aheber/tree-sitter-sfapex) | unstable | `HF JL`
[arduino](https://github.com/tree-sitter-grammars/tree-sitter-arduino) | unstable | `HFIJL`
[asm](https://github.com/RubixDev/tree-sitter-asm) | unstable | `H  J `
[astro](https://github.com/virchau13/tree-sitter-astro) | unstable | `HFIJL`
[authzed](https://github.com/mleonidas/tree-sitter-authzed) | unstable | `H  J `
[awk](https://github.com/Beaglefoot/tree-sitter-awk) | unstable | `H  J `
[bash](https://github.com/tree-sitter/tree-sitter-bash) | unstable | `HFIJL`
[bass](https://github.com/vito/tree-sitter-bass) | unstable | `HFIJL`
[beancount](https://github.com/polarmutex/tree-sitter-beancount) | unstable | `HF J `
[bibtex](https://github.com/latex-lsp/tree-sitter-bibtex) | unstable | `HFIJ `
[bicep](https://github.com/tree-sitter-grammars/tree-sitter-bicep) | unstable | `HFIJL`
[bitbake](https://github.com/tree-sitter-grammars/tree-sitter-bitbake) | unstable | `HFIJL`
[blade](https://github.com/EmranMR/tree-sitter-blade) | unstable | `HFIJ `
[bp](https://github.com/ambroisie/tree-sitter-bp)[^bp] | unstable | `HFIJL`
[bpftrace](https://github.com/sgruszka/tree-sitter-bpftrace) | unstable | `H  J `
[brightscript](https://github.com/ajdelcimmuto/tree-sitter-brightscript) | unstable | `HFIJ `
[c](https://github.com/tree-sitter/tree-sitter-c) | unstable | `HFIJL`
[c3](https://github.com/c3lang/tree-sitter-c3) | unstable | `HFIJ `
[c_sharp](https://github.com/tree-sitter/tree-sitter-c-sharp) | stable | `HF JL`
[caddy](https://github.com/opa-oz/tree-sitter-caddy) | unmaintained | `HFIJ `
[cairo](https://github.com/tree-sitter-grammars/tree-sitter-cairo) | unstable | `HFIJL`
[capnp](https://github.com/tree-sitter-grammars/tree-sitter-capnp) | unstable | `HFIJL`
[chatito](https://github.com/tree-sitter-grammars/tree-sitter-chatito) | unstable | `HFIJL`
[circom](https://github.com/Decurity/tree-sitter-circom) | unstable | `HF JL`
[clojure](https://github.com/sogaiu/tree-sitter-clojure) | unstable | `HF JL`
[cmake](https://github.com/uyha/tree-sitter-cmake) | unstable | `HFIJ `
[comment](https://github.com/stsewd/tree-sitter-comment) | unstable | `H    `
[commonlisp](https://github.com/tree-sitter-grammars/tree-sitter-commonlisp) | unstable | `HF JL`
[cooklang](https://github.com/addcninblue/tree-sitter-cooklang) | unstable | `H  J `
[corn](https://github.com/jakestanger/tree-sitter-corn) | unstable | `HFIJL`
[cpon](https://github.com/tree-sitter-grammars/tree-sitter-cpon) | unstable | `HFIJL`
[cpp](https://github.com/tree-sitter/tree-sitter-cpp) | unstable | `HFIJL`
[css](https://github.com/tree-sitter/tree-sitter-css) | unstable | `HFIJ `
[csv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    `
[cuda](https://github.com/tree-sitter-grammars/tree-sitter-cuda) | unstable | `HFIJL`
[cue](https://github.com/eonpatapon/tree-sitter-cue) | unstable | `HFIJL`
[cylc](https://github.com/elliotfontaine/tree-sitter-cylc) | unstable | `HFIJ `
[d](https://github.com/gdamore/tree-sitter-d) | unstable | `HFIJL`
[dart](https://github.com/UserNobody14/tree-sitter-dart) | unstable | `HFIJL`
[desktop](https://github.com/ValdezFOmar/tree-sitter-desktop) | stable | `HF J `
[devicetree](https://github.com/joelspadin/tree-sitter-devicetree) | unstable | `HFIJL`
[dhall](https://github.com/jbellerb/tree-sitter-dhall) | unstable | `HF J `
[diff](https://github.com/tree-sitter-grammars/tree-sitter-diff) | unstable | `HF J `
[disassembly](https://github.com/ColinKennedy/tree-sitter-disassembly) | unstable | `H  J `
[djot](https://github.com/treeman/tree-sitter-djot) | unmaintained | `HFIJL`
[dockerfile](https://github.com/camdencheek/tree-sitter-dockerfile) | unstable | `H  J `
[dot](https://github.com/rydesun/tree-sitter-dot) | unstable | `HFIJ `
[doxygen](https://github.com/tree-sitter-grammars/tree-sitter-doxygen) | unstable | `H IJ `
[dtd](https://github.com/tree-sitter-grammars/tree-sitter-xml) | unstable | `HF JL`
[earthfile](https://github.com/glehmann/tree-sitter-earthfile) | unstable | `H  J `
[ebnf](https://github.com/RubixDev/ebnf) | unstable | `H  J `
ecma (queries only)[^ecma] | unstable | `HFIJL`
[editorconfig](https://github.com/ValdezFOmar/tree-sitter-editorconfig) | stable | `HF J `
[eds](https://github.com/uyha/tree-sitter-eds) | unstable | `HF   `
[eex](https://github.com/connorlay/tree-sitter-eex) | unstable | `H  J `
[elixir](https://github.com/elixir-lang/tree-sitter-elixir) | unstable | `HFIJL`
[elm](https://github.com/elm-tooling/tree-sitter-elm) | unstable | `HF J `
[elsa](https://github.com/glapa-grossklag/tree-sitter-elsa) | unstable | `HFIJL`
[elvish](https://github.com/elves/tree-sitter-elvish) | unstable | `H  J `
[embedded_template](https://github.com/tree-sitter/tree-sitter-embedded-template) | unstable | `H  J `
[enforce](https://github.com/simonvic/tree-sitter-enforce) | unstable | `HFIJL`
[erlang](https://github.com/WhatsApp/tree-sitter-erlang) | unstable | `HF J `
[facility](https://github.com/FacilityApi/tree-sitter-facility) | unstable | `HFIJ `
[faust](https://github.com/khiner/tree-sitter-faust) | unstable | `H  J `
[fennel](https://github.com/alexmozaidze/tree-sitter-fennel) | unstable | `HF JL`
[fidl](https://github.com/google/tree-sitter-fidl) | unstable | `HF J `
[firrtl](https://github.com/tree-sitter-grammars/tree-sitter-firrtl) | unstable | `HFIJL`
[fish](https://github.com/ram02z/tree-sitter-fish) | unstable | `HFIJL`
[foam](https://github.com/FoamScience/tree-sitter-foam) | unstable | `HFIJL`
[forth](https://github.com/AlexanderBrevig/tree-sitter-forth) | unstable | `HFIJL`
[fortran](https://github.com/stadelmanma/tree-sitter-fortran) | unstable | `HFIJ `
[fsh](https://github.com/mgramigna/tree-sitter-fsh) | unstable | `H  J `
[fsharp](https://github.com/ionide/tree-sitter-fsharp) | unstable | `H  J `
[func](https://github.com/tree-sitter-grammars/tree-sitter-func) | unstable | `H  J `
[gap](https://github.com/gap-system/tree-sitter-gap)[^gap] | unstable | `HF JL`
[gaptst](https://github.com/gap-system/tree-sitter-gaptst)[^gaptst] | unstable | `HF J `
[gdscript](https://github.com/PrestonKnopp/tree-sitter-gdscript)[^gdscript] | unmaintained | `HFIJL`
[gdshader](https://github.com/airblast-dev/tree-sitter-gdshader) | unstable | `H  J `
[git_config](https://github.com/the-mikedavis/tree-sitter-git-config) | unstable | `HF J `
[git_rebase](https://github.com/the-mikedavis/tree-sitter-git-rebase) | unstable | `H  J `
[gitattributes](https://github.com/tree-sitter-grammars/tree-sitter-gitattributes) | unstable | `H  JL`
[gitcommit](https://github.com/gbprod/tree-sitter-gitcommit) | unstable | `H  J `
[gitignore](https://github.com/shunsambongi/tree-sitter-gitignore) | unstable | `H  J `
[gleam](https://github.com/gleam-lang/tree-sitter-gleam) | unstable | `HFIJL`
[glimmer](https://github.com/ember-tooling/tree-sitter-glimmer)[^glimmer] | unstable | `HFIJL`
[glimmer_javascript](https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript) | unstable | `HFIJL`
[glimmer_typescript](https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript) | unstable | `HFIJ `
[glsl](https://github.com/tree-sitter-grammars/tree-sitter-glsl) | unstable | `HFIJL`
[gn](https://github.com/tree-sitter-grammars/tree-sitter-gn) | unstable | `HFIJL`
[gnuplot](https://github.com/dpezto/tree-sitter-gnuplot) | stable | `HF J `
[go](https://github.com/tree-sitter/tree-sitter-go) | unstable | `HFIJL`
[goctl](https://github.com/chaozwn/tree-sitter-goctl) | unstable | `HFIJ `
[godot_resource](https://github.com/PrestonKnopp/tree-sitter-godot-resource)[^godot_resource] | unstable | `HF JL`
[gomod](https://github.com/camdencheek/tree-sitter-go-mod) | unstable | `H  J `
[gosum](https://github.com/tree-sitter-grammars/tree-sitter-go-sum) | unstable | `H    `
[gotmpl](https://github.com/ngalaiko/tree-sitter-go-template) | unstable | `HF JL`
[gowork](https://github.com/omertuc/tree-sitter-go-work) | unstable | `H  J `
[gpg](https://github.com/tree-sitter-grammars/tree-sitter-gpg-config) | unstable | `H  J `
[graphql](https://github.com/bkegley/tree-sitter-graphql) | unstable | `H IJ `
[gren](https://github.com/MaeBrooks/tree-sitter-gren) | unstable | `H  J `
[groovy](https://github.com/murtaza64/tree-sitter-groovy) | unstable | `HFIJL`
[groq](https://github.com/ajrussellaudio/tree-sitter-groq) | unstable | `HFIJ `
[gstlaunch](https://github.com/tree-sitter-grammars/tree-sitter-gstlaunch) | unstable | `H    `
[hack](https://github.com/slackhq/tree-sitter-hack) | unstable | `H  J `
[hare](https://github.com/tree-sitter-grammars/tree-sitter-hare) | unstable | `HFIJL`
[haskell](https://github.com/tree-sitter-grammars/tree-sitter-haskell) | unstable | `HF JL`
[haskell_persistent](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) | unstable | `HF   `
[hcl](https://github.com/tree-sitter-grammars/tree-sitter-hcl) | unstable | `HFIJ `
[heex](https://github.com/connorlay/tree-sitter-heex) | unstable | `HFIJL`
[helm](https://github.com/ngalaiko/tree-sitter-go-template) | unstable | `HF JL`
[hjson](https://github.com/winston0410/tree-sitter-hjson) | unstable | `HFIJL`
[hlsl](https://github.com/tree-sitter-grammars/tree-sitter-hlsl) | unstable | `HFIJL`
[hocon](https://github.com/antosha417/tree-sitter-hocon) | unstable | `HF J `
[hoon](https://github.com/urbit-pilled/tree-sitter-hoon) | unstable | `HF JL`
[html](https://github.com/tree-sitter/tree-sitter-html) | unstable | `HFIJL`
html_tags (queries only)[^html_tags] | unstable | `H IJ `
[htmldjango](https://github.com/interdependence/tree-sitter-htmldjango) | unstable | `HFIJ `
[http](https://github.com/rest-nvim/tree-sitter-http) | unstable | `HF J `
[hurl](https://github.com/pfeiferj/tree-sitter-hurl) | unstable | `HFIJ `
[hyprlang](https://github.com/tree-sitter-grammars/tree-sitter-hyprlang) | unstable | `HFIJ `
[idl](https://github.com/cathaysia/tree-sitter-idl) | unstable | `H IJ `
[idris](https://github.com/kayhide/tree-sitter-idris) | unstable | `HF JL`
[ini](https://github.com/justinmk/tree-sitter-ini) | unstable | `HF J `
[inko](https://github.com/inko-lang/tree-sitter-inko) | stable | `HFIJL`
[ispc](https://github.com/tree-sitter-grammars/tree-sitter-ispc) | unstable | `HFIJL`
[janet_simple](https://github.com/sogaiu/tree-sitter-janet-simple) | unstable | `HF JL`
[java](https://github.com/tree-sitter/tree-sitter-java) | unstable | `HFIJL`
[javadoc](https://github.com/rmuir/tree-sitter-javadoc) | unstable | `H IJ `
[javascript](https://github.com/tree-sitter/tree-sitter-javascript) | unstable | `HFIJL`
[jinja](https://github.com/cathaysia/tree-sitter-jinja)[^jinja] | unstable | `H  J `
[jinja_inline](https://github.com/cathaysia/tree-sitter-jinja)[^jinja_inline] | unstable | `H  J `
[jjdescription](https://github.com/ribru17/tree-sitter-jjdescription) | stable | `H  J `
[jq](https://github.com/flurie/tree-sitter-jq) | unstable | `H  JL`
[jsdoc](https://github.com/tree-sitter/tree-sitter-jsdoc) | unstable | `H    `
[json](https://github.com/tree-sitter/tree-sitter-json) | unstable | `HFIJL`
[json5](https://github.com/Joakker/tree-sitter-json5) | unstable | `H  J `
[jsonnet](https://github.com/sourcegraph/tree-sitter-jsonnet) | unstable | `HF JL`
jsx (queries only)[^jsx] | unstable | `HFIJ `
[julia](https://github.com/tree-sitter-grammars/tree-sitter-julia) | unstable | `HFIJL`
[just](https://github.com/IndianBoy42/tree-sitter-just) | unstable | `HFIJL`
[kcl](https://github.com/kcl-lang/tree-sitter-kcl) | unstable | `HF J `
[kconfig](https://github.com/tree-sitter-grammars/tree-sitter-kconfig) | unstable | `HFIJL`
[kdl](https://github.com/tree-sitter-grammars/tree-sitter-kdl) | unstable | `HFIJL`
[kitty](https://github.com/OXY2DEV/tree-sitter-kitty) | unstable | `H  J `
[kos](https://github.com/kos-lang/tree-sitter-kos) | unstable | `HF JL`
[kotlin](https://github.com/fwcd/tree-sitter-kotlin) | unstable | `HF JL`
[koto](https://github.com/koto-lang/tree-sitter-koto) | unstable | `HF JL`
[kusto](https://github.com/Willem-J-an/tree-sitter-kusto) | unstable | `H  J `
[lalrpop](https://github.com/traxys/tree-sitter-lalrpop) | unstable | `HF JL`
[latex](https://github.com/latex-lsp/tree-sitter-latex) | unstable | `HF J `
[ledger](https://github.com/cbarrete/tree-sitter-ledger) | unstable | `HFIJ `
[leo](https://github.com/r001/tree-sitter-leo) | unstable | `H IJ `
[linkerscript](https://github.com/tree-sitter-grammars/tree-sitter-linkerscript) | unstable | `HFIJL`
[liquid](https://github.com/hankthetank27/tree-sitter-liquid) | unstable | `H  J `
[liquidsoap](https://github.com/savonet/tree-sitter-liquidsoap) | unstable | `HFIJL`
[llvm](https://github.com/benwilliamgraham/tree-sitter-llvm) | unstable | `H  J `
[lua](https://github.com/tree-sitter-grammars/tree-sitter-lua) | unstable | `HFIJL`
[luadoc](https://github.com/tree-sitter-grammars/tree-sitter-luadoc) | unstable | `H    `
[luap](https://github.com/tree-sitter-grammars/tree-sitter-luap)[^luap] | unstable | `H    `
[luau](https://github.com/tree-sitter-grammars/tree-sitter-luau) | unstable | `HFIJL`
[m68k](https://github.com/grahambates/tree-sitter-m68k) | unstable | `HF JL`
[make](https://github.com/tree-sitter-grammars/tree-sitter-make) | unstable | `HF J `
[markdown](https://github.com/tree-sitter-grammars/tree-sitter-markdown)[^markdown] | unstable | `HFIJ `
[markdown_inline](https://github.com/tree-sitter-grammars/tree-sitter-markdown)[^markdown_inline] | unstable | `H  J `
[matlab](https://github.com/acristoffers/tree-sitter-matlab) | unstable | `HFIJL`
[menhir](https://github.com/Kerl13/tree-sitter-menhir) | unstable | `H  J `
[mermaid](https://github.com/monaqa/tree-sitter-mermaid) | unstable | `HFIJ `
[meson](https://github.com/tree-sitter-grammars/tree-sitter-meson) | unstable | `HFIJ `
[mlir](https://github.com/artagnon/tree-sitter-mlir) | unstable | `H  JL`
[nasm](https://github.com/naclsn/tree-sitter-nasm) | unstable | `H  J `
[nginx](https://github.com/opa-oz/tree-sitter-nginx) | unstable | `HF J `
[nickel](https://github.com/nickel-lang/tree-sitter-nickel) | unstable | `H IJ `
[nim](https://github.com/alaviss/tree-sitter-nim) | unstable | `HF JL`
[nim_format_string](https://github.com/aMOPel/tree-sitter-nim-format-string) | unstable | `H  J `
[ninja](https://github.com/alemuller/tree-sitter-ninja) | unstable | `HFIJ `
[nix](https://github.com/nix-community/tree-sitter-nix) | unstable | `HFIJL`
[nqc](https://github.com/tree-sitter-grammars/tree-sitter-nqc) | unstable | `HFIJL`
[nu](https://github.com/nushell/tree-sitter-nu) | unstable | `HFIJ `
[objc](https://github.com/tree-sitter-grammars/tree-sitter-objc) | unstable | `HFIJL`
[objdump](https://github.com/ColinKennedy/tree-sitter-objdump) | unstable | `H  J `
[ocaml](https://github.com/tree-sitter/tree-sitter-ocaml) | unstable | `HFIJL`
[ocaml_interface](https://github.com/tree-sitter/tree-sitter-ocaml) | unstable | `HFIJL`
[ocamllex](https://github.com/atom-ocaml/tree-sitter-ocamllex) | unstable | `H  J `
[odin](https://github.com/tree-sitter-grammars/tree-sitter-odin) | unstable | `HFIJL`
[pascal](https://github.com/Isopod/tree-sitter-pascal) | unstable | `HFIJL`
[passwd](https://github.com/ath3/tree-sitter-passwd) | unstable | `H    `
[pem](https://github.com/tree-sitter-grammars/tree-sitter-pem) | unstable | `HF J `
[perl](https://github.com/tree-sitter-perl/tree-sitter-perl) | unstable | `HF J `
[php](https://github.com/tree-sitter/tree-sitter-php)[^php] | unstable | `HFIJL`
[php_only](https://github.com/tree-sitter/tree-sitter-php)[^php_only] | unstable | `HFIJL`
[phpdoc](https://github.com/claytonrcarter/tree-sitter-phpdoc) | unstable | `H    `
[pioasm](https://github.com/leo60228/tree-sitter-pioasm) | unstable | `H  J `
[pkl](https://github.com/apple/tree-sitter-pkl) | unstable | `HF J `
[po](https://github.com/tree-sitter-grammars/tree-sitter-po) | unstable | `HF J `
[pod](https://github.com/tree-sitter-perl/tree-sitter-pod) | unstable | `H    `
[poe_filter](https://github.com/tree-sitter-grammars/tree-sitter-poe-filter)[^poe_filter] | unstable | `HFIJ `
[pony](https://github.com/tree-sitter-grammars/tree-sitter-pony) | unstable | `HFIJL`
[powershell](https://github.com/airbus-cert/tree-sitter-powershell) | unstable | `HFIJL`
[printf](https://github.com/tree-sitter-grammars/tree-sitter-printf) | unstable | `H    `
[prisma](https://github.com/victorhqc/tree-sitter-prisma) | unstable | `HF J `
[promql](https://github.com/MichaHoffmann/tree-sitter-promql) | unstable | `H  J `
[properties](https://github.com/tree-sitter-grammars/tree-sitter-properties)[^properties] | unstable | `H  JL`
[proto](https://github.com/coder3101/tree-sitter-proto) | unstable | `HFIJ `
[prql](https://github.com/PRQL/tree-sitter-prql) | unstable | `H  J `
[psv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    `
[pug](https://github.com/zealot128/tree-sitter-pug) | unstable | `H  J `
[puppet](https://github.com/tree-sitter-grammars/tree-sitter-puppet) | unstable | `HFIJL`
[purescript](https://github.com/postsolar/tree-sitter-purescript) | unstable | `H  JL`
[pymanifest](https://github.com/tree-sitter-grammars/tree-sitter-pymanifest) | unstable | `H  J `
[python](https://github.com/tree-sitter/tree-sitter-python) | stable | `HFIJL`
[ql](https://github.com/tree-sitter/tree-sitter-ql) | unstable | `HFIJL`
[qmldir](https://github.com/tree-sitter-grammars/tree-sitter-qmldir) | unstable | `H  J `
[qmljs](https://github.com/yuja/tree-sitter-qmljs) | unstable | `HF J `
[query](https://github.com/tree-sitter-grammars/tree-sitter-query)[^query] | unstable | `HFIJL`
[r](https://github.com/r-lib/tree-sitter-r) | unstable | `H IJL`
[racket](https://github.com/6cdh/tree-sitter-racket) | unstable | `HF J `
[ralph](https://github.com/alephium/tree-sitter-ralph) | unstable | `H  J `
[rasi](https://github.com/Fymyte/tree-sitter-rasi) | unstable | `HFIJL`
[razor](https://github.com/tris203/tree-sitter-razor) | unstable | `HF J `
[rbs](https://github.com/joker1007/tree-sitter-rbs) | unstable | `HFIJ `
[re2c](https://github.com/tree-sitter-grammars/tree-sitter-re2c) | unstable | `HFIJL`
[readline](https://github.com/tree-sitter-grammars/tree-sitter-readline) | unstable | `HFIJ `
[regex](https://github.com/tree-sitter/tree-sitter-regex) | unstable | `H    `
[rego](https://github.com/FallenAngel97/tree-sitter-rego) | unstable | `H  J `
[requirements](https://github.com/tree-sitter-grammars/tree-sitter-requirements) | unstable | `H  J `
[rescript](https://github.com/rescript-lang/tree-sitter-rescript) | unstable | `HFIJL`
[rifleconf](https://github.com/purarue/tree-sitter-rifleconf) | unstable | `H  J `
[rnoweb](https://github.com/bamonroe/tree-sitter-rnoweb) | unstable | `HF J `
[robot](https://github.com/Hubro/tree-sitter-robot) | unmaintained | `HFIJ `
[robots_txt](https://github.com/opa-oz/tree-sitter-robots-txt) | unstable | `H  J `
[roc](https://github.com/faldor20/tree-sitter-roc) | unmaintained | `H IJL`
[ron](https://github.com/tree-sitter-grammars/tree-sitter-ron) | unstable | `HFIJL`
[rst](https://github.com/stsewd/tree-sitter-rst) | unstable | `H  JL`
[ruby](https://github.com/tree-sitter/tree-sitter-ruby) | unstable | `HFIJL`
[runescript](https://github.com/2004Scape/tree-sitter-runescript) | unstable | `H  J `
[rust](https://github.com/tree-sitter/tree-sitter-rust) | unstable | `HFIJL`
[scala](https://github.com/tree-sitter/tree-sitter-scala) | unstable | `HFIJL`
[scfg](https://github.com/rockorager/tree-sitter-scfg) | unstable | `H  J `
[scheme](https://github.com/6cdh/tree-sitter-scheme) | unstable | `HF J `
[scss](https://github.com/serenadeai/tree-sitter-scss) | unstable | `HFIJ `
[sflog](https://github.com/aheber/tree-sitter-sfapex)[^sflog] | unstable | `H    `
[slang](https://github.com/tree-sitter-grammars/tree-sitter-slang)[^slang] | unstable | `HFIJL`
[slim](https://github.com/theoo/tree-sitter-slim) | unstable | `HFIJL`
[slint](https://github.com/slint-ui/tree-sitter-slint) | unmaintained | `HFIJL`
[smali](https://github.com/tree-sitter-grammars/tree-sitter-smali) | unstable | `HFIJL`
[smithy](https://github.com/indoorvivants/tree-sitter-smithy) | unstable | `H  J `
[snakemake](https://github.com/osthomas/tree-sitter-snakemake) | unstable | `HFIJL`
[snl](https://github.com/minijackson/tree-sitter-snl)[^snl] | unstable | `HFIJL`
[solidity](https://github.com/JoranHonig/tree-sitter-solidity) | unstable | `HF J `
[soql](https://github.com/aheber/tree-sitter-sfapex) | unstable | `H    `
[sosl](https://github.com/aheber/tree-sitter-sfapex) | unstable | `H    `
[sourcepawn](https://github.com/nilshelmig/tree-sitter-sourcepawn) | unstable | `H  JL`
[sparql](https://github.com/GordianDziwis/tree-sitter-sparql) | unstable | `HFIJL`
[sproto](https://github.com/hanxi/tree-sitter-sproto) | unstable | `HFIJ `
[sql](https://github.com/derekstride/tree-sitter-sql) | unstable | `HFIJ `
[squirrel](https://github.com/tree-sitter-grammars/tree-sitter-squirrel) | unstable | `HFIJL`
[ssh_config](https://github.com/tree-sitter-grammars/tree-sitter-ssh-config) | unstable | `HFIJL`
[starlark](https://github.com/tree-sitter-grammars/tree-sitter-starlark) | unstable | `HFIJL`
[strace](https://github.com/sigmaSd/tree-sitter-strace) | unstable | `H  J `
[styled](https://github.com/mskelton/tree-sitter-styled) | unstable | `HFIJ `
[supercollider](https://github.com/madskjeldgaard/tree-sitter-supercollider) | unstable | `HFIJL`
[superhtml](https://github.com/kristoff-it/superhtml) | unstable | `H  J `
[surface](https://github.com/connorlay/tree-sitter-surface) | unstable | `HFIJ `
[svelte](https://github.com/tree-sitter-grammars/tree-sitter-svelte) | unstable | `HFIJL`
[sway](https://github.com/FuelLabs/tree-sitter-sway.git) | unstable | `HFIJL`
[swift](https://github.com/alex-pinkus/tree-sitter-swift) | unstable | `HFIJL`
[sxhkdrc](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) | unstable | `HF J `
[systemtap](https://github.com/ok-ryoko/tree-sitter-systemtap) | unstable | `HF JL`
[systemverilog](https://github.com/gmlarumbe/tree-sitter-systemverilog) | unstable | `HF J `
[t32](https://github.com/xasc/tree-sitter-t32) | unstable | `HFIJL`
[tablegen](https://github.com/tree-sitter-grammars/tree-sitter-tablegen) | unstable | `HFIJL`
[tact](https://github.com/tact-lang/tree-sitter-tact) | unstable | `HFIJL`
[tcl](https://github.com/tree-sitter-grammars/tree-sitter-tcl) | unstable | `HFIJ `
[teal](https://github.com/euclidianAce/tree-sitter-teal) | unstable | `HFIJL`
[templ](https://github.com/vrischmann/tree-sitter-templ) | unstable | `HF J `
[tera](https://github.com/uncenter/tree-sitter-tera) | unstable | `H  J `
[terraform](https://github.com/MichaHoffmann/tree-sitter-hcl) | unstable | `HFIJ `
[textproto](https://github.com/PorterAtGoogle/tree-sitter-textproto) | unstable | `HFIJ `
[thrift](https://github.com/tree-sitter-grammars/tree-sitter-thrift) | unstable | `HFIJL`
[tiger](https://github.com/ambroisie/tree-sitter-tiger) | unstable | `HFIJL`
[tlaplus](https://github.com/tlaplus-community/tree-sitter-tlaplus) | unstable | `HF JL`
[todotxt](https://github.com/arnarg/tree-sitter-todotxt) | unstable | `H    `
[toml](https://github.com/tree-sitter-grammars/tree-sitter-toml) | unstable | `HFIJL`
[tsv](https://github.com/tree-sitter-grammars/tree-sitter-csv) | unstable | `H    `
[tsx](https://github.com/tree-sitter/tree-sitter-typescript) | unstable | `HFIJL`
[turtle](https://github.com/GordianDziwis/tree-sitter-turtle) | unstable | `HFIJL`
[twig](https://github.com/gbprod/tree-sitter-twig) | unstable | `H  J `
[typescript](https://github.com/tree-sitter/tree-sitter-typescript) | unstable | `HFIJL`
[typespec](https://github.com/happenslol/tree-sitter-typespec) | unstable | `H IJ `
[typoscript](https://github.com/Teddytrombone/tree-sitter-typoscript) | unstable | `HFIJ `
[typst](https://github.com/uben0/tree-sitter-typst) | unstable | `HFIJ `
[udev](https://github.com/tree-sitter-grammars/tree-sitter-udev) | unstable | `H  JL`
[ungrammar](https://github.com/tree-sitter-grammars/tree-sitter-ungrammar) | unstable | `HFIJL`
[unison](https://github.com/kylegoetz/tree-sitter-unison) | unstable | `HF J `
[usd](https://github.com/ColinKennedy/tree-sitter-usd) | unstable | `HFIJL`
[uxntal](https://github.com/tree-sitter-grammars/tree-sitter-uxntal) | unstable | `HFIJL`
[v](https://github.com/vlang/v-analyzer) | unstable | `HFIJL`
[vala](https://github.com/vala-lang/tree-sitter-vala) | unstable | `HF J `
[vento](https://github.com/ventojs/tree-sitter-vento) | unmaintained | `H  J `
[vhdl](https://github.com/jpt13653903/tree-sitter-vhdl) | unstable | `HF J `
[vhs](https://github.com/charmbracelet/tree-sitter-vhs) | unstable | `H  J `
[vim](https://github.com/tree-sitter-grammars/tree-sitter-vim) | unstable | `HF JL`
[vimdoc](https://github.com/neovim/tree-sitter-vimdoc) | unstable | `H  J `
[vrl](https://github.com/belltoy/tree-sitter-vrl) | unstable | `HFIJL`
[vue](https://github.com/tree-sitter-grammars/tree-sitter-vue) | unstable | `HFIJ `
[wgsl](https://github.com/szebniok/tree-sitter-wgsl) | unstable | `HFIJ `
[wgsl_bevy](https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy) | unstable | `HFI  `
[wing](https://github.com/winglang/tree-sitter-wing) | unstable | `HF JL`
[wit](https://github.com/bytecodealliance/tree-sitter-wit) | stable | `HF J `
[wxml](https://github.com/BlockLune/tree-sitter-wxml) | unstable | `HFIJ `
[xcompose](https://github.com/tree-sitter-grammars/tree-sitter-xcompose) | unstable | `H  JL`
[xml](https://github.com/tree-sitter-grammars/tree-sitter-xml) | unstable | `HFIJL`
[xresources](https://github.com/ValdezFOmar/tree-sitter-xresources) | stable | `HF JL`
[yaml](https://github.com/tree-sitter-grammars/tree-sitter-yaml) | unstable | `HFIJL`
[yang](https://github.com/Hubro/tree-sitter-yang) | unstable | `HFIJ `
[yuck](https://github.com/tree-sitter-grammars/tree-sitter-yuck) | unstable | `HFIJL`
[zig](https://github.com/tree-sitter-grammars/tree-sitter-zig) | unstable | `HFIJL`
[ziggy](https://github.com/kristoff-it/ziggy) | unmaintained | `H I  `
[ziggy_schema](https://github.com/kristoff-it/ziggy) | unmaintained | `H I  `
[zsh](https://github.com/georgeharker/tree-sitter-zsh) | unstable | `HF JL`
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
[^snl]: EPICS Sequencer's SNL files
<!--parserinfo-->
