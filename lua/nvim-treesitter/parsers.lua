---@type nvim-ts.parsers
return {
  ada = {
    install_info = {
      revision = 'e8e2515465cc2d7c444498e68bdb9f1d86767f95',
      url = 'https://github.com/briot/tree-sitter-ada',
    },
    maintainers = { '@briot' },
    tier = 3,
  },
  agda = {
    install_info = {
      revision = 'd3dc807692e6bca671d4491b3bf5c67eeca8c016',
      url = 'https://github.com/tree-sitter/tree-sitter-agda',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  angular = {
    install_info = {
      generate_from_json = true,
      revision = 'c2d1f6d4c5f1993afce7f984ca2675af8d67457c',
      url = 'https://github.com/dlvandenberg/tree-sitter-angular',
    },
    maintainers = { '@dlvandenberg' },
    requires = { 'html', 'html_tags' },
    tier = 3,
  },
  apex = {
    install_info = {
      location = 'apex',
      revision = '602cc4b050ef1e14a69acc2ea094968bf928fa59',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  arduino = {
    install_info = {
      generate_from_json = true,
      revision = 'afb34b2c65f507932c5c6ddbf0d5a9ca6a772f2f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-arduino',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'cpp' },
    tier = 2,
  },
  asm = {
    install_info = {
      revision = '55b2b913f1e71136027d6fce8212e760c64f3532',
      url = 'https://github.com/RubixDev/tree-sitter-asm',
    },
    maintainers = { '@RubixDev' },
    tier = 3,
  },
  astro = {
    install_info = {
      generate_from_json = true,
      revision = '4be180759ec13651f72bacee65fa477c64222a1a',
      url = 'https://github.com/virchau13/tree-sitter-astro',
    },
    maintainers = { '@virchau13' },
    requires = { 'html', 'html_tags' },
    tier = 3,
  },
  authzed = {
    install_info = {
      revision = '1dec7e1af96c56924e3322cd85fdce15d0a31d00',
      url = 'https://github.com/mleonidas/tree-sitter-authzed',
    },
    maintainers = { '@mattpolzin' },
    tier = 3,
  },
  awk = {
    install_info = {
      revision = 'ba7472152d79a8c916550c80fdbfd5724d07a0c9',
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
    },
    tier = 4,
  },
  bash = {
    install_info = {
      revision = '2fbd860f802802ca76a6661ce025b3a3bca2d3ed',
      url = 'https://github.com/tree-sitter/tree-sitter-bash',
    },
    maintainers = { '@TravonteD' },
    tier = 1,
  },
  bass = {
    install_info = {
      revision = '28dc7059722be090d04cd751aed915b2fee2f89a',
      url = 'https://github.com/vito/tree-sitter-bass',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  beancount = {
    install_info = {
      revision = '01c0da29e0fc7130420a09d939ecc524e09b6ba6',
      url = 'https://github.com/polarmutex/tree-sitter-beancount',
    },
    maintainers = { '@polarmutex' },
    tier = 3,
  },
  bibtex = {
    install_info = {
      revision = 'ccfd77db0ed799b6c22c214fe9d2937f47bc8b34',
      url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },
  bicep = {
    install_info = {
      revision = '0092c7d1bd6bb22ce0a6f78497d50ea2b87f19c0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-bicep',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  bitbake = {
    install_info = {
      revision = 'a5d04fdb5a69a02b8fa8eb5525a60dfb5309b73b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-bitbake',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  blueprint = {
    install_info = {
      revision = '60ba73739c6083c693d86a1a7cf039c07eb4ed59',
      url = 'https://gitlab.com/gabmus/tree-sitter-blueprint',
    },
    maintainers = { '@gabmus' },
    tier = 4,
  },
  bp = {
    install_info = {
      revision = '4e60cf3c2e613625c06f6f85540b3631e2d06cd3',
      url = 'https://github.com/ambroisie/tree-sitter-bp',
    },
    maintainers = { '@ambroisie' },
    readme_note = 'Android Blueprint',
    tier = 3,
  },
  c = {
    install_info = {
      revision = '927da1f210ebb24b7f109230a61a55b428875985',
      url = 'https://github.com/tree-sitter/tree-sitter-c',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },
  c_sharp = {
    install_info = {
      revision = '31a64b28292aac6adf44071e449fa03fb80eaf4e',
      url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  cairo = {
    install_info = {
      revision = '6238f609bea233040fe927858156dee5515a0745',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cairo',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  capnp = {
    install_info = {
      revision = '7b0883c03e5edd34ef7bcf703194204299d7099f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-capnp',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  chatito = {
    install_info = {
      revision = 'a461f20dedb43905febb12c1635bc7d2e43e96f0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-chatito',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  clojure = {
    install_info = {
      revision = 'f4236d4da8aa92bc105d9c118746474c608e6af7',
      url = 'https://github.com/sogaiu/tree-sitter-clojure',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 3,
  },
  cmake = {
    install_info = {
      revision = '69d7a8b0f7493b0dbb07d54e8fea96c5421e8a71',
      url = 'https://github.com/uyha/tree-sitter-cmake',
    },
    maintainers = { '@uyha' },
    tier = 3,
  },
  comment = {
    install_info = {
      revision = '3555706cef8b98d3e4c7379d7260548ff03ad363',
      url = 'https://github.com/stsewd/tree-sitter-comment',
    },
    maintainers = { '@stsewd' },
    tier = 3,
  },
  commonlisp = {
    install_info = {
      generate_from_json = true,
      revision = 'bf2a65b1c119898a1a17389e07f2a399c05cdc0c',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-commonlisp',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  cooklang = {
    install_info = {
      revision = '4ebe237c1cf64cf3826fc249e9ec0988fe07e58e',
      url = 'https://github.com/addcninblue/tree-sitter-cooklang',
    },
    maintainers = { '@addcninblue' },
    tier = 3,
  },
  corn = {
    install_info = {
      revision = '464654742cbfd3a3de560aba120998f1d5dfa844',
      url = 'https://github.com/jakestanger/tree-sitter-corn',
    },
    maintainers = { '@jakestanger' },
    tier = 3,
  },
  cpon = {
    install_info = {
      revision = '594289eadfec719198e560f9d7fd243c4db678d5',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cpon',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  cpp = {
    install_info = {
      generate_from_json = true,
      revision = 'b1a4e2b25148f3cfcb5f241cbc4c49f001a6fb35',
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  css = {
    install_info = {
      revision = '9af0bdd9d225edee12f489cfa8284e248321959b',
      url = 'https://github.com/tree-sitter/tree-sitter-css',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  csv = {
    install_info = {
      location = 'csv',
      revision = '7eb7297823605392d2bbcc4c09b1cd18d6fa9529',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },
  cuda = {
    install_info = {
      generate_from_json = true,
      revision = '8812343a1f8496fc219f3d07a270f9c1d6ba3391',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cuda',
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },
  cue = {
    install_info = {
      revision = '8a5f273bfa281c66354da562f2307c2d394b6c81',
      url = 'https://github.com/eonpatapon/tree-sitter-cue',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  d = {
    install_info = {
      revision = 'ac584585a15c4cacd6cda8e6bfe7cb1ca7b3898e',
      url = 'https://github.com/gdamore/tree-sitter-d',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  dart = {
    install_info = {
      revision = 'cf72df5d4a623ca705e81bf9e9d264e1fe9d5da0',
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
    },
    maintainers = { '@akinsho' },
    tier = 3,
  },
  devicetree = {
    install_info = {
      revision = '296b3c294a8bcfca6673296d99f9cd37049b8026',
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
    },
    maintainers = { '@jedrzejboczar' },
    tier = 3,
  },
  dhall = {
    install_info = {
      revision = 'affb6ee38d629c9296749767ab832d69bb0d9ea8',
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  diff = {
    install_info = {
      revision = '19dd5aa52fe339a1d974768a09ee2537303e8ca5',
      url = 'https://github.com/the-mikedavis/tree-sitter-diff',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  disassembly = {
    install_info = {
      revision = '0229c0211dba909c5d45129ac784a3f4d49c243a',
      url = 'https://github.com/ColinKennedy/tree-sitter-disassembly',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  djot = {
    install_info = {
      revision = '886601b67d1f4690173a4925c214343c30704d32',
      url = 'https://github.com/treeman/tree-sitter-djot',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 3,
  },
  dockerfile = {
    install_info = {
      revision = '087daa20438a6cc01fa5e6fe6906d77c869d19fe',
      url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },
  dot = {
    install_info = {
      revision = '9ab85550c896d8b294d9b9ca1e30698736f08cea',
      url = 'https://github.com/rydesun/tree-sitter-dot',
    },
    maintainers = { '@rydesun' },
    tier = 3,
  },
  doxygen = {
    install_info = {
      revision = 'ccd998f378c3f9345ea4eeb223f56d7b84d16687',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-doxygen',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  dtd = {
    install_info = {
      location = 'dtd',
      revision = '809266ed1694d64dedc168a18893cc254e3edf7e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  earthfile = {
    install_info = {
      revision = 'b0a9bc5737340a9b80b489fe9ae93d7b2fe78cd7',
      url = 'https://github.com/glehmann/tree-sitter-earthfile',
    },
    maintainers = { '@glehmann' },
    tier = 3,
  },
  ebnf = {
    install_info = {
      location = 'crates/tree-sitter-ebnf',
      revision = '8e635b0b723c620774dfb8abf382a7f531894b40',
      url = 'https://github.com/RubixDev/ebnf',
    },
    maintainers = { '@RubixDev' },
    tier = 3,
  },
  ecma = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, typescript, tsx, qmljs',
    tier = 3,
  },
  editorconfig = {
    install_info = {
      revision = 'fd0d64d2fc91eab903bed4c11ce280b62e46f16e',
      url = 'https://github.com/ValdezFOmar/tree-sitter-editorconfig',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  eds = {
    install_info = {
      revision = '0ad62cb635c2f4353359a88dec9e3a57bbf9f66d',
      url = 'https://github.com/uyha/tree-sitter-eds',
    },
    maintainers = { '@uyha' },
    tier = 3,
  },
  eex = {
    install_info = {
      revision = 'f742f2fe327463335e8671a87c0b9b396905d1d1',
      url = 'https://github.com/connorlay/tree-sitter-eex',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  elixir = {
    install_info = {
      revision = 'c7ae8b77e2749826dcf23df6514f08fdd68c66a3',
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  elm = {
    install_info = {
      revision = '09dbf221d7491dc8d8839616b27c21b9c025c457',
      url = 'https://github.com/elm-tooling/tree-sitter-elm',
    },
    maintainers = { '@zweimach' },
    tier = 3,
  },
  elsa = {
    install_info = {
      revision = '0a66b2b3f3c1915e67ad2ef9f7dbd2a84820d9d7',
      url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
    },
    maintainers = { '@glapa-grossklag', '@amaanq' },
    tier = 3,
  },
  elvish = {
    install_info = {
      revision = '5e7210d945425b77f82cbaebc5af4dd3e1ad40f5',
      url = 'https://github.com/elves/tree-sitter-elvish',
    },
    maintainers = { '@elves' },
    tier = 3,
  },
  embedded_template = {
    install_info = {
      revision = 'ffbf64942c334933ee7982e144557b6efb76d0b9',
      url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
    },
    tier = 4,
  },
  erlang = {
    install_info = {
      revision = '0b5a0dcfcedd9b397252cb5568cc55ab1905b1a9',
      url = 'https://github.com/WhatsApp/tree-sitter-erlang',
    },
    maintainers = { '@filmor' },
    tier = 3,
  },
  facility = {
    install_info = {
      revision = '2d037f2f2bf668737f72e6be6eda4b7918b68d86',
      url = 'https://github.com/FacilityApi/tree-sitter-facility',
    },
    maintainers = { '@bryankenote' },
    tier = 3,
  },
  faust = {
    install_info = {
      revision = 'f3b9274514b5f9bf6b0dd4a01c30f9cc15c58bc4',
      url = 'https://github.com/khiner/tree-sitter-faust',
    },
    maintainers = { '@khiner' },
    tier = 3,
  },
  fennel = {
    install_info = {
      generate_from_json = true,
      revision = 'cfbfa478dc2dbef267ee94ae4323d9c886f45e94',
      url = 'https://github.com/alexmozaidze/tree-sitter-fennel',
    },
    maintainers = { '@alexmozaidze' },
    tier = 3,
  },
  fidl = {
    install_info = {
      revision = '0a8910f293268e27ff554357c229ba172b0eaed2',
      url = 'https://github.com/google/tree-sitter-fidl',
    },
    maintainers = { '@chaopeng' },
    tier = 3,
  },
  firrtl = {
    install_info = {
      revision = '8503d3a0fe0f9e427863cb0055699ff2d29ae5f5',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-firrtl',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fish = {
    install_info = {
      revision = 'a78aef9abc395c600c38a037ac779afc7e3cc9e0',
      url = 'https://github.com/ram02z/tree-sitter-fish',
    },
    maintainers = { '@ram02z' },
    tier = 3,
  },
  foam = {
    install_info = {
      revision = '04664b40c0dadb7ef37028acf3422c63271d377b',
      url = 'https://github.com/FoamScience/tree-sitter-foam',
    },
    maintainers = { '@FoamScience' },
    tier = 3,
  },
  forth = {
    install_info = {
      revision = '90189238385cf636b9ee99ce548b9e5b5e569d48',
      url = 'https://github.com/AlexanderBrevig/tree-sitter-forth',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  fortran = {
    install_info = {
      revision = '6b633433fb3f132f21250cf8e8be76d5a6389b7e',
      url = 'https://github.com/stadelmanma/tree-sitter-fortran',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  fsh = {
    install_info = {
      revision = 'fad2e175099a45efbc98f000cc196d3674cc45e0',
      url = 'https://github.com/mgramigna/tree-sitter-fsh',
    },
    maintainers = { '@mgramigna' },
    tier = 3,
  },
  func = {
    install_info = {
      revision = 'f780ca55e65e7d7360d0229331763e16c452fc98',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-func',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fusion = {
    install_info = {
      revision = '19db2f47ba4c3a0f6238d4ae0e2abfca16e61dd6',
      url = 'https://gitlab.com/jirgn/tree-sitter-fusion',
    },
    maintainers = { '@jirgn' },
    tier = 3,
  },
  gap = {
    install_info = {
      url = 'https://github.com/gap-system/tree-sitter-gap',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system',
    tier = 3,
  },
  gaptst = {
    install_info = {
      url = 'https://github.com/gap-system/tree-sitter-gaptst',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system test files',
    requires = { 'gap' },
    tier = 3,
  },
  gdscript = {
    install_info = {
      revision = '1f1e782fe2600f50ae57b53876505b8282388d77',
      url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
    },
    maintainers = { '@PrestonKnopp' },
    readme_note = 'Godot',
    tier = 3,
  },
  gdshader = {
    install_info = {
      revision = 'ffd9f958df13cae04593781d7d2562295a872455',
      url = 'https://github.com/GodOfAvacyn/tree-sitter-gdshader',
    },
    maintainers = { '@godofavacyn' },
    tier = 3,
  },
  git_config = {
    install_info = {
      revision = '9c2a1b7894e6d9eedfe99805b829b4ecd871375e',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  git_rebase = {
    install_info = {
      revision = 'bff4b66b44b020d918d67e2828eada1974a966aa',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  gitattributes = {
    install_info = {
      revision = '41940e199ba5763abea1d21b4f717014b45f01ea',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gitattributes',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  gitcommit = {
    install_info = {
      revision = 'aa5c279287f0895a7ebc76a06e55ac3e4b2df7c7',
      url = 'https://github.com/gbprod/tree-sitter-gitcommit',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  gitignore = {
    install_info = {
      revision = 'f4685bf11ac466dd278449bcfe5fd014e94aa504',
      url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },
  gleam = {
    install_info = {
      revision = '426e67087fd62be5f4533581b5916b2cf010fb5b',
      url = 'https://github.com/gleam-lang/tree-sitter-gleam',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  glimmer = {
    install_info = {
      revision = 'da605af8c5999b43e6839b575eae5e6cafabb06f',
      url = 'https://github.com/ember-tooling/tree-sitter-glimmer',
    },
    maintainers = { '@NullVoxPopuli' },
    readme_note = 'Glimmer and Ember',
    tier = 3,
  },
  glimmer_javascript = {
    install_info = {
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'ecma' },
    tier = 3,
  },
  glimmer_typescript = {
    install_info = {
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'typescript' },
    tier = 3,
  },
  glsl = {
    install_info = {
      generate_from_json = true,
      revision = 'ddc3137a2d775aca93084ff997fa13cc1691058a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-glsl',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  gn = {
    install_info = {
      revision = 'bc06955bc1e3c9ff8e9b2b2a55b38b94da923c05',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gn',
    },
    maintainers = { '@amaanq' },
    readme_name = 'GN (Generate Ninja)',
    tier = 2,
  },
  gnuplot = {
    install_info = {
      revision = '3c895f5d9c0b3a3c7e02383766b462c21913c000',
      url = 'https://github.com/dpezto/tree-sitter-gnuplot',
    },
    maintainers = { '@dpezto' },
    tier = 3,
  },
  go = {
    install_info = {
      revision = '6204b7308a32e991a8daed2e9895a90be55a510a',
      url = 'https://github.com/tree-sitter/tree-sitter-go',
    },
    maintainers = { '@theHamsta', '@WinWisely268' },
    tier = 2,
  },
  goctl = {
    install_info = {
      revision = '49c43532689fe1f53e8b9e009d0521cab02c432b',
      url = 'https://github.com/chaozwn/tree-sitter-goctl',
    },
    maintainers = { '@chaozwn' },
    tier = 3,
  },
  godot_resource = {
    install_info = {
      revision = '2ffb90de47417018651fc3b970e5f6b67214dc9d',
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
    tier = 3,
  },
  gomod = {
    install_info = {
      revision = '1f55029bacd0a6a11f6eb894c4312d429dcf735c',
      url = 'https://github.com/camdencheek/tree-sitter-go-mod',
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },
  gosum = {
    install_info = {
      revision = 'e2ac513b2240c7ff1069ae33b2df29ce90777c11',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-go-sum',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  gotmpl = {
    install_info = {
      revision = 'fd9e1c6647e5e9b23918d00d1e48710d0f703e19',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 3,
  },
  gowork = {
    install_info = {
      revision = '949a8a470559543857a62102c84700d291fc984c',
      url = 'https://github.com/omertuc/tree-sitter-go-work',
    },
    maintainers = { '@omertuc' },
    tier = 3,
  },
  gpg = {
    install_info = {
      revision = 'f99323fb8f3f10b6c69db0c2f6d0a14bd7330675',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gpg-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  graphql = {
    install_info = {
      revision = '5e66e961eee421786bdda8495ed1db045e06b5fe',
      url = 'https://github.com/bkegley/tree-sitter-graphql',
    },
    maintainers = { '@bkegley' },
    tier = 3,
  },
  groovy = {
    install_info = {
      revision = '171b3b7412bc93284fc0dad0a7a7bbbbd1b51289',
      url = 'https://github.com/murtaza64/tree-sitter-groovy',
    },
    maintainers = { '@murtaza64' },
    tier = 3,
  },
  gstlaunch = {
    install_info = {
      revision = '549aef253fd38a53995cda1bf55c501174372bf7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gstlaunch',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  hack = {
    install_info = {
      revision = 'fca1e294f6dce8ec5659233a6a21f5bd0ed5b4f2',
      url = 'https://github.com/slackhq/tree-sitter-hack',
    },
    tier = 4,
  },
  hare = {
    install_info = {
      revision = '4af5d82cf9ec39f67cb1db5b7a9269d337406592',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hare',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  haskell = {
    install_info = {
      revision = 'a50070d5bb5bd5c1281740a6102ecf1f4b0c4f19',
      url = 'https://github.com/tree-sitter/tree-sitter-haskell',
    },
    maintainers = { '@mrcjkb' },
    tier = 2,
  },
  haskell_persistent = {
    install_info = {
      revision = '577259b4068b2c281c9ebf94c109bd50a74d5857',
      url = 'https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent',
    },
    maintainers = { '@lykahb' },
    tier = 3,
  },
  hcl = {
    install_info = {
      revision = '9e3ec9848f28d26845ba300fd73c740459b83e9b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 2,
  },
  heex = {
    install_info = {
      revision = '6dd0303acf7138dd2b9b432a229e16539581c701',
      url = 'https://github.com/connorlay/tree-sitter-heex',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  helm = {
    install_info = {
      location = 'dialects/helm',
      revision = 'fd9e1c6647e5e9b23918d00d1e48710d0f703e19',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 3,
  },
  hjson = {
    install_info = {
      generate_from_json = true,
      revision = '02fa3b79b3ff9a296066da6277adfc3f26cbc9e0',
      url = 'https://github.com/winston0410/tree-sitter-hjson',
    },
    maintainers = { '@winston0410' },
    requires = { 'json' },
    tier = 3,
  },
  hlsl = {
    install_info = {
      generate_from_json = true,
      revision = '5d788a46727c8199a7c63a3c849092e0364375b6',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hlsl',
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },
  hlsplaylist = {
    install_info = {
      revision = '3bfda9271e3adb08d35f47a2102fe957009e1c55',
      url = 'https://github.com/Freed-Wu/tree-sitter-hlsplaylist',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  hocon = {
    install_info = {
      generate_from_json = true,
      revision = 'c390f10519ae69fdb03b3e5764f5592fb6924bcc',
      url = 'https://github.com/antosha417/tree-sitter-hocon',
    },
    maintainers = { '@antosha417' },
    tier = 4,
  },
  hoon = {
    install_info = {
      revision = 'a24c5a39d1d7e993a8bee913c8e8b6a652ca5ae8',
      url = 'https://github.com/urbit-pilled/tree-sitter-hoon',
    },
    maintainers = { '@urbit-pilled' },
    tier = 3,
  },
  html = {
    install_info = {
      revision = 'd11201a263d02169d303db903ba0bb13dc59e068',
      url = 'https://github.com/tree-sitter/tree-sitter-html',
    },
    maintainers = { '@TravonteD' },
    requires = { 'html_tags' },
    tier = 2,
  },
  html_tags = {
    maintainers = { '@TravonteD' },
    readme_note = 'queries required by html, astro, vue, svelte',
    tier = 3,
  },
  htmldjango = {
    install_info = {
      revision = 'ea71012d3fe14dd0b69f36be4f96bdfe9155ebae',
      url = 'https://github.com/interdependence/tree-sitter-htmldjango',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  http = {
    install_info = {
      revision = 'bbcd67642e5749b90277c353b72e762f3be16993',
      url = 'https://github.com/rest-nvim/tree-sitter-http',
    },
    maintainers = { '@amaanq', '@NTBBloodbath' },
    tier = 3,
  },
  hurl = {
    install_info = {
      revision = 'fba6ed8db3a009b9e7d656511931b181a3ee5b08',
      url = 'https://github.com/pfeiferj/tree-sitter-hurl',
    },
    maintainers = { '@pfeiferj' },
    tier = 3,
  },
  hyprlang = {
    install_info = {
      revision = '6858695eba0e63b9e0fceef081d291eb352abce8',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hyprlang',
    },
    maintainers = { '@luckasRanarison' },
    tier = 2,
  },
  idl = {
    install_info = {
      revision = '5573b295410201ed22771776b34d636900eba368',
      url = 'https://github.com/cathaysia/tree-sitter-idl',
    },
    maintainers = { '@cathaysia' },
    tier = 3,
  },
  ini = {
    install_info = {
      revision = '87176e524f0a98f5be75fa44f4f0ff5c6eac069c',
      url = 'https://github.com/justinmk/tree-sitter-ini',
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },
  inko = {
    install_info = {
      revision = '234c87be1dac20f766ddf6f486a7bde2a4bc5594',
      url = 'https://github.com/inko-lang/tree-sitter-inko',
    },
    maintainers = { '@yorickpeterse' },
    tier = 3,
  },
  ispc = {
    install_info = {
      generate_from_json = true,
      revision = '9b2f9aec2106b94b4e099fe75e73ebd8ae707c04',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ispc',
    },
    maintainers = { '@fab4100' },
    requires = { 'c' },
    tier = 2,
  },
  janet_simple = {
    install_info = {
      revision = '12bfab7db8a5f5b1d774ef84b5831acd34936071',
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
    },
    maintainers = { '@sogaiu' },
    tier = 3,
  },
  java = {
    install_info = {
      revision = '576d8097e495b411f31daaee28cb34c1752ac702',
      url = 'https://github.com/tree-sitter/tree-sitter-java',
    },
    maintainers = { '@p00f' },
    tier = 2,
  },
  javascript = {
    install_info = {
      revision = '15887341e5b57ffdb423aff840aef142b8f53d6d',
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
    tier = 2,
  },
  jq = {
    install_info = {
      revision = '13990f530e8e6709b7978503da9bc8701d366791',
      url = 'https://github.com/flurie/tree-sitter-jq',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  jsdoc = {
    install_info = {
      revision = '49fde205b59a1d9792efc21ee0b6d50bbd35ff14',
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json = {
    install_info = {
      revision = 'bdd69eb8c8a58a9f54df03de0488d9990179be46',
      url = 'https://github.com/tree-sitter/tree-sitter-json',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json5 = {
    install_info = {
      revision = 'ab0ba8229d639ec4f3fa5f674c9133477f4b77bd',
      url = 'https://github.com/Joakker/tree-sitter-json5',
    },
    maintainers = { '@Joakker' },
    tier = 3,
  },
  jsonc = {
    install_info = {
      generate_from_json = true,
      revision = '02b01653c8a1c198ae7287d566efa86a135b30d5',
      url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc',
    },
    maintainers = { '@WhyNotHugo' },
    requires = { 'json' },
    tier = 3,
  },
  jsonnet = {
    install_info = {
      revision = 'ddd075f1939aed8147b7aa67f042eda3fce22790',
      url = 'https://github.com/sourcegraph/tree-sitter-jsonnet',
    },
    maintainers = { '@nawordar' },
    tier = 3,
  },
  jsx = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, tsx',
    tier = 3,
  },
  julia = {
    install_info = {
      revision = 'a528de39923448e6b809a6b9f686f3472728f202',
      url = 'https://github.com/tree-sitter/tree-sitter-julia',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  just = {
    install_info = {
      revision = '6648ac1c0cdadaec8ee8bcf9a4ca6ace5102cf21',
      url = 'https://github.com/IndianBoy42/tree-sitter-just',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  kconfig = {
    install_info = {
      revision = '486fea71f61ad9f3fd4072a118402e97fe88d26c',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-kconfig',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  kdl = {
    install_info = {
      revision = 'b37e3d58e5c5cf8d739b315d6114e02d42e66664',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-kdl',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  kotlin = {
    install_info = {
      revision = 'dc5e8a14cb1f45582a8c221a270a199a5f8bdb63',
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
    },
    maintainers = { '@SalBakraa' },
    tier = 3,
  },
  koto = {
    install_info = {
      revision = 'd4109879ba1387d19095269a7473bd7d274ab848',
      url = 'https://github.com/koto-lang/tree-sitter-koto',
    },
    maintainers = { '@irh' },
    tier = 3,
  },
  kusto = {
    install_info = {
      revision = '8353a1296607d6ba33db7c7e312226e5fc83e8ce',
      url = 'https://github.com/Willem-J-an/tree-sitter-kusto',
    },
    maintainers = { '@Willem-J-an' },
    tier = 3,
  },
  lalrpop = {
    install_info = {
      revision = '854a40e99f7c70258e522bdb8ab584ede6196e2e',
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
    },
    maintainers = { '@traxys' },
    tier = 3,
  },
  latex = {
    install_info = {
      generate = true,
      revision = '90fd9894bebddce79f5b8041e7f82523364a619b',
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },
  ledger = {
    install_info = {
      revision = '8a841fb20ce683bfbb3469e6ba67f2851cfdf94a',
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
    },
    maintainers = { '@cbarrete' },
    tier = 3,
  },
  leo = {
    install_info = {
      revision = 'f5ecaaa869a845e689399092cb9a61feca66cf12',
      url = 'https://github.com/r001/tree-sitter-leo',
    },
    maintainers = { '@r001' },
    tier = 3,
  },
  linkerscript = {
    install_info = {
      revision = 'f99011a3554213b654985a4b0a65b3b032ec4621',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-linkerscript',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  liquid = {
    install_info = {
      revision = '4c19cc5b2b408de590f83497a90cc941ed59ea06',
      url = 'https://github.com/hankthetank27/tree-sitter-liquid',
    },
    maintainers = { '@hankthetank27' },
    tier = 3,
  },
  liquidsoap = {
    install_info = {
      revision = '14feafa91630afb1ab9988cf9b738b7ea29f3f89',
      url = 'https://github.com/savonet/tree-sitter-liquidsoap',
    },
    maintainers = { '@toots' },
    tier = 3,
  },
  llvm = {
    install_info = {
      revision = '1b96e58faf558ce057d4dc664b904528aee743cb',
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
    },
    maintainers = { '@benwilliamgraham' },
    tier = 3,
  },
  lua = {
    install_info = {
      revision = 'a24dab177e58c9c6832f96b9a73102a0cfbced4a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-lua',
    },
    maintainers = { '@muniftanjim' },
    tier = 1,
  },
  luadoc = {
    install_info = {
      revision = '873612aadd3f684dd4e631bdf42ea8990c57634e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luadoc',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  luap = {
    install_info = {
      revision = 'c134aaec6acf4fa95fe4aa0dc9aba3eacdbbe55a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luap',
    },
    maintainers = { '@amaanq' },
    readme_note = 'Lua patterns',
    tier = 2,
  },
  luau = {
    install_info = {
      generate_from_json = true,
      revision = 'fbadc96272f718dba267628ba7b0e694c368cef3',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luau',
    },
    maintainers = { '@amaanq' },
    requires = { 'lua' },
    tier = 2,
  },
  m68k = {
    install_info = {
      revision = 'e128454c2210c0e0c10b68fe45ddb8fee80182a3',
      url = 'https://github.com/grahambates/tree-sitter-m68k',
    },
    maintainers = { '@grahambates' },
    tier = 3,
  },
  make = {
    install_info = {
      revision = 'a4b9187417d6be349ee5fd4b6e77b4172c6827dd',
      url = 'https://github.com/alemuller/tree-sitter-make',
    },
    maintainers = { '@lewis6991' },
    tier = 3,
  },
  markdown = {
    install_info = {
      location = 'tree-sitter-markdown',
      revision = '7fe453beacecf02c86f7736439f238f5bb8b5c9b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown',
    },
    maintainers = { '@MDeiml' },
    readme_note = 'basic highlighting',
    requires = { 'markdown_inline' },
    tier = 1,
  },
  markdown_inline = {
    install_info = {
      location = 'tree-sitter-markdown-inline',
      revision = '7fe453beacecf02c86f7736439f238f5bb8b5c9b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown',
    },
    maintainers = { '@MDeiml' },
    readme_note = 'needed for full highlighting',
    tier = 1,
  },
  matlab = {
    install_info = {
      revision = '306c43ab28b7b8a4976e40ff0a7c26b019ad52df',
      url = 'https://github.com/acristoffers/tree-sitter-matlab',
    },
    maintainers = { '@acristoffers' },
    tier = 3,
  },
  menhir = {
    install_info = {
      revision = 'be8866a6bcc2b563ab0de895af69daeffa88fe70',
      url = 'https://github.com/Kerl13/tree-sitter-menhir',
    },
    maintainers = { '@Kerl13' },
    tier = 3,
  },
  mermaid = {
    install_info = {
      revision = '90ae195b31933ceb9d079abfa8a3ad0a36fee4cc',
      url = 'https://github.com/monaqa/tree-sitter-mermaid',
    },
    tier = 4,
  },
  meson = {
    install_info = {
      revision = 'bd17c824196ce70800f64ad39cfddd1b17acc13f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-meson',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  mlir = {
    install_info = {
      generate = true,
      revision = 'fd8cbd544bdff4acdfe1da63b403b5c591059aeb',
      url = 'https://github.com/artagnon/tree-sitter-mlir',
    },
    maintainers = { '@artagnon' },
    tier = 3,
  },
  muttrc = {
    install_info = {
      revision = '173b0ab53a9c07962c9777189c4c70e90f1c1837',
      url = 'https://github.com/neomutt/tree-sitter-muttrc',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  nasm = {
    install_info = {
      revision = '570f3d7be01fffc751237f4cfcf52d04e20532d1',
      url = 'https://github.com/naclsn/tree-sitter-nasm',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  nginx = {
    install_info = {
      revision = '281d184b8240b2b22670b8907b57b6d6842db6f3',
      url = 'https://github.com/opa-oz/tree-sitter-nginx',
    },
    maintainers = { '@opa-oz' },
    tier = 3,
  },
  nickel = {
    install_info = {
      revision = '88d836a24b3b11c8720874a1a9286b8ae838d30a',
      url = 'https://github.com/nickel-lang/tree-sitter-nickel',
    },
    tier = 4,
  },
  nim = {
    install_info = {
      revision = '897e5d346f0b59ed62b517cfb0f1a845ad8f0ab7',
      url = 'https://github.com/alaviss/tree-sitter-nim',
    },
    maintainers = { '@aMOPel' },
    requires = { 'nim_format_string' },
    tier = 3,
  },
  nim_format_string = {
    install_info = {
      revision = 'd45f75022d147cda056e98bfba68222c9c8eca3a',
      url = 'https://github.com/aMOPel/tree-sitter-nim-format-string',
    },
    maintainers = { '@aMOPel' },
    tier = 3,
  },
  ninja = {
    install_info = {
      revision = '0a95cfdc0745b6ae82f60d3a339b37f19b7b9267',
      url = 'https://github.com/alemuller/tree-sitter-ninja',
    },
    maintainers = { '@alemuller' },
    tier = 3,
  },
  nix = {
    install_info = {
      revision = '537095ddc80cf610fa75a2a0149fe9799b011014',
      url = 'https://github.com/cstrahan/tree-sitter-nix',
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },
  nqc = {
    install_info = {
      generate_from_json = true,
      revision = '14e6da1627aaef21d2b2aa0c37d04269766dcc1d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-nqc',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  objc = {
    install_info = {
      generate_from_json = true,
      revision = '62e61b6f5c0289c376d61a8c91faf6435cde9012',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-objc',
    },
    maintainers = { '@amaanq' },
    requires = { 'c' },
    tier = 2,
  },
  objdump = {
    install_info = {
      revision = '28d3b2e25a0b1881d1b47ed1924ca276c7003d45',
      url = 'https://github.com/ColinKennedy/tree-sitter-objdump',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  ocaml = {
    install_info = {
      location = 'grammars/ocaml',
      revision = '036226e5edb410aec004cc7ac0f4b2014dd04a0e',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    tier = 2,
  },
  ocaml_interface = {
    install_info = {
      location = 'grammars/interface',
      revision = '036226e5edb410aec004cc7ac0f4b2014dd04a0e',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    requires = { 'ocaml' },
    tier = 2,
  },
  ocamllex = {
    install_info = {
      generate = true,
      revision = '4b9898ccbf198602bb0dec9cd67cc1d2c0a4fad2',
      url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
    },
    maintainers = { '@undu' },
    tier = 3,
  },
  odin = {
    install_info = {
      revision = 'd37b8f24f653378b268ec18404e9c14ad355b128',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-odin',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  org = {
    install_info = {
      revision = '64cfbc213f5a83da17632c95382a5a0a2f3357c1',
      url = 'https://github.com/milisims/tree-sitter-org',
    },
    tier = 4,
  },
  pascal = {
    install_info = {
      revision = 'd0ebabefaea9ac3f6fc3004cf08cd121b66da9e4',
      url = 'https://github.com/Isopod/tree-sitter-pascal',
    },
    maintainers = { '@Isopod' },
    tier = 3,
  },
  passwd = {
    install_info = {
      revision = '20239395eacdc2e0923a7e5683ad3605aee7b716',
      url = 'https://github.com/ath3/tree-sitter-passwd',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  pem = {
    install_info = {
      revision = '217ff2af3f2db15a79ab7e3d21ea1e0c17e71a1a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pem',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  perl = {
    install_info = {
      branch = 'release',
      generate_from_json = true,
      revision = '55fb764e6a94512ceeaa1b9e4d53f6103e0610b2',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },
  php = {
    install_info = {
      location = 'php',
      revision = 'a552625b56c19006932cff1f207ebc07b55ed12d',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP with embedded HTML',
    requires = { 'php_only' },
    tier = 2,
  },
  php_only = {
    install_info = {
      location = 'php_only',
      revision = 'a552625b56c19006932cff1f207ebc07b55ed12d',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP without embedded HTML',
    tier = 2,
  },
  phpdoc = {
    install_info = {
      generate_from_json = true,
      revision = '1d0e255b37477d0ca46f1c9e9268c8fa76c0b3fc',
      url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
    },
    maintainers = { '@mikehaertl' },
    tier = 3,
  },
  pioasm = {
    install_info = {
      revision = '924aadaf5dea2a6074d72027b064f939acf32e20',
      url = 'https://github.com/leo60228/tree-sitter-pioasm',
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },
  po = {
    install_info = {
      revision = 'bd860a0f57f697162bf28e576674be9c1500db5e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-po',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  pod = {
    install_info = {
      branch = 'release',
      generate_from_json = true,
      revision = '0bf8387987c21bf2f8ed41d2575a8f22b139687f',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-pod',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },
  poe_filter = {
    install_info = {
      revision = '592476d81f95d2451f2ca107dc872224c76fecdf',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-poe-filter',
    },
    maintainers = { '@ObserverOfTime' },
    readme_note = 'Path of Exile item filter',
    tier = 2,
  },
  pony = {
    install_info = {
      revision = '73ff874ae4c9e9b45462673cbc0a1e350e2522a7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pony',
    },
    maintainers = { '@amaanq', '@mfelsche' },
    tier = 2,
  },
  powershell = {
    filetype = 'ps1',
    install_info = {
      revision = 'fc15514b2f1dbba9c58528d15a3708f89eda6a01',
      url = 'https://github.com/airbus-cert/tree-sitter-powershell',
    },
    maintainers = { '@L2jLiga' },
    tier = 3,
  },
  printf = {
    install_info = {
      revision = '0e0aceabbf607ea09e03562f5d8a56f048ddea3d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-printf',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  prisma = {
    install_info = {
      revision = 'eca2596a355b1a9952b4f80f8f9caed300a272b5',
      url = 'https://github.com/victorhqc/tree-sitter-prisma',
    },
    maintainers = { '@elianiva' },
    tier = 3,
  },
  problog = {
    install_info = {
      location = 'grammars/problog',
      revision = '93c69d2f84d8a167c0a3f4a8d51ccefe365a4dc8',
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
    },
    maintainers = { '@foxyseta' },
    requires = { 'prolog' },
    tier = 3,
  },
  prolog = {
    install_info = {
      location = 'grammars/prolog',
      revision = '93c69d2f84d8a167c0a3f4a8d51ccefe365a4dc8',
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
    },
    maintainers = { '@foxyseta' },
    tier = 3,
  },
  promql = {
    install_info = {
      revision = '77625d78eebc3ffc44d114a07b2f348dff3061b0',
      url = 'https://github.com/MichaHoffmann/tree-sitter-promql',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 3,
  },
  properties = {
    install_info = {
      revision = '9d09f5f200c356c50c4103d36441309fd61b48d1',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-properties',
    },
    maintainers = { '@ObserverOfTime' },
    readme_note = 'Java properties files',
    tier = 2,
  },
  proto = {
    install_info = {
      revision = 'e9f6b43f6844bd2189b50a422d4e2094313f6aa3',
      url = 'https://github.com/treywood/tree-sitter-proto',
    },
    maintainers = { '@treywood' },
    tier = 3,
  },
  prql = {
    install_info = {
      revision = '09e158cd3650581c0af4c49c2e5b10c4834c8646',
      url = 'https://github.com/PRQL/tree-sitter-prql',
    },
    maintainers = { '@matthias-Q' },
    tier = 3,
  },
  psv = {
    install_info = {
      location = 'psv',
      revision = '7eb7297823605392d2bbcc4c09b1cd18d6fa9529',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },
  pug = {
    install_info = {
      revision = 'a7ff31a38908df9b9f34828d21d6ca5e12413e18',
      url = 'https://github.com/zealot128/tree-sitter-pug',
    },
    maintainers = { '@zealot128' },
    tier = 3,
  },
  puppet = {
    install_info = {
      revision = '584522f32495d648b18a53ccb52d988e60de127d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-puppet',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  purescript = {
    install_info = {
      revision = 'daf9b3e2be18b0b2996a1281f7783e0d041d8b80',
      url = 'https://github.com/postsolar/tree-sitter-purescript',
    },
    maintainers = { '@postsolar' },
    tier = 3,
  },
  pymanifest = {
    install_info = {
      revision = 'be062582956165019d3253794b4d712f66dfeaaa',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pymanifest',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'PyPA manifest',
    tier = 2,
  },
  python = {
    install_info = {
      revision = '346fa42dc2990d2a2736cc60891369d0d3d8e65c',
      url = 'https://github.com/tree-sitter/tree-sitter-python',
    },
    maintainers = { '@stsewd', '@theHamsta' },
    tier = 1,
  },
  ql = {
    install_info = {
      revision = '42becd6f8f7bae82c818fa3abb1b6ff34b552310',
      url = 'https://github.com/tree-sitter/tree-sitter-ql',
    },
    maintainers = { '@pwntester' },
    tier = 2,
  },
  qmldir = {
    install_info = {
      revision = '6b2b5e41734bd6f07ea4c36ac20fb6f14061c841',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-qmldir',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  qmljs = {
    install_info = {
      generate_from_json = true,
      revision = 'cc4186f15e2829385be33440561fdd17b1c40cf7',
      url = 'https://github.com/yuja/tree-sitter-qmljs',
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
    tier = 3,
  },
  query = {
    install_info = {
      revision = 'f767fb0ac5e711b6d44c5e0c8d1f349687a86ce0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-query',
    },
    maintainers = { '@steelsojka' },
    readme_note = 'Tree-sitter query language',
    tier = 1,
  },
  r = {
    install_info = {
      revision = 'b1e211f52ad8f8e1e182bbbcc16dcd5e3688eb7d',
      url = 'https://github.com/r-lib/tree-sitter-r',
    },
    maintainers = { '@ribru17' },
    tier = 3,
  },
  racket = {
    install_info = {
      revision = '171f52a8c0ed635b85cd42d1e36d82f1066a03b4',
      url = 'https://github.com/6cdh/tree-sitter-racket',
    },
    tier = 4,
  },
  ralph = {
    install_info = {
      revision = 'f6d81bf7a4599c77388035439cf5801cd461ff77',
      url = 'https://github.com/alephium/tree-sitter-ralph',
    },
    maintainers = { '@tdroxler' },
    tier = 3,
  },
  rasi = {
    install_info = {
      revision = '6c9bbcfdf5f0f553d9ebc01750a3aa247a37b8aa',
      url = 'https://github.com/Fymyte/tree-sitter-rasi',
    },
    maintainers = { '@Fymyte' },
    tier = 3,
  },
  rbs = {
    install_info = {
      revision = '8d8e65ac3f77fbc9e15b1cdb9f980a3e0ac3ab99',
      url = 'https://github.com/joker1007/tree-sitter-rbs',
    },
    maintainers = { '@joker1007' },
    tier = 3,
  },
  re2c = {
    install_info = {
      revision = '47aa19cf5f7aba2ed30e2b377f7172df76e819a6',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-re2c',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  readline = {
    install_info = {
      revision = '3d4768b04d7cfaf40533e12b28672603428b8f31',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-readline',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  regex = {
    install_info = {
      revision = '47007f195752d8e57bda80b0b6cdb2d173a9f7d7',
      url = 'https://github.com/tree-sitter/tree-sitter-regex',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  rego = {
    install_info = {
      revision = '20b5a5958c837bc9f74b231022a68a594a313f6d',
      url = 'https://github.com/FallenAngel97/tree-sitter-rego',
    },
    maintainers = { '@FallenAngel97' },
    tier = 3,
  },
  requirements = {
    install_info = {
      revision = '5ad9b7581b3334f6ad492847d007f2fac6e6e5f2',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-requirements',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'pip requirements',
    tier = 2,
  },
  rescript = {
    install_info = {
      revision = '4606cd81c4c31d1d02390fee530858323410a74c',
      url = 'https://github.com/rescript-lang/tree-sitter-rescript',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  rnoweb = {
    install_info = {
      revision = '1a74dc0ed731ad07db39f063e2c5a6fe528cae7f',
      url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
    },
    maintainers = { '@bamonroe' },
    tier = 3,
  },
  robot = {
    install_info = {
      revision = '322e4cc65754d2b3fdef4f2f8a71e0762e3d13af',
      url = 'https://github.com/Hubro/tree-sitter-robot',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  robots = {
    install_info = {
      revision = '8e3a4205b76236bb6dbebdbee5afc262ce38bb62',
      url = 'https://github.com/opa-oz/tree-sitter-robots-txt',
    },
    maintainers = { '@opa-oz' },
    tier = 3,
  },
  roc = {
    install_info = {
      revision = 'ef46edd0c03ea30a22f7e92bc68628fb7231dc8a',
      url = 'https://github.com/faldor20/tree-sitter-roc',
    },
    maintainers = { '@nat-418' },
    tier = 3,
  },
  ron = {
    install_info = {
      revision = '78938553b93075e638035f624973083451b29055',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ron',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  rst = {
    install_info = {
      revision = '5120f6e59284cb8b85b450bd2db0bd352635ba9f',
      url = 'https://github.com/stsewd/tree-sitter-rst',
    },
    maintainers = { '@stsewd' },
    tier = 3,
  },
  ruby = {
    install_info = {
      revision = '7dbc1e2d0e2d752577655881f73b4573f3fe85d4',
      url = 'https://github.com/tree-sitter/tree-sitter-ruby',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  rust = {
    install_info = {
      revision = '2b43eafe64470846cdaa0eaae1e287c120ee5f03',
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  scala = {
    install_info = {
      revision = 'dd7fe4d7838ca751f5259718658dd309d999855b',
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
    },
    maintainers = { '@stevanmilic' },
    tier = 2,
  },
  scfg = {
    install_info = {
      generate = true,
      revision = 'a5512800ea0220da4abbae61b8aea8423d1549aa',
      url = 'https://github.com/rockorager/tree-sitter-scfg',
    },
    maintainers = { '@WhyNotHugo' },
    tier = 4,
  },
  scheme = {
    install_info = {
      revision = '8f9dff3d038f09934db5ea113cebc59c74447743',
      url = 'https://github.com/6cdh/tree-sitter-scheme',
    },
    tier = 4,
  },
  scss = {
    install_info = {
      revision = 'c478c6868648eff49eb04a4df90d703dc45b312a',
      url = 'https://github.com/serenadeai/tree-sitter-scss',
    },
    maintainers = { '@elianiva' },
    requires = { 'css' },
    tier = 3,
  },
  sflog = {
    install_info = {
      location = 'sflog',
      revision = '602cc4b050ef1e14a69acc2ea094968bf928fa59',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiaofinland' },
    readme_note = 'Salesforce debug log',
    tier = 3,
  },
  slang = {
    install_info = {
      generate_from_json = true,
      revision = 'd84b43d75d65bbc4ba57166ce17555f32c0b8983',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-slang',
    },
    maintainers = { '@theHamsta' },
    readme_note = 'Shader Slang',
    tier = 2,
  },
  slint = {
    install_info = {
      revision = '34ccfd58d3baee7636f62d9326f32092264e8407',
      url = 'https://github.com/slint-ui/tree-sitter-slint',
    },
    maintainers = { '@hunger' },
    tier = 3,
  },
  smali = {
    install_info = {
      revision = 'fdfa6a1febc43c7467aa7e937b87b607956f2346',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-smali',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  smithy = {
    install_info = {
      revision = 'fa898ac0885d1da9a253695c3e0e91f5efc587cd',
      url = 'https://github.com/indoorvivants/tree-sitter-smithy',
    },
    maintainers = { '@amaanq', '@keynmol' },
    tier = 3,
  },
  snakemake = {
    install_info = {
      generate_from_json = true,
      revision = 'e909815acdbe37e69440261ebb1091ed52e1dec6',
      url = 'https://github.com/osthomas/tree-sitter-snakemake',
    },
    maintainers = { '@osthomas' },
    tier = 3,
  },
  solidity = {
    install_info = {
      revision = 'ee5a2d2ba30b487c4bbf613d2ef310a454c09c7c',
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  soql = {
    install_info = {
      location = 'soql',
      revision = '602cc4b050ef1e14a69acc2ea094968bf928fa59',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sosl = {
    install_info = {
      location = 'sosl',
      revision = '602cc4b050ef1e14a69acc2ea094968bf928fa59',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sourcepawn = {
    install_info = {
      revision = '6b9bf9cbab91443380d2ca8a2f6c491cc7fac5bf',
      url = 'https://github.com/nilshelmig/tree-sitter-sourcepawn',
    },
    maintainers = { '@Sarrus1' },
    tier = 3,
  },
  sparql = {
    install_info = {
      generate_from_json = true,
      revision = 'd853661ca680d8ff7f8d800182d5782b61d0dd58',
      url = 'https://github.com/GordianDziwis/tree-sitter-sparql',
    },
    maintainers = { '@GordianDziwis' },
    tier = 3,
  },
  sql = {
    install_info = {
      branch = 'gh-pages',
      generate_from_json = true,
      revision = 'a8b10c76759a372d0f92bb070b4f5c993e0ce5f9',
      url = 'https://github.com/derekstride/tree-sitter-sql',
    },
    maintainers = { '@derekstride' },
    tier = 3,
  },
  squirrel = {
    install_info = {
      revision = '072c969749e66f000dba35a33c387650e203e96e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-squirrel',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  ssh_config = {
    install_info = {
      revision = '77450e8bce8853921512348f83c73c168c71fdfb',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ssh-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  starlark = {
    install_info = {
      generate_from_json = true,
      revision = '018d0e09d9d0f0dd6740a37682b8ee4512e8b2ac',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-starlark',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  strace = {
    install_info = {
      revision = 'd819cdd5dbe455bd3c859193633c8d91c0df7c36',
      url = 'https://github.com/sigmaSd/tree-sitter-strace',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  styled = {
    install_info = {
      generate_from_json = true,
      revision = 'e8bf912db4996b32515639d42fe2b258517f135e',
      url = 'https://github.com/mskelton/tree-sitter-styled',
    },
    maintainers = { '@mskelton' },
    tier = 3,
  },
  supercollider = {
    install_info = {
      revision = 'affa4389186b6939d89673e1e9d2b28364f5ca6f',
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
    },
    maintainers = { '@madskjeldgaard' },
    tier = 3,
  },
  surface = {
    install_info = {
      revision = 'f4586b35ac8548667a9aaa4eae44456c1f43d032',
      url = 'https://github.com/connorlay/tree-sitter-surface',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  svelte = {
    install_info = {
      generate_from_json = true,
      revision = '7ab8221e3f378a3b04b4b488f07c1f408c5bd0d8',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-svelte',
    },
    maintainers = { '@amaanq' },
    requires = { 'html_tags' },
    tier = 2,
  },
  swift = {
    install_info = {
      generate = true,
      revision = 'd627a54d7266f0a8ee61b447b34d0ad07dadf1d6',
      url = 'https://github.com/alex-pinkus/tree-sitter-swift',
    },
    maintainers = { '@alex-pinkus' },
    tier = 3,
  },
  sxhkdrc = {
    install_info = {
      revision = '440d5f913d9465c9c776a1bd92334d32febcf065',
      url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
    },
    maintainers = { '@RaafatTurki' },
    tier = 3,
  },
  systemtap = {
    install_info = {
      revision = 'f2b378a9af0b7e1192cff67a5fb45508c927205d',
      url = 'https://github.com/ok-ryoko/tree-sitter-systemtap',
    },
    maintainers = { '@ok-ryoko' },
    tier = 3,
  },
  systemverilog = {
    install_info = {
      revision = '4f897d5e3f0e38bf8fbb55e8f39dc97d2bc2229e',
      url = 'https://github.com/zhangwwpeng/tree-sitter-systemverilog',
    },
    maintainers = { '@zhangwwpeng' },
    tier = 3,
  },
  t32 = {
    install_info = {
      revision = '6182836f4128725f1e74ce986840d7317021a015',
      url = 'https://gitlab.com/xasc/tree-sitter-t32',
    },
    maintainers = { '@xasc' },
    tier = 3,
  },
  tablegen = {
    install_info = {
      revision = 'b1170880c61355aaf38fc06f4af7d3c55abdabc4',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tablegen',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  tact = {
    install_info = {
      revision = 'b3710fe2723bd9b285de7f3d0c0717bebf3f17bd',
      url = 'https://github.com/tact-lang/tree-sitter-tact',
    },
    maintainers = { '@novusnota' },
    tier = 3,
  },
  tcl = {
    install_info = {
      revision = '8784024358c233efd0f3a6fd9e7a3c5852e628bc',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tcl',
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },
  teal = {
    install_info = {
      generate = true,
      revision = '19b02da829d1721a521bf7b802eb80a50bd53aab',
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
    },
    maintainers = { '@euclidianAce' },
    tier = 3,
  },
  templ = {
    install_info = {
      generate_from_json = true,
      revision = '58aed18580c476d7bc211f187e7b07a6cd12bb1f',
      url = 'https://github.com/vrischmann/tree-sitter-templ',
    },
    maintainers = { '@vrischmann' },
    tier = 3,
  },
  terraform = {
    install_info = {
      location = 'dialects/terraform',
      revision = '9e3ec9848f28d26845ba300fd73c740459b83e9b',
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    requires = { 'hcl' },
    tier = 3,
  },
  textproto = {
    install_info = {
      revision = '8dacf02aa402892c91079f8577998ed5148c0496',
      url = 'https://github.com/PorterAtGoogle/tree-sitter-textproto',
    },
    maintainers = { '@Porter' },
    tier = 3,
  },
  thrift = {
    install_info = {
      revision = '68fd0d80943a828d9e6f49c58a74be1e9ca142cf',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-thrift',
    },
    maintainers = { '@amaanq', '@duskmoon314' },
    tier = 2,
  },
  tiger = {
    install_info = {
      revision = 'a7f11d946b44244f71df41d2a78af0665d618dae',
      url = 'https://github.com/ambroisie/tree-sitter-tiger',
    },
    maintainers = { '@ambroisie' },
    tier = 3,
  },
  tlaplus = {
    install_info = {
      revision = 'bba02e79f85e335f310fc95e21c677e49f2c4439',
      url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
    },
    maintainers = { '@ahelwer', '@susliko' },
    tier = 3,
  },
  tmux = {
    install_info = {
      revision = '0252ecd080016e45e6305ef1a943388f5ae2f4b4',
      url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  todotxt = {
    install_info = {
      revision = '3937c5cd105ec4127448651a21aef45f52d19609',
      url = 'https://github.com/arnarg/tree-sitter-todotxt',
    },
    maintainers = { '@arnarg' },
    tier = 3,
  },
  toml = {
    install_info = {
      generate_from_json = true,
      revision = '16a30c83ce427385b8d14939c45c137fcfca6c42',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-toml',
    },
    maintainers = { '@tk-shirasaka' },
    tier = 2,
  },
  tsv = {
    install_info = {
      location = 'tsv',
      revision = '7eb7297823605392d2bbcc4c09b1cd18d6fa9529',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  tsx = {
    install_info = {
      generate_from_json = true,
      location = 'tsx',
      revision = '198d03553f43a45b92ac5d0ee167db3fec6a6fd6',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx', 'typescript' },
    tier = 2,
  },
  turtle = {
    install_info = {
      revision = '7f789ea7ef765080f71a298fc96b7c957fa24422',
      url = 'https://github.com/GordianDziwis/tree-sitter-turtle',
    },
    maintainers = { '@GordianDziwis' },
    tier = 3,
  },
  twig = {
    install_info = {
      revision = '085648e01d1422163a1702a44e72303b4e2a0bd1',
      url = 'https://github.com/gbprod/tree-sitter-twig',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  typescript = {
    install_info = {
      generate_from_json = true,
      location = 'typescript',
      revision = '198d03553f43a45b92ac5d0ee167db3fec6a6fd6',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma' },
    tier = 2,
  },
  typespec = {
    install_info = {
      revision = '0ee05546d73d8eb64635ed8125de6f35c77759fe',
      url = 'https://github.com/happenslol/tree-sitter-typespec',
    },
    maintainers = { '@happenslol' },
    tier = 3,
  },
  typoscript = {
    install_info = {
      revision = '43b221c0b76e77244efdaa9963e402a17c930fbc',
      url = 'https://github.com/Teddytrombone/tree-sitter-typoscript',
    },
    maintainers = { '@Teddytrombone' },
    tier = 3,
  },
  typst = {
    install_info = {
      revision = 'abe60cbed7986ee475d93f816c1be287f220c5d8',
      url = 'https://github.com/uben0/tree-sitter-typst',
    },
    maintainers = { '@uben0', '@RaafatTurki' },
    tier = 3,
  },
  udev = {
    install_info = {
      revision = '8f58696e79092b4ad6bf197415bbd0970acf15cd',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-udev',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  ungrammar = {
    install_info = {
      revision = 'debd26fed283d80456ebafa33a06957b0c52e451',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ungrammar',
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 2,
  },
  unison = {
    install_info = {
      generate = true,
      revision = '59d36a09282be7e4d3374854126590f3dcebee6e',
      url = 'https://github.com/kylegoetz/tree-sitter-unison',
    },
    maintainers = { '@tapegram' },
    tier = 3,
  },
  usd = {
    install_info = {
      revision = '4e0875f724d94d0c2ff36f9b8cb0b12f8b20d216',
      url = 'https://github.com/ColinKennedy/tree-sitter-usd',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  uxntal = {
    install_info = {
      revision = 'ad9b638b914095320de85d59c49ab271603af048',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-uxntal',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  v = {
    install_info = {
      location = 'tree_sitter_v',
      revision = 'a18d695ec105f0cda1903d1974f493207e122b35',
      url = 'https://github.com/vlang/v-analyzer',
    },
    maintainers = { '@kkharji', '@amaanq' },
    tier = 3,
  },
  vala = {
    install_info = {
      revision = '8f690bfa639f2b83d1fb938ed3dd98a7ba453e8b',
      url = 'https://github.com/vala-lang/tree-sitter-vala',
    },
    maintainers = { '@Prince781' },
    tier = 3,
  },
  vento = {
    install_info = {
      revision = '3321077d7446c1b3b017c294fd56ce028ed817fe',
      url = 'https://github.com/ventojs/tree-sitter-vento',
    },
    maintainers = { '@wrapperup', '@oscarotero' },
    tier = 3,
  },
  verilog = {
    install_info = {
      revision = '075ebfc84543675f12e79a955f79d717772dcef3',
      url = 'https://github.com/tree-sitter/tree-sitter-verilog',
    },
    maintainers = { '@zegervdv' },
    tier = 2,
  },
  vhdl = {
    install_info = {
      revision = '4ab3e251eae8890a020d083d00acd1b8c2653c07',
      url = 'https://github.com/jpt13653903/tree-sitter-vhdl',
    },
    maintainers = { '@jpt13653903' },
    tier = 3,
  },
  vhs = {
    install_info = {
      revision = '09f8fbfe40a3a699b200daca7d92e65fbbe9f9e6',
      url = 'https://github.com/charmbracelet/tree-sitter-vhs',
    },
    maintainers = { '@caarlos0' },
    tier = 3,
  },
  vim = {
    install_info = {
      revision = 'f3cd62d8bd043ef20507e84bb6b4b53731ccf3a7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-vim',
    },
    maintainers = { '@clason' },
    tier = 1,
  },
  vimdoc = {
    install_info = {
      revision = '2249c44ecd3f5cf22da3dcccfb74f816ddb29245',
      url = 'https://github.com/neovim/tree-sitter-vimdoc',
    },
    maintainers = { '@clason' },
    tier = 1,
  },
  vrl = {
    install_info = {
      revision = '274b3ce63f72aa8ffea18e7fc280d3062d28f0ba',
      url = 'https://github.com/belltoy/tree-sitter-vrl',
    },
    maintainers = { '@belltoy' },
    tier = 3,
  },
  vue = {
    install_info = {
      branch = 'main',
      generate_from_json = true,
      revision = '22bdfa6c9fc0f5ffa44c6e938ec46869ac8a99ff',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-vue',
    },
    maintainers = { '@WhyNotHugo', '@lucario387' },
    requires = { 'html_tags' },
    tier = 2,
  },
  wgsl = {
    install_info = {
      revision = '40259f3c77ea856841a4e0c4c807705f3e4a2b65',
      url = 'https://github.com/szebniok/tree-sitter-wgsl',
    },
    maintainers = { '@szebniok' },
    tier = 3,
  },
  wgsl_bevy = {
    install_info = {
      generate_from_json = true,
      revision = '0f06f24e259ac725045956436b9025dab008ff9f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  wing = {
    install_info = {
      revision = 'bd1d35cf3e013dc7e189b46a593bdc2b281b0dd7',
      url = 'https://github.com/winglang/tree-sitter-wing',
    },
    maintainers = { '@gshpychka', '@MarkMcCulloh' },
    tier = 3,
  },
  wit = {
    install_info = {
      revision = 'c52f0b07786603df17ad0197f6cef680f312eb2c',
      url = 'https://github.com/liamwh/tree-sitter-wit',
    },
    maintainers = { '@liamwh' },
    tier = 3,
  },
  xcompose = {
    install_info = {
      revision = 'fff3e72242aa110ebba6441946ea4d12d200fa68',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xcompose',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  xml = {
    install_info = {
      location = 'xml',
      revision = '809266ed1694d64dedc168a18893cc254e3edf7e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'dtd' },
    tier = 2,
  },
  yaml = {
    install_info = {
      revision = '7b03feefd36b5f155465ca736c6304aca983b267',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-yaml',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  yang = {
    install_info = {
      revision = '2c0e6be8dd4dcb961c345fa35c309ad4f5bd3502',
      url = 'https://github.com/Hubro/tree-sitter-yang',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  yuck = {
    install_info = {
      revision = 'e877f6ade4b77d5ef8787075141053631ba12318',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-yuck',
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 2,
  },
  zathurarc = {
    install_info = {
      revision = '0554b4a5d313244b7fc000cbb41c04afae4f4e31',
      url = 'https://github.com/Freed-Wu/tree-sitter-zathurarc',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  zig = {
    install_info = {
      revision = '0d08703e4c3f426ec61695d7617415fff97029bd',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-zig',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },
}
