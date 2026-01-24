---@type nvim-ts.parsers
return {
  ada = {
    install_info = {
      revision = '6b58259a08b1a22ba0247a7ce30be384db618da6',
      url = 'https://github.com/briot/tree-sitter-ada',
    },
    maintainers = { '@briot' },
    tier = 2,
  },
  agda = {
    install_info = {
      revision = 'e8d47a6987effe34d5595baf321d82d3519a8527',
      url = 'https://github.com/tree-sitter/tree-sitter-agda',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  angular = {
    install_info = {
      revision = '3bd2036e710f609ea08fcfca5a1eb1169ecc114f',
      url = 'https://github.com/dlvandenberg/tree-sitter-angular',
    },
    maintainers = { '@dlvandenberg' },
    requires = { 'html', 'html_tags' },
    tier = 2,
  },
  apex = {
    install_info = {
      location = 'apex',
      revision = '3597575a429766dd7ecce9f5bb97f6fec4419d5d',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 2,
  },
  arduino = {
    install_info = {
      revision = '53eb391da4c6c5857f8defa2c583c46c2594f565',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-arduino',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'cpp' },
    tier = 2,
  },
  asm = {
    install_info = {
      revision = '839741fef4dab5128952334624905c82b40c7133',
      url = 'https://github.com/RubixDev/tree-sitter-asm',
    },
    maintainers = { '@RubixDev' },
    tier = 2,
  },
  astro = {
    install_info = {
      revision = '213f6e6973d9b456c6e50e86f19f66877e7ef0ee',
      url = 'https://github.com/virchau13/tree-sitter-astro',
    },
    maintainers = { '@virchau13' },
    requires = { 'html', 'html_tags' },
    tier = 2,
  },
  authzed = {
    install_info = {
      revision = '83e5c26a8687eb4688fe91d690c735cc3d21ad81',
      url = 'https://github.com/mleonidas/tree-sitter-authzed',
    },
    maintainers = { '@mattpolzin' },
    tier = 2,
  },
  awk = {
    install_info = {
      revision = '34bbdc7cce8e803096f47b625979e34c1be38127',
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
    },
    tier = 2,
  },
  bash = {
    install_info = {
      revision = 'a06c2e4415e9bc0346c6b86d401879ffb44058f7',
      url = 'https://github.com/tree-sitter/tree-sitter-bash',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  bass = {
    install_info = {
      revision = '28dc7059722be090d04cd751aed915b2fee2f89a',
      url = 'https://github.com/vito/tree-sitter-bass',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  beancount = {
    install_info = {
      revision = '23b21252da8b8cb0f03d1d1fc4c8f87d407e1cdf',
      url = 'https://github.com/polarmutex/tree-sitter-beancount',
    },
    maintainers = { '@polarmutex' },
    tier = 2,
  },
  bibtex = {
    install_info = {
      revision = '8d04ed27b3bc7929f14b7df9236797dab9f3fa66',
      url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 2,
  },
  bicep = {
    install_info = {
      revision = 'bff59884307c0ab009bd5e81afd9324b46a6c0f9',
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
  blade = {
    install_info = {
      revision = 'cc764dadcbbceb3f259396fef66f970c72e94f96',
      url = 'https://github.com/EmranMR/tree-sitter-blade',
    },
    maintainers = { '@calebdw' },
    tier = 2,
  },
  bp = {
    install_info = {
      revision = 'ee641d15390183d7535777947ce0f2f1fbcee69f',
      url = 'https://github.com/ambroisie/tree-sitter-bp',
    },
    maintainers = { '@ambroisie' },
    readme_note = 'Android Blueprint',
    tier = 2,
  },
  bpftrace = {
    install_info = {
      revision = '0978030fdcdab74d49faaee2a60eb94607a367cc',
      url = 'https://github.com/sgruszka/tree-sitter-bpftrace',
    },
    maintainers = { '@sgruszka' },
    tier = 2,
  },
  brightscript = {
    install_info = {
      revision = '253fdfaa23814cb46c2d5fc19049fa0f2f62c6da',
      url = 'https://github.com/ajdelcimmuto/tree-sitter-brightscript',
    },
    maintainers = { '@ajdelcimmuto' },
    tier = 2,
  },
  c = {
    install_info = {
      revision = 'ae19b676b13bdcc13b7665397e6d9b14975473dd',
      url = 'https://github.com/tree-sitter/tree-sitter-c',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  c3 = {
    install_info = {
      revision = '2c04e7858d63497152d42f08d3067972618aeedc',
      url = 'https://github.com/c3lang/tree-sitter-c3',
    },
    maintainers = { '@cbuttner' },
    tier = 2,
  },
  c_sharp = {
    install_info = {
      revision = 'f05a2ca99d329de2e6c32f26a21c6169b2bfcbb7',
      url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  caddy = {
    install_info = {
      revision = '2686186edb61be47960431c93a204fb249681360',
      url = 'https://github.com/opa-oz/tree-sitter-caddy',
    },
    maintainers = { '@opa-oz' },
    tier = 3,
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
      revision = 'c0ed82c665b732395073f635c74c300f09530a7f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-chatito',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  circom = {
    install_info = {
      revision = '02150524228b1e6afef96949f2d6b7cc0aaf999e',
      url = 'https://github.com/Decurity/tree-sitter-circom',
    },
    maintainers = { '@alexandr-martirosyan' },
    tier = 2,
  },
  clojure = {
    install_info = {
      revision = 'e43eff80d17cf34852dcd92ca5e6986d23a7040f',
      url = 'https://github.com/sogaiu/tree-sitter-clojure',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 2,
  },
  cmake = {
    install_info = {
      revision = 'c7b2a71e7f8ecb167fad4c97227c838439280175',
      url = 'https://github.com/uyha/tree-sitter-cmake',
    },
    maintainers = { '@uyha' },
    tier = 2,
  },
  comment = {
    install_info = {
      revision = '66272d2b6c73fb61157541b69dd0a7ce7b42a5ad',
      url = 'https://github.com/stsewd/tree-sitter-comment',
    },
    maintainers = { '@stsewd' },
    tier = 2,
  },
  commonlisp = {
    install_info = {
      revision = '32323509b3d9fe96607d151c2da2c9009eb13a2f',
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
    tier = 2,
  },
  corn = {
    install_info = {
      revision = '464654742cbfd3a3de560aba120998f1d5dfa844',
      url = 'https://github.com/jakestanger/tree-sitter-corn',
    },
    maintainers = { '@jakestanger' },
    tier = 2,
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
      revision = '12bd6f7e96080d2e70ec51d4068f2f66120dde35',
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  css = {
    install_info = {
      revision = 'dda5cfc5722c429eaba1c910ca32c2c0c5bb1a3f',
      url = 'https://github.com/tree-sitter/tree-sitter-css',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  csv = {
    install_info = {
      location = 'csv',
      revision = 'f6bf6e35eb0b95fbadea4bb39cb9709507fcb181',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },
  cuda = {
    install_info = {
      revision = '48b066f334f4cf2174e05a50218ce2ed98b6fd01',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cuda',
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },
  cue = {
    install_info = {
      revision = '770737bcff2c4aa3f624d439e32b07dbb07102d3',
      url = 'https://github.com/eonpatapon/tree-sitter-cue',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  cylc = {
    install_info = {
      revision = '6d1d81137112299324b526477ce1db989ab58fb8',
      url = 'https://github.com/elliotfontaine/tree-sitter-cylc',
    },
    maintainers = { '@elliotfontaine' },
    tier = 2,
  },
  d = {
    install_info = {
      revision = 'fb028c8f14f4188286c2eef143f105def6fbf24f',
      url = 'https://github.com/gdamore/tree-sitter-d',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  dart = {
    install_info = {
      revision = 'd4d8f3e337d8be23be27ffc35a0aef972343cd54',
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
    },
    maintainers = { '@akinsho' },
    tier = 2,
  },
  desktop = {
    install_info = {
      revision = '137292ae28e05011dbc7c5c383e2b25db1cf77c9',
      url = 'https://github.com/ValdezFOmar/tree-sitter-desktop',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 2,
  },
  devicetree = {
    install_info = {
      revision = 'e685f1f6ac1702b046415efb476444167d63e41a',
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
    },
    maintainers = { '@jedrzejboczar' },
    tier = 2,
  },
  dhall = {
    install_info = {
      revision = '62013259b26ac210d5de1abf64cf1b047ef88000',
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  diff = {
    install_info = {
      revision = '2520c3f934b3179bb540d23e0ef45f75304b5fed',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-diff',
    },
    maintainers = { '@gbprod' },
    tier = 2,
  },
  disassembly = {
    install_info = {
      revision = '0229c0211dba909c5d45129ac784a3f4d49c243a',
      url = 'https://github.com/ColinKennedy/tree-sitter-disassembly',
    },
    maintainers = { '@ColinKennedy' },
    tier = 2,
  },
  djot = {
    install_info = {
      revision = '74fac1f53c6d52aeac104b6874e5506be6d0cfe6',
      url = 'https://github.com/treeman/tree-sitter-djot',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 2,
  },
  dockerfile = {
    install_info = {
      revision = '971acdd908568b4531b0ba28a445bf0bb720aba5',
      url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
    },
    maintainers = { '@camdencheek' },
    tier = 2,
  },
  dot = {
    install_info = {
      revision = '80327abbba6f47530edeb0df9f11bd5d5c93c14d',
      url = 'https://github.com/rydesun/tree-sitter-dot',
    },
    maintainers = { '@rydesun' },
    tier = 2,
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
      revision = '5000ae8f22d11fbe93939b05c1e37cf21117162d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  earthfile = {
    install_info = {
      revision = '5baef88717ad0156fd29a8b12d0d8245bb1096a8',
      url = 'https://github.com/glehmann/tree-sitter-earthfile',
    },
    maintainers = { '@glehmann' },
    tier = 2,
  },
  ebnf = {
    install_info = {
      location = 'crates/tree-sitter-ebnf',
      revision = '8e635b0b723c620774dfb8abf382a7f531894b40',
      url = 'https://github.com/RubixDev/ebnf',
    },
    maintainers = { '@RubixDev' },
    tier = 2,
  },
  ecma = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, typescript, tsx, qmljs',
    tier = 2,
  },
  editorconfig = {
    install_info = {
      revision = '851f2c2483239ce62f919bf3408ccd20dc0b5c01',
      url = 'https://github.com/ValdezFOmar/tree-sitter-editorconfig',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 2,
  },
  eds = {
    install_info = {
      revision = '26d529e6cfecde391a03c21d1474eb51e0285805',
      url = 'https://github.com/uyha/tree-sitter-eds',
    },
    maintainers = { '@uyha' },
    tier = 2,
  },
  eex = {
    install_info = {
      revision = 'f742f2fe327463335e8671a87c0b9b396905d1d1',
      url = 'https://github.com/connorlay/tree-sitter-eex',
    },
    maintainers = { '@connorlay' },
    tier = 2,
  },
  elixir = {
    install_info = {
      revision = 'd24cecee673c4c770f797bac6f87ae4b6d7ddec5',
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
    },
    maintainers = { '@connorlay' },
    tier = 2,
  },
  elm = {
    install_info = {
      revision = '6d9511c28181db66daee4e883f811f6251220943',
      url = 'https://github.com/elm-tooling/tree-sitter-elm',
    },
    maintainers = { '@zweimach' },
    tier = 2,
  },
  elsa = {
    install_info = {
      revision = '0a66b2b3f3c1915e67ad2ef9f7dbd2a84820d9d7',
      url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
    },
    maintainers = { '@glapa-grossklag', '@amaanq' },
    tier = 2,
  },
  elvish = {
    install_info = {
      revision = '5e7210d945425b77f82cbaebc5af4dd3e1ad40f5',
      url = 'https://github.com/elves/tree-sitter-elvish',
    },
    maintainers = { '@elves' },
    tier = 2,
  },
  embedded_template = {
    install_info = {
      revision = '3499d85f0a0d937c507a4a65368f2f63772786e1',
      url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
    },
    tier = 2,
  },
  enforce = {
    install_info = {
      revision = 'eb2796871d966264cdb041b797416ef1757c8b4f',
      url = 'https://github.com/simonvic/tree-sitter-enforce',
    },
    maintainers = { '@simonvic' },
    tier = 2,
  },
  erlang = {
    install_info = {
      revision = 'f21023bbd6cd30cadbc793d80ae4d990d9be86fc',
      url = 'https://github.com/WhatsApp/tree-sitter-erlang',
    },
    maintainers = { '@filmor' },
    tier = 2,
  },
  facility = {
    install_info = {
      revision = 'e4bfd3e960de9f4b4648acb1c92e9b95b47d8cfb',
      url = 'https://github.com/FacilityApi/tree-sitter-facility',
    },
    maintainers = { '@bryankenote' },
    tier = 2,
  },
  faust = {
    install_info = {
      revision = '122dd101919289ea809bad643712fcb483a1bed0',
      url = 'https://github.com/khiner/tree-sitter-faust',
    },
    maintainers = { '@khiner' },
    tier = 2,
  },
  fennel = {
    install_info = {
      revision = '3f0f6b24d599e92460b969aabc4f4c5a914d15a0',
      url = 'https://github.com/alexmozaidze/tree-sitter-fennel',
    },
    maintainers = { '@alexmozaidze' },
    tier = 2,
  },
  fidl = {
    install_info = {
      revision = '0a8910f293268e27ff554357c229ba172b0eaed2',
      url = 'https://github.com/google/tree-sitter-fidl',
    },
    maintainers = { '@chaopeng' },
    tier = 2,
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
      revision = 'aa074a0bacde8b5823c592574d7138f156a95776',
      url = 'https://github.com/ram02z/tree-sitter-fish',
    },
    maintainers = { '@ram02z' },
    tier = 2,
  },
  foam = {
    install_info = {
      revision = '472c24f11a547820327fb1be565bcfff98ea96a4',
      url = 'https://github.com/FoamScience/tree-sitter-foam',
    },
    maintainers = { '@FoamScience' },
    tier = 2,
  },
  forth = {
    install_info = {
      revision = '360ef13f8c609ec6d2e80782af69958b84e36cd0',
      url = 'https://github.com/AlexanderBrevig/tree-sitter-forth',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fortran = {
    install_info = {
      revision = '43cd127cd41ff6e57b3ececb3cc283c5af4796e7',
      url = 'https://github.com/stadelmanma/tree-sitter-fortran',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fsh = {
    install_info = {
      revision = 'fad2e175099a45efbc98f000cc196d3674cc45e0',
      url = 'https://github.com/mgramigna/tree-sitter-fsh',
    },
    maintainers = { '@mgramigna' },
    tier = 2,
  },
  fsharp = {
    install_info = {
      location = 'fsharp',
      revision = '5141851c278a99958469eb1736c7afc4ec738e47',
      url = 'https://github.com/ionide/tree-sitter-fsharp',
    },
    maintainers = { '@nsidorenco' },
    tier = 2,
  },
  func = {
    install_info = {
      revision = 'f780ca55e65e7d7360d0229331763e16c452fc98',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-func',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  gap = {
    install_info = {
      revision = '2bac14863b76ad0ff6fd7204c50574732acd66df',
      url = 'https://github.com/gap-system/tree-sitter-gap',
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system',
    tier = 2,
  },
  gaptst = {
    install_info = {
      revision = '69086d7627c03e1f4baf766bcef14c60d9e92331',
      url = 'https://github.com/gap-system/tree-sitter-gaptst',
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system test files',
    requires = { 'gap' },
    tier = 2,
  },
  gdscript = {
    install_info = {
      revision = '9686853b696db07118ad110e440d6de0ca6498b4',
      url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
    },
    readme_note = 'Godot',
    tier = 3,
  },
  gdshader = {
    install_info = {
      revision = '68268631c8b6dc093985f1246b099f81b30ea7d1',
      url = 'https://github.com/airblast-dev/tree-sitter-gdshader',
    },
    maintainers = { '@airblast-dev' },
    tier = 2,
  },
  git_config = {
    install_info = {
      revision = '0fbc9f99d5a28865f9de8427fb0672d66f9d83a5',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  git_rebase = {
    install_info = {
      revision = 'bff4b66b44b020d918d67e2828eada1974a966aa',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
    },
    maintainers = { '@gbprod' },
    tier = 2,
  },
  gitattributes = {
    install_info = {
      revision = '1b7af09d45b579f9f288453b95ad555f1f431645',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gitattributes',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  gitcommit = {
    install_info = {
      revision = 'a716678c0f00645fed1e6f1d0eb221481dbd6f6d',
      url = 'https://github.com/gbprod/tree-sitter-gitcommit',
    },
    maintainers = { '@gbprod' },
    tier = 2,
  },
  gitignore = {
    install_info = {
      revision = 'f4685bf11ac466dd278449bcfe5fd014e94aa504',
      url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  gleam = {
    install_info = {
      revision = 'dd4e328c5fd5f158d47a22339d8ce0f8be918a0b',
      url = 'https://github.com/gleam-lang/tree-sitter-gleam',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  glimmer = {
    install_info = {
      revision = '88af85568bde3b91acb5d4c352ed094d0c1f9d84',
      url = 'https://github.com/ember-tooling/tree-sitter-glimmer',
    },
    maintainers = { '@NullVoxPopuli' },
    readme_note = 'Glimmer and Ember',
    tier = 2,
  },
  glimmer_javascript = {
    install_info = {
      revision = '5cc865a2a0a77cbfaf5062c8fcf2a9919bd54f87',
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript',
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'ecma' },
    tier = 2,
  },
  glimmer_typescript = {
    install_info = {
      revision = '12d98944c1d5077b957cbdb90d663a7c4d50118c',
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript',
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'typescript' },
    tier = 2,
  },
  glsl = {
    install_info = {
      revision = '24a6c8ef698e4480fecf8340d771fbcb5de8fbb4',
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
      revision = '8923c1e38b9634a688a6c0dce7c18c8ffb823e79',
      url = 'https://github.com/dpezto/tree-sitter-gnuplot',
    },
    maintainers = { '@dpezto' },
    tier = 2,
  },
  go = {
    install_info = {
      revision = '2346a3ab1bb3857b48b29d779a1ef9799a248cd7',
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
    tier = 2,
  },
  godot_resource = {
    install_info = {
      revision = '302c1895f54bf74d53a08572f7b26a6614209adc',
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
    tier = 2,
  },
  gomod = {
    install_info = {
      revision = '2e886870578eeba1927a2dc4bd2e2b3f598c5f9a',
      url = 'https://github.com/camdencheek/tree-sitter-go-mod',
    },
    maintainers = { '@camdencheek' },
    tier = 2,
  },
  gosum = {
    install_info = {
      revision = '27816eb6b7315746ae9fcf711e4e1396dc1cf237',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-go-sum',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  gotmpl = {
    install_info = {
      revision = '04270cd3512e2c7de0c5f2823725d7b0c4c01fda',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 2,
  },
  gowork = {
    install_info = {
      revision = '949a8a470559543857a62102c84700d291fc984c',
      url = 'https://github.com/omertuc/tree-sitter-go-work',
    },
    maintainers = { '@omertuc' },
    tier = 2,
  },
  gpg = {
    install_info = {
      revision = '4024eb268c59204280f8ac71ef146b8ff5e737f6',
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
    tier = 2,
  },
  gren = {
    install_info = {
      revision = 'c36aac51a915fdfcaf178128ba1e9c2205b25930',
      url = 'https://github.com/MaeBrooks/tree-sitter-gren',
    },
    maintainers = { '@MaeBrooks' },
    tier = 2,
  },
  groovy = {
    install_info = {
      revision = '86911590a8e46d71301c66468e5620d9faa5b6af',
      url = 'https://github.com/murtaza64/tree-sitter-groovy',
    },
    maintainers = { '@murtaza64' },
    tier = 2,
  },
  groq = {
    install_info = {
      revision = '1fa1ab0eb391a270957e8ad8c731b492e3645649',
      url = 'https://github.com/ajrussellaudio/tree-sitter-groq',
    },
    maintainers = { '@ajrussellaudio' },
    tier = 2,
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
      revision = '1a7ded90288189746c54861ac144ede97df95081',
      url = 'https://github.com/slackhq/tree-sitter-hack',
    },
    tier = 2,
  },
  hare = {
    install_info = {
      revision = 'eed7ddf6a66b596906aa8ca3d40521b8278adc6f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hare',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  haskell = {
    install_info = {
      revision = '7fa19f195803a77855f036ee7f49e4b22856e338',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-haskell',
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
    tier = 2,
  },
  hcl = {
    install_info = {
      revision = '64ad62785d442eb4d45df3a1764962dafd5bc98b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 2,
  },
  heex = {
    install_info = {
      revision = 'b5a7cb5f74dc695a9ff5f04919f872ebc7a895e9',
      url = 'https://github.com/connorlay/tree-sitter-heex',
    },
    maintainers = { '@connorlay' },
    tier = 2,
  },
  helm = {
    install_info = {
      location = 'dialects/helm',
      revision = '04270cd3512e2c7de0c5f2823725d7b0c4c01fda',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 2,
  },
  hjson = {
    install_info = {
      revision = '02fa3b79b3ff9a296066da6277adfc3f26cbc9e0',
      url = 'https://github.com/winston0410/tree-sitter-hjson',
    },
    maintainers = { '@winston0410' },
    requires = { 'json' },
    tier = 2,
  },
  hlsl = {
    install_info = {
      revision = 'bab9111922d53d43668fabb61869bec51bbcb915',
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
    tier = 2,
  },
  hocon = {
    install_info = {
      revision = 'c390f10519ae69fdb03b3e5764f5592fb6924bcc',
      url = 'https://github.com/antosha417/tree-sitter-hocon',
    },
    maintainers = { '@antosha417' },
    tier = 2,
  },
  hoon = {
    install_info = {
      revision = '1545137aadcc63660c47db9ad98d02fa602655d0',
      url = 'https://github.com/urbit-pilled/tree-sitter-hoon',
    },
    maintainers = { '@urbit-pilled' },
    tier = 2,
  },
  html = {
    install_info = {
      revision = '73a3947324f6efddf9e17c0ea58d454843590cc0',
      url = 'https://github.com/tree-sitter/tree-sitter-html',
    },
    maintainers = { '@TravonteD' },
    requires = { 'html_tags' },
    tier = 2,
  },
  html_tags = {
    maintainers = { '@TravonteD' },
    readme_note = 'queries required by html, astro, vue, svelte',
    tier = 2,
  },
  htmldjango = {
    install_info = {
      revision = '3a643167ad9afac5d61e092f08ff5b054576fadf',
      url = 'https://github.com/interdependence/tree-sitter-htmldjango',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  http = {
    install_info = {
      revision = 'db8b4398de90b6d0b6c780aba96aaa2cd8e9202c',
      url = 'https://github.com/rest-nvim/tree-sitter-http',
    },
    maintainers = { '@amaanq', '@NTBBloodbath' },
    tier = 2,
  },
  hurl = {
    install_info = {
      revision = '597efbd7ce9a814bb058f48eabd055b1d1e12145',
      url = 'https://github.com/pfeiferj/tree-sitter-hurl',
    },
    maintainers = { '@pfeiferj' },
    tier = 2,
  },
  hyprlang = {
    install_info = {
      revision = '22723f25f3faf329863d952c9601b492afd971c9',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hyprlang',
    },
    maintainers = { '@luckasRanarison' },
    tier = 2,
  },
  idl = {
    install_info = {
      revision = 'e6b8b4d2ba285caacf6f9e931f1f637f5bc02b03',
      url = 'https://github.com/cathaysia/tree-sitter-idl',
    },
    maintainers = { '@cathaysia' },
    tier = 2,
  },
  idris = {
    install_info = {
      revision = 'c56a25cf57c68ff929356db25505c1cc4c7820f6',
      url = 'https://github.com/kayhide/tree-sitter-idris',
    },
    tier = 2,
  },
  ini = {
    install_info = {
      revision = 'e4018b5176132b4f3c5d6e61cea383f42288d0f5',
      url = 'https://github.com/justinmk/tree-sitter-ini',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  inko = {
    install_info = {
      revision = 'v0.5.1',
      url = 'https://github.com/inko-lang/tree-sitter-inko',
    },
    maintainers = { '@yorickpeterse' },
    tier = 1,
  },
  ispc = {
    install_info = {
      revision = '9b2f9aec2106b94b4e099fe75e73ebd8ae707c04',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ispc',
    },
    maintainers = { '@fab4100' },
    requires = { 'c' },
    tier = 2,
  },
  janet_simple = {
    install_info = {
      revision = '7e28cbf1ca061887ea43591a2898001f4245fddf',
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
    },
    maintainers = { '@sogaiu' },
    tier = 2,
  },
  java = {
    install_info = {
      revision = 'e10607b45ff745f5f876bfa3e94fbcc6b44bdc11',
      url = 'https://github.com/tree-sitter/tree-sitter-java',
    },
    maintainers = { '@p00f' },
    tier = 2,
  },
  javadoc = {
    install_info = {
      revision = '141525e73c9ad2fe7df8861047d4068ddbb6c337',
      url = 'https://github.com/rmuir/tree-sitter-javadoc',
    },
    maintainers = { '@rmuir' },
    tier = 2,
  },
  javascript = {
    install_info = {
      revision = '58404d8cf191d69f2674a8fd507bd5776f46cb11',
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
    tier = 2,
  },
  jinja = {
    install_info = {
      location = 'tree-sitter-jinja',
      revision = 'e589222a1ad44361bc376d5abdccd08e1fecfee5',
      url = 'https://github.com/cathaysia/tree-sitter-jinja',
    },
    maintainers = { '@cathaysia' },
    readme_note = 'basic highlighting',
    requires = { 'jinja_inline' },
    tier = 2,
  },
  jinja_inline = {
    install_info = {
      location = 'tree-sitter-jinja_inline',
      revision = 'e589222a1ad44361bc376d5abdccd08e1fecfee5',
      url = 'https://github.com/cathaysia/tree-sitter-jinja',
    },
    maintainers = { '@cathaysia' },
    readme_note = 'needed for full highlighting',
    tier = 2,
  },
  jq = {
    install_info = {
      revision = 'c204e36d2c3c6fce1f57950b12cabcc24e5cc4d9',
      url = 'https://github.com/flurie/tree-sitter-jq',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  jsdoc = {
    install_info = {
      revision = '658d18dcdddb75c760363faa4963427a7c6b52db',
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json = {
    install_info = {
      revision = '001c28d7a29832b06b0e831ec77845553c89b56d',
      url = 'https://github.com/tree-sitter/tree-sitter-json',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json5 = {
    install_info = {
      revision = 'aa630ef48903ab99e406a8acd2e2933077cc34e1',
      url = 'https://github.com/Joakker/tree-sitter-json5',
    },
    maintainers = { '@Joakker' },
    tier = 2,
  },
  jsonnet = {
    install_info = {
      revision = 'ddd075f1939aed8147b7aa67f042eda3fce22790',
      url = 'https://github.com/sourcegraph/tree-sitter-jsonnet',
    },
    maintainers = { '@nawordar' },
    tier = 2,
  },
  jsx = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, tsx',
    tier = 2,
  },
  julia = {
    install_info = {
      revision = 'dd7f707577585ade7a488d32dbfb366246ea3837',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-julia',
    },
    maintainers = { '@clason' },
    tier = 2,
  },
  just = {
    install_info = {
      revision = '7333f8c150aaac5bb46decc2d225a2d4cde8c51e',
      url = 'https://github.com/IndianBoy42/tree-sitter-just',
    },
    maintainers = { '@Hubro' },
    tier = 2,
  },
  kcl = {
    install_info = {
      revision = 'b0b2eb38009e04035a6e266c7e11e541f3caab7c',
      url = 'https://github.com/kcl-lang/tree-sitter-kcl',
    },
    maintainers = { '@bertbaron' },
    tier = 2,
  },
  kconfig = {
    install_info = {
      revision = '9ac99fe4c0c27a35dc6f757cef534c646e944881',
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
  kitty = {
    install_info = {
      revision = 'f821c16397ffab5b776d8781245215811438a624',
      url = 'https://github.com/OXY2DEV/tree-sitter-kitty',
    },
    maintainers = { '@OXY2DEV' },
    tier = 2,
  },
  kos = {
    install_info = {
      revision = '03b261c1a78b71c38cf4616497f253c4a4ce118b',
      url = 'https://github.com/kos-lang/tree-sitter-kos',
    },
    maintainers = { '@cdragan' },
    tier = 2,
  },
  kotlin = {
    install_info = {
      revision = '57fb4560ba8641865bc0baa6b3f413b236112c4c',
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
    },
    maintainers = { '@SalBakraa' },
    tier = 2,
  },
  koto = {
    install_info = {
      revision = 'f8b3f62c0eed185dca1559789e78759d4bee60e5',
      url = 'https://github.com/koto-lang/tree-sitter-koto',
    },
    maintainers = { '@irh' },
    tier = 2,
  },
  kusto = {
    install_info = {
      revision = '8353a1296607d6ba33db7c7e312226e5fc83e8ce',
      url = 'https://github.com/Willem-J-an/tree-sitter-kusto',
    },
    maintainers = { '@Willem-J-an' },
    tier = 2,
  },
  lalrpop = {
    install_info = {
      revision = '27b0f7bb55b4cabd8f01a933d9ee6a49dbfc2192',
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
    },
    maintainers = { '@traxys' },
    tier = 2,
  },
  latex = {
    install_info = {
      generate = true,
      revision = '7e0ecdc02926c7b9b2e0c76003d4fe7b0944f957',
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 2,
  },
  ledger = {
    install_info = {
      revision = '96c92d4908a836bf8f661166721c98439f8afb80',
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
    },
    maintainers = { '@cbarrete' },
    tier = 2,
  },
  leo = {
    install_info = {
      revision = '6bc5564917edacd070afc4d33cf5e2e677831ea9',
      url = 'https://github.com/r001/tree-sitter-leo',
    },
    maintainers = { '@r001' },
    tier = 2,
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
      revision = 'd6ebde3974742cd1b61b55d1d94aab1dacb41056',
      url = 'https://github.com/hankthetank27/tree-sitter-liquid',
    },
    maintainers = { '@hankthetank27' },
    tier = 2,
  },
  liquidsoap = {
    install_info = {
      revision = 'd092c65598e940564e12214ff7c2097528cfa159',
      url = 'https://github.com/savonet/tree-sitter-liquidsoap',
    },
    maintainers = { '@toots' },
    tier = 2,
  },
  llvm = {
    install_info = {
      revision = '2914786ae6774d4c4e25a230f4afe16aa68fe1c1',
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
    },
    maintainers = { '@benwilliamgraham' },
    tier = 2,
  },
  lua = {
    install_info = {
      revision = 'e40f5b6e6df9c2d1d6d664ff5d346a75d71ee6b2',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-lua',
    },
    maintainers = { '@muniftanjim' },
    tier = 2,
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
      revision = 'a8914d6c1fc5131f8e1c13f769fa704c9f5eb02f',
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
    tier = 2,
  },
  make = {
    install_info = {
      revision = '5e9e8f8ff3387b0edcaa90f46ddf3629f4cfeb1d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-make',
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },
  markdown = {
    install_info = {
      location = 'tree-sitter-markdown',
      revision = 'da063e1ba4303ff08781eb440cc9a7bd41e55dd8',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown',
    },
    maintainers = { '@MDeiml' },
    readme_note = 'basic highlighting',
    requires = { 'markdown_inline' },
    tier = 2,
  },
  markdown_inline = {
    install_info = {
      location = 'tree-sitter-markdown-inline',
      revision = 'da063e1ba4303ff08781eb440cc9a7bd41e55dd8',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown',
    },
    maintainers = { '@MDeiml' },
    readme_note = 'needed for full highlighting',
    tier = 2,
  },
  matlab = {
    install_info = {
      revision = 'f3eef66526fdae0469207d8e561fb5771eea1721',
      url = 'https://github.com/acristoffers/tree-sitter-matlab',
    },
    maintainers = { '@acristoffers' },
    tier = 2,
  },
  menhir = {
    install_info = {
      revision = 'be8866a6bcc2b563ab0de895af69daeffa88fe70',
      url = 'https://github.com/Kerl13/tree-sitter-menhir',
    },
    maintainers = { '@Kerl13' },
    tier = 2,
  },
  mermaid = {
    install_info = {
      revision = '90ae195b31933ceb9d079abfa8a3ad0a36fee4cc',
      url = 'https://github.com/monaqa/tree-sitter-mermaid',
    },
    tier = 2,
  },
  meson = {
    install_info = {
      revision = 'c84f3540624b81fc44067030afce2ff78d6ede05',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-meson',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  mlir = {
    install_info = {
      generate = true,
      revision = '4ab28ecdacef343af56c09b7981580503e49fadb',
      url = 'https://github.com/artagnon/tree-sitter-mlir',
    },
    maintainers = { '@artagnon' },
    tier = 2,
  },
  muttrc = {
    install_info = {
      revision = '173b0ab53a9c07962c9777189c4c70e90f1c1837',
      url = 'https://github.com/neomutt/tree-sitter-muttrc',
    },
    maintainers = { '@Freed-Wu' },
    tier = 2,
  },
  nasm = {
    install_info = {
      revision = 'd1b3638d017f2a8585e26dcfc66fe1df94185e30',
      url = 'https://github.com/naclsn/tree-sitter-nasm',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  nginx = {
    install_info = {
      revision = '47ade644d754cce57974aac44d2c9450e823d4f4',
      url = 'https://github.com/opa-oz/tree-sitter-nginx',
    },
    maintainers = { '@opa-oz' },
    tier = 2,
  },
  nickel = {
    install_info = {
      revision = 'a0a5d98a6f0edb5d00a18e62e7d1d02a5607c391',
      url = 'https://github.com/nickel-lang/tree-sitter-nickel',
    },
    tier = 2,
  },
  nim = {
    install_info = {
      revision = '9b4ede21a6ca866d29263f6b66c070961bc622b4',
      url = 'https://github.com/alaviss/tree-sitter-nim',
    },
    maintainers = { '@aMOPel' },
    requires = { 'nim_format_string' },
    tier = 2,
  },
  nim_format_string = {
    install_info = {
      revision = 'd45f75022d147cda056e98bfba68222c9c8eca3a',
      url = 'https://github.com/aMOPel/tree-sitter-nim-format-string',
    },
    maintainers = { '@aMOPel' },
    tier = 2,
  },
  ninja = {
    install_info = {
      revision = '0a95cfdc0745b6ae82f60d3a339b37f19b7b9267',
      url = 'https://github.com/alemuller/tree-sitter-ninja',
    },
    maintainers = { '@alemuller' },
    tier = 2,
  },
  nix = {
    install_info = {
      revision = 'eabf96807ea4ab6d6c7f09b671a88cd483542840',
      url = 'https://github.com/nix-community/tree-sitter-nix',
    },
    maintainers = { '@leo60228', '@mrcjkb', '@zimbatm' },
    tier = 2,
  },
  nqc = {
    install_info = {
      revision = '14e6da1627aaef21d2b2aa0c37d04269766dcc1d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-nqc',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  nu = {
    install_info = {
      revision = '4c149627cc592560f77ead1c384e27ec85926407',
      url = 'https://github.com/nushell/tree-sitter-nu',
    },
    maintainers = { '@abhisheksingh0x558' },
    tier = 2,
  },
  objc = {
    install_info = {
      revision = '181a81b8f23a2d593e7ab4259981f50122909fda',
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
    tier = 2,
  },
  ocaml = {
    install_info = {
      location = 'grammars/ocaml',
      revision = '3ef7c00b29e41e3a0c1d18e82ea37c64d72b93fc',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    tier = 2,
  },
  ocaml_interface = {
    install_info = {
      location = 'grammars/interface',
      revision = '3ef7c00b29e41e3a0c1d18e82ea37c64d72b93fc',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    requires = { 'ocaml' },
    tier = 2,
  },
  ocamllex = {
    install_info = {
      generate = true,
      revision = '33722b8be73079946a7c6dd9598e3f57956ed36d',
      url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
    },
    maintainers = { '@undu' },
    tier = 2,
  },
  odin = {
    install_info = {
      revision = 'd2ca8efb4487e156a60d5bd6db2598b872629403',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-odin',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  pascal = {
    install_info = {
      revision = '042119eca2e18a60e56317fb06ee3ba5c32cb447',
      url = 'https://github.com/Isopod/tree-sitter-pascal',
    },
    maintainers = { '@Isopod' },
    tier = 2,
  },
  passwd = {
    install_info = {
      revision = '20239395eacdc2e0923a7e5683ad3605aee7b716',
      url = 'https://github.com/ath3/tree-sitter-passwd',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  pem = {
    install_info = {
      revision = 'e525b177a229b1154fd81bc0691f943028d9e685',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pem',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  perl = {
    install_info = {
      branch = 'release',
      revision = '0c24d001dd1921e418fb933d208a7bd7dd3f923a',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 2,
  },
  php = {
    install_info = {
      location = 'php',
      revision = '7d07b41ce2d442ca9a90ed85d0075eccc17ae315',
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
      revision = '7d07b41ce2d442ca9a90ed85d0075eccc17ae315',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP without embedded HTML',
    tier = 2,
  },
  phpdoc = {
    install_info = {
      revision = '12d50307e6c02e5f4f876fa6cf2edea1f7808c0d',
      url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
    },
    maintainers = { '@mikehaertl' },
    tier = 2,
  },
  pioasm = {
    install_info = {
      revision = 'afece58efdb30440bddd151ef1347fa8d6f744a9',
      url = 'https://github.com/leo60228/tree-sitter-pioasm',
    },
    maintainers = { '@leo60228' },
    tier = 2,
  },
  pkl = {
    install_info = {
      revision = 'd9c591b4e770934fe15c2f1b3658f35553f6cb40',
      url = 'https://github.com/apple/tree-sitter-pkl',
    },
    maintainers = { '@ribru17' },
    tier = 2,
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
      revision = '0bf8387987c21bf2f8ed41d2575a8f22b139687f',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-pod',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 2,
  },
  poe_filter = {
    install_info = {
      revision = '205a7d576984feb38a9fc2d8cfe729617f9e0548',
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
      revision = '7212f47716ced384ac012b2cc428fd9f52f7c5d4',
      url = 'https://github.com/airbus-cert/tree-sitter-powershell',
    },
    maintainers = { '@L2jLiga' },
    tier = 2,
  },
  printf = {
    install_info = {
      revision = 'ec4e5674573d5554fccb87a887c97d4aec489da7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-printf',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  prisma = {
    install_info = {
      revision = '3556b2c1f20ec9ac91e92d32c43d9d2a0ca3cc49',
      url = 'https://github.com/victorhqc/tree-sitter-prisma',
    },
    maintainers = { '@elianiva' },
    tier = 2,
  },
  problog = {
    install_info = {
      location = 'grammars/problog',
      revision = 'd8d415f6a1cf80ca138524bcc395810b176d40fa',
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
    },
    maintainers = { '@foxyseta' },
    requires = { 'prolog' },
    tier = 2,
  },
  prolog = {
    install_info = {
      location = 'grammars/prolog',
      revision = 'd8d415f6a1cf80ca138524bcc395810b176d40fa',
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
    },
    maintainers = { '@foxyseta' },
    tier = 2,
  },
  promql = {
    install_info = {
      revision = '77625d78eebc3ffc44d114a07b2f348dff3061b0',
      url = 'https://github.com/MichaHoffmann/tree-sitter-promql',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 2,
  },
  properties = {
    install_info = {
      revision = '6310671b24d4e04b803577b1c675d765cbd5773b',
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
    tier = 2,
  },
  prql = {
    install_info = {
      revision = '09e158cd3650581c0af4c49c2e5b10c4834c8646',
      url = 'https://github.com/PRQL/tree-sitter-prql',
    },
    maintainers = { '@matthias-Q' },
    tier = 2,
  },
  psv = {
    install_info = {
      location = 'psv',
      revision = 'f6bf6e35eb0b95fbadea4bb39cb9709507fcb181',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },
  pug = {
    install_info = {
      revision = '13e9195370172c86a8b88184cc358b23b677cc46',
      url = 'https://github.com/zealot128/tree-sitter-pug',
    },
    maintainers = { '@zealot128' },
    tier = 2,
  },
  puppet = {
    install_info = {
      revision = '15f192929b7d317f5914de2b4accd37b349182a6',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-puppet',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  purescript = {
    install_info = {
      revision = 'f541f95ffd6852fbbe88636317c613285bc105af',
      url = 'https://github.com/postsolar/tree-sitter-purescript',
    },
    maintainers = { '@postsolar' },
    tier = 2,
  },
  pymanifest = {
    install_info = {
      revision = 'debbdb83fe6356adc7261c41c69b45ba49c97294',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pymanifest',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'PyPA manifest',
    tier = 2,
  },
  python = {
    install_info = {
      revision = 'v0.25.0',
      url = 'https://github.com/tree-sitter/tree-sitter-python',
    },
    maintainers = { '@stsewd', '@theHamsta' },
    tier = 1,
  },
  ql = {
    install_info = {
      revision = '1fd627a4e8bff8c24c11987474bd33112bead857',
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
      revision = '0bec4359a7eb2f6c9220cd57372d87d236f66d59',
      url = 'https://github.com/yuja/tree-sitter-qmljs',
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
    tier = 2,
  },
  query = {
    install_info = {
      revision = '6350ad724e7b17a7eea712d4860b4d2ae892e0b6',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-query',
    },
    maintainers = { '@steelsojka' },
    readme_note = 'Tree-sitter query language',
    tier = 2,
  },
  r = {
    install_info = {
      revision = '0e6ef7741712c09dc3ee6e81c42e919820cc65ef',
      url = 'https://github.com/r-lib/tree-sitter-r',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  racket = {
    install_info = {
      revision = '56b57807f86aa4ddb14892572b318edd4bc90ebe',
      url = 'https://github.com/6cdh/tree-sitter-racket',
    },
    tier = 2,
  },
  ralph = {
    install_info = {
      revision = 'f6d81bf7a4599c77388035439cf5801cd461ff77',
      url = 'https://github.com/alephium/tree-sitter-ralph',
    },
    maintainers = { '@tdroxler' },
    tier = 2,
  },
  rasi = {
    install_info = {
      revision = 'e735c6881d8b475aaa4ef8f0a2bdfd825b438143',
      url = 'https://github.com/Fymyte/tree-sitter-rasi',
    },
    maintainers = { '@Fymyte' },
    tier = 2,
  },
  razor = {
    install_info = {
      revision = 'fe46ce5ea7d844e53d59bc96f2175d33691c61c5',
      url = 'https://github.com/tris203/tree-sitter-razor',
    },
    maintainers = { '@tris203' },
    tier = 2,
  },
  rbs = {
    install_info = {
      revision = '5282e2f36d4109f5315c1d9486b5b0c2044622bb',
      url = 'https://github.com/joker1007/tree-sitter-rbs',
    },
    maintainers = { '@joker1007' },
    tier = 2,
  },
  re2c = {
    install_info = {
      revision = 'c18a3c2f4b6665e35b7e50d6048ea3cff770c572',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-re2c',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  readline = {
    install_info = {
      revision = '6b744c527aebd12e46a5ecb3aebdb8d621a8e83e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-readline',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  regex = {
    install_info = {
      revision = 'b2ac15e27fce703d2f37a79ccd94a5c0cbe9720b',
      url = 'https://github.com/tree-sitter/tree-sitter-regex',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  rego = {
    install_info = {
      revision = 'ddd39af81fe8b0288102a7cb97959dfce723e0f3',
      url = 'https://github.com/FallenAngel97/tree-sitter-rego',
    },
    maintainers = { '@FallenAngel97' },
    tier = 2,
  },
  requirements = {
    install_info = {
      revision = 'caeb2ba854dea55931f76034978de1fd79362939',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-requirements',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'pip requirements',
    tier = 2,
  },
  rescript = {
    install_info = {
      revision = '5938ae1578aa559b4fa903f7cabc31da14f71c84',
      url = 'https://github.com/rescript-lang/tree-sitter-rescript',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  rifleconf = {
    install_info = {
      revision = '6389ef0fc0d48f0397ec233109c074a0cb685e36',
      url = 'https://github.com/purarue/tree-sitter-rifleconf',
    },
    maintainers = { '@purarue' },
    tier = 2,
  },
  rnoweb = {
    install_info = {
      revision = '1a74dc0ed731ad07db39f063e2c5a6fe528cae7f',
      url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
    },
    maintainers = { '@bamonroe' },
    tier = 2,
  },
  robot = {
    install_info = {
      revision = 'e34def7cb0d8a66a59ec5057fe17bb4e6b17b56a',
      url = 'https://github.com/Hubro/tree-sitter-robot',
    },
    maintainers = { '@Hubro' },
    tier = 2,
  },
  robots_txt = {
    install_info = {
      revision = '0c066107e3548de79316a6a4ec771e2f7cf7c468',
      url = 'https://github.com/opa-oz/tree-sitter-robots-txt',
    },
    maintainers = { '@opa-oz' },
    tier = 2,
  },
  roc = {
    install_info = {
      revision = '40e52f343f1b1f270d6ecb2ca898ca9b8cba6936',
      url = 'https://github.com/faldor20/tree-sitter-roc',
    },
    maintainers = { '@nat-418' },
    tier = 2,
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
      revision = '4e562e1598b95b93db4f3f64fe40ddefbc677a15',
      url = 'https://github.com/stsewd/tree-sitter-rst',
    },
    maintainers = { '@stsewd' },
    tier = 2,
  },
  ruby = {
    install_info = {
      revision = '89bd7a8e5450cb6a942418a619d30469f259e5d6',
      url = 'https://github.com/tree-sitter/tree-sitter-ruby',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  runescript = {
    install_info = {
      revision = 'cf85bbd5da0c5ad243301d889c7f84d790a4cae4',
      url = 'https://github.com/2004Scape/tree-sitter-runescript',
    },
    maintainers = { '@2004Scape' },
    tier = 2,
  },
  rust = {
    install_info = {
      revision = '261b20226c04ef601adbdf185a800512a5f66291',
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  scala = {
    install_info = {
      revision = '97aead18d97708190a51d4f551ea9b05b60641c9',
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
    },
    maintainers = { '@stevanmilic' },
    tier = 2,
  },
  scfg = {
    install_info = {
      revision = 'd850fd470445d73de318a21d734d1e09e29b773c',
      url = 'https://github.com/rockorager/tree-sitter-scfg',
    },
    maintainers = { '@WhyNotHugo' },
    tier = 2,
  },
  scheme = {
    install_info = {
      revision = 'b5c701148501fa056302827442b5b4956f1edc03',
      url = 'https://github.com/6cdh/tree-sitter-scheme',
    },
    tier = 2,
  },
  scss = {
    install_info = {
      revision = 'c478c6868648eff49eb04a4df90d703dc45b312a',
      url = 'https://github.com/serenadeai/tree-sitter-scss',
    },
    maintainers = { '@elianiva' },
    requires = { 'css' },
    tier = 2,
  },
  sflog = {
    install_info = {
      location = 'sflog',
      revision = '3597575a429766dd7ecce9f5bb97f6fec4419d5d',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiaofinland' },
    readme_note = 'Salesforce debug log',
    tier = 2,
  },
  slang = {
    install_info = {
      revision = '1dbcc4abc7b3cdd663eb03d93031167d6ed19f56',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-slang',
    },
    maintainers = { '@theHamsta' },
    readme_note = 'Shader Slang',
    tier = 2,
  },
  slim = {
    install_info = {
      revision = 'a06113f5175b805a37d20df0a6f9d722e0ab6cfe',
      url = 'https://github.com/theoo/tree-sitter-slim',
    },
    maintainers = { '@theoo' },
    tier = 2,
  },
  slint = {
    install_info = {
      revision = '10fb0f188d7950400773c06ba6c31075866e14bf',
      url = 'https://github.com/slint-ui/tree-sitter-slint',
    },
    maintainers = { '@hunger' },
    tier = 2,
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
      revision = 'ec4fe14586f2b0a1bc65d6db17f8d8acd8a90433',
      url = 'https://github.com/indoorvivants/tree-sitter-smithy',
    },
    maintainers = { '@amaanq', '@keynmol' },
    tier = 2,
  },
  snakemake = {
    install_info = {
      revision = '68010430c3e51c0e84c1ce21c6551df0e2469f51',
      url = 'https://github.com/osthomas/tree-sitter-snakemake',
    },
    maintainers = { '@osthomas' },
    tier = 2,
  },
  snl = {
    install_info = {
      revision = '846e2d6809ac5863a15b5494f20fd267c21221c8',
      url = 'https://github.com/minijackson/tree-sitter-snl',
    },
    maintainers = { '@minijackson' },
    readme_note = "EPICS Sequencer's SNL files",
    tier = 2,
  },
  solidity = {
    install_info = {
      revision = '4e938a46c7030dd001bc99e1ac0f0c750ac98254',
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  soql = {
    install_info = {
      location = 'soql',
      revision = '3597575a429766dd7ecce9f5bb97f6fec4419d5d',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 2,
  },
  sosl = {
    install_info = {
      location = 'sosl',
      revision = '3597575a429766dd7ecce9f5bb97f6fec4419d5d',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 2,
  },
  sourcepawn = {
    install_info = {
      revision = '5a8fdd446b516c81e218245c12129c6ad4bccfa2',
      url = 'https://github.com/nilshelmig/tree-sitter-sourcepawn',
    },
    maintainers = { '@Sarrus1' },
    tier = 2,
  },
  sparql = {
    install_info = {
      revision = '1ef52d35a73a2a5f2e433ecfd1c751c1360a923b',
      url = 'https://github.com/GordianDziwis/tree-sitter-sparql',
    },
    maintainers = { '@GordianDziwis' },
    tier = 2,
  },
  sproto = {
    install_info = {
      revision = 'd554c1456e35e7b2690552d52921c987d0cf6799',
      url = 'https://github.com/hanxi/tree-sitter-sproto',
    },
    maintainers = { '@hanxi' },
    tier = 2,
  },
  sql = {
    install_info = {
      branch = 'gh-pages',
      revision = '86e3d03837d282544439620eb74d224586074b8b',
      url = 'https://github.com/derekstride/tree-sitter-sql',
    },
    maintainers = { '@derekstride' },
    tier = 2,
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
      revision = '71d2693deadaca8cdc09e38ba41d2f6042da1616',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ssh-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  starlark = {
    install_info = {
      revision = 'a453dbf3ba433db0e5ec621a38a7e59d72e4dc69',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-starlark',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  strace = {
    install_info = {
      revision = 'ac874ddfcc08d689fee1f4533789e06d88388f29',
      url = 'https://github.com/sigmaSd/tree-sitter-strace',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  styled = {
    install_info = {
      revision = '319cdcaa0346ba6db668a222d938e5c3569e2a51',
      url = 'https://github.com/mskelton/tree-sitter-styled',
    },
    maintainers = { '@mskelton' },
    tier = 2,
  },
  supercollider = {
    install_info = {
      revision = '76b3cab1773f08bb7d3a185420b0a44c6da8c294',
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
    },
    maintainers = { '@madskjeldgaard' },
    tier = 2,
  },
  superhtml = {
    install_info = {
      location = 'tree-sitter-superhtml',
      revision = '8b5bb272b269afdd38cdf641c4a707dd92fbe902',
      url = 'https://github.com/kristoff-it/superhtml',
    },
    maintainers = { '@rockorager' },
    tier = 2,
  },
  surface = {
    install_info = {
      revision = 'f4586b35ac8548667a9aaa4eae44456c1f43d032',
      url = 'https://github.com/connorlay/tree-sitter-surface',
    },
    maintainers = { '@connorlay' },
    tier = 2,
  },
  svelte = {
    install_info = {
      revision = 'ae5199db47757f785e43a14b332118a5474de1a2',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-svelte',
    },
    maintainers = { '@amaanq' },
    requires = { 'html_tags' },
    tier = 2,
  },
  sway = {
    install_info = {
      revision = '9b7845ce06ecb38b040c3940970b4fd0adc331d1',
      url = 'https://github.com/FuelLabs/tree-sitter-sway.git',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  swift = {
    install_info = {
      generate = true,
      revision = 'c7287392d610ca9d7c80f9edd2c6ef8f518b377b',
      url = 'https://github.com/alex-pinkus/tree-sitter-swift',
    },
    maintainers = { '@alex-pinkus' },
    tier = 2,
  },
  sxhkdrc = {
    install_info = {
      revision = '440d5f913d9465c9c776a1bd92334d32febcf065',
      url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
    },
    maintainers = { '@RaafatTurki' },
    tier = 2,
  },
  systemtap = {
    install_info = {
      revision = 'f2b378a9af0b7e1192cff67a5fb45508c927205d',
      url = 'https://github.com/ok-ryoko/tree-sitter-systemtap',
    },
    maintainers = { '@ok-ryoko' },
    tier = 2,
  },
  systemverilog = {
    install_info = {
      revision = '7c4b01b7df2f6e7fa1f698c9d30ac8f93af18ed2',
      url = 'https://github.com/gmlarumbe/tree-sitter-systemverilog',
    },
    maintainers = { '@zhangwwpeng' },
    tier = 2,
  },
  t32 = {
    install_info = {
      revision = '5b5e4336731bda5ea2e6b78b6a2d9e7a89032b75',
      url = 'https://github.com/xasc/tree-sitter-t32',
    },
    maintainers = { '@xasc' },
    tier = 2,
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
      revision = 'a6267c2091ed432c248780cec9f8d42c8766d9ad',
      url = 'https://github.com/tact-lang/tree-sitter-tact',
    },
    maintainers = { '@novusnota' },
    tier = 2,
  },
  tcl = {
    install_info = {
      revision = '8f11ac7206a54ed11210491cee1e0657e2962c47',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tcl',
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },
  teal = {
    install_info = {
      generate = true,
      revision = '05d276e737055e6f77a21335b7573c9d3c091e2f',
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
    },
    maintainers = { '@euclidianAce' },
    tier = 2,
  },
  templ = {
    install_info = {
      revision = '1c6db04effbcd7773c826bded9783cbc3061bd55',
      url = 'https://github.com/vrischmann/tree-sitter-templ',
    },
    maintainers = { '@vrischmann' },
    tier = 2,
  },
  tera = {
    install_info = {
      revision = '3a38c368e806268daac9923a27e72bcafbbc16bb',
      url = 'https://github.com/uncenter/tree-sitter-tera',
    },
    maintainers = { '@uncenter' },
    tier = 2,
  },
  terraform = {
    install_info = {
      location = 'dialects/terraform',
      revision = '64ad62785d442eb4d45df3a1764962dafd5bc98b',
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    requires = { 'hcl' },
    tier = 2,
  },
  textproto = {
    install_info = {
      revision = '568471b80fd8793d37ed01865d8c2208a9fefd1b',
      url = 'https://github.com/PorterAtGoogle/tree-sitter-textproto',
    },
    maintainers = { '@Porter' },
    tier = 2,
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
      revision = '4a77b2d7a004587646bddc4e854779044b6db459',
      url = 'https://github.com/ambroisie/tree-sitter-tiger',
    },
    maintainers = { '@ambroisie' },
    tier = 2,
  },
  tlaplus = {
    install_info = {
      revision = '8d749f9a598b47b7110c7340006c8eb8a9552566',
      url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
    },
    maintainers = { '@ahelwer', '@susliko' },
    tier = 2,
  },
  tmux = {
    install_info = {
      revision = '75d1b995b0c23400ac8e49db757a2e0386f9fa8f',
      url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
    },
    maintainers = { '@Freed-Wu', '@stevenxxiu' },
    tier = 2,
  },
  todotxt = {
    install_info = {
      revision = '3937c5cd105ec4127448651a21aef45f52d19609',
      url = 'https://github.com/arnarg/tree-sitter-todotxt',
    },
    maintainers = { '@arnarg' },
    tier = 2,
  },
  toml = {
    install_info = {
      revision = '64b56832c2cffe41758f28e05c756a3a98d16f41',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-toml',
    },
    maintainers = { '@tk-shirasaka' },
    tier = 2,
  },
  tsv = {
    install_info = {
      location = 'tsv',
      revision = 'f6bf6e35eb0b95fbadea4bb39cb9709507fcb181',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  tsx = {
    install_info = {
      location = 'tsx',
      revision = '75b3874edb2dc714fb1fd77a32013d0f8699989f',
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
    tier = 2,
  },
  twig = {
    install_info = {
      revision = '7195ee573ab5c3b3bb0e91b042e6f83ac1b11104',
      url = 'https://github.com/gbprod/tree-sitter-twig',
    },
    maintainers = { '@gbprod' },
    tier = 2,
  },
  typescript = {
    install_info = {
      location = 'typescript',
      revision = '75b3874edb2dc714fb1fd77a32013d0f8699989f',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma' },
    tier = 2,
  },
  typespec = {
    install_info = {
      revision = '395bef1e1eb4dd18365401642beb534e8a244056',
      url = 'https://github.com/happenslol/tree-sitter-typespec',
    },
    maintainers = { '@happenslol' },
    tier = 2,
  },
  typoscript = {
    install_info = {
      revision = '1811c767f3f72be669891b524a07c58b1eb0db87',
      url = 'https://github.com/Teddytrombone/tree-sitter-typoscript',
    },
    maintainers = { '@Teddytrombone' },
    tier = 2,
  },
  typst = {
    install_info = {
      revision = '46cf4ded12ee974a70bf8457263b67ad7ee0379d',
      url = 'https://github.com/uben0/tree-sitter-typst',
    },
    maintainers = { '@uben0', '@RaafatTurki' },
    tier = 2,
  },
  udev = {
    install_info = {
      revision = '2fcb563a4d56a6b8e8c129252325fc6335e4acbf',
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
      revision = '169e7f748a540ec360c0cb086b448faad012caa4',
      url = 'https://github.com/kylegoetz/tree-sitter-unison',
    },
    maintainers = { '@tapegram' },
    tier = 2,
  },
  usd = {
    install_info = {
      revision = '4e0875f724d94d0c2ff36f9b8cb0b12f8b20d216',
      url = 'https://github.com/ColinKennedy/tree-sitter-usd',
    },
    maintainers = { '@ColinKennedy' },
    tier = 2,
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
      revision = '9cf6a37689f06b17d170dec644ace81eb8eab280',
      url = 'https://github.com/vlang/v-analyzer',
    },
    maintainers = { '@kkharji', '@amaanq' },
    tier = 2,
  },
  vala = {
    install_info = {
      revision = '97e6db3c8c73b15a9541a458d8e797a07f588ef4',
      url = 'https://github.com/vala-lang/tree-sitter-vala',
    },
    maintainers = { '@Prince781' },
    tier = 2,
  },
  vento = {
    install_info = {
      revision = '3b32474bc29584ea214e4e84b47102408263fe0e',
      url = 'https://github.com/ventojs/tree-sitter-vento',
    },
    maintainers = { '@wrapperup', '@oscarotero' },
    tier = 2,
  },
  vhdl = {
    install_info = {
      revision = '674ed9fe6c13c79c0e7407daaf4518d053e6f0f4',
      url = 'https://github.com/jpt13653903/tree-sitter-vhdl',
    },
    maintainers = { '@jpt13653903' },
    tier = 2,
  },
  vhs = {
    install_info = {
      revision = '0c6fae9d2cfc5b217bfd1fe84a7678f5917116db',
      url = 'https://github.com/charmbracelet/tree-sitter-vhs',
    },
    maintainers = { '@caarlos0' },
    tier = 2,
  },
  vim = {
    install_info = {
      revision = '1cd0a0892b389bd314a9bd09545160e5ee3c9137',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-vim',
    },
    maintainers = { '@clason' },
    tier = 2,
  },
  vimdoc = {
    install_info = {
      revision = 'f061895a0eff1d5b90e4fb60d21d87be3267031a',
      url = 'https://github.com/neovim/tree-sitter-vimdoc',
    },
    maintainers = { '@clason' },
    tier = 2,
  },
  vrl = {
    install_info = {
      revision = '274b3ce63f72aa8ffea18e7fc280d3062d28f0ba',
      url = 'https://github.com/belltoy/tree-sitter-vrl',
    },
    maintainers = { '@belltoy' },
    tier = 2,
  },
  vue = {
    install_info = {
      branch = 'main',
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
    tier = 2,
  },
  wgsl_bevy = {
    install_info = {
      revision = 'd9306a798ede627001a8e5752f775858c8edd7e4',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  wing = {
    install_info = {
      revision = '76e0c25844a66ebc6e866d690fcc5f4e90698947',
      url = 'https://github.com/winglang/tree-sitter-wing',
    },
    maintainers = { '@gshpychka', '@MarkMcCulloh' },
    tier = 2,
  },
  wit = {
    install_info = {
      revision = 'v1.2.0',
      url = 'https://github.com/bytecodealliance/tree-sitter-wit',
    },
    maintainers = { '@mkatychev' },
    tier = 1,
  },
  wxml = {
    install_info = {
      revision = '7b821c748dc410332f59496c0dea2632168c4e5a',
      url = 'https://github.com/BlockLune/tree-sitter-wxml',
    },
    maintainers = { '@BlockLune' },
    tier = 2,
  },
  xcompose = {
    install_info = {
      revision = 'a51d6366f041dbefec4da39a7eb3168a9b1cbc0e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xcompose',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  xml = {
    install_info = {
      location = 'xml',
      revision = '5000ae8f22d11fbe93939b05c1e37cf21117162d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'dtd' },
    tier = 2,
  },
  xresources = {
    install_info = {
      revision = 'a81f1ea4478d03c223ef7eace535a36220bddd8c',
      url = 'https://github.com/ValdezFOmar/tree-sitter-xresources',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 2,
  },
  yaml = {
    install_info = {
      revision = '7708026449bed86239b1cd5bce6e3c34dbca6415',
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
    tier = 2,
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
    tier = 2,
  },
  zig = {
    install_info = {
      revision = '6479aa13f32f701c383083d8b28360ebd682fb7d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-zig',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  ziggy = {
    install_info = {
      location = 'tree-sitter-ziggy',
      revision = '4353b20ef2ac750e35c6d68e4eb2a07c2d7cf901',
      url = 'https://github.com/kristoff-it/ziggy',
    },
    tier = 3,
  },
  ziggy_schema = {
    install_info = {
      location = 'tree-sitter-ziggy-schema',
      revision = '4353b20ef2ac750e35c6d68e4eb2a07c2d7cf901',
      url = 'https://github.com/kristoff-it/ziggy',
    },
    tier = 3,
  },
  zsh = {
    install_info = {
      revision = 'v0.53.0',
      url = 'https://github.com/georgeharker/tree-sitter-zsh',
    },
    maintainers = { '@georgeharker' },
    tier = 1,
  },
}
