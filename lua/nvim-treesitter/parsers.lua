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
      revision = 'b9b32fa042c2952a7bfca86847ea325e44ccc897',
      url = 'https://github.com/tree-sitter/tree-sitter-agda',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  angular = {
    install_info = {
      generate_from_json = true,
      revision = '745d3c65c2294aca1110b6b6ad6805124be605c9',
      url = 'https://github.com/dlvandenberg/tree-sitter-angular',
    },
    maintainers = { '@dlvandenberg' },
    requires = { 'html', 'html_tags' },
    tier = 3,
  },
  apex = {
    install_info = {
      location = 'apex',
      revision = 'eade4054efc897f4bb18a5b7bf4b5a824dbffa74',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  arduino = {
    install_info = {
      generate_from_json = true,
      revision = '017696bdf47ca2b10948c5a511f9ab387722d0f3',
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
      revision = '0ad33e32ae9726e151d16ca20ba3e507ff65e01f',
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
      revision = '34bbdc7cce8e803096f47b625979e34c1be38127',
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
    },
    tier = 4,
  },
  bash = {
    install_info = {
      revision = 'a985bd2d14d249b8f583343ad21aeb13c50c85e8',
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
      revision = '9bc460a05b5f096d69568b5fb36105032ff4ff97',
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
      url = 'https://github.com/EmranMR/tree-sitter-blade',
      files = { 'src/parser.c' },
    },
    maintainers = { '@calebdw' },
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
      revision = '16c43068ec30828c5aed11e87262c56f36782595',
      url = 'https://github.com/ambroisie/tree-sitter-bp',
    },
    maintainers = { '@ambroisie' },
    readme_note = 'Android Blueprint',
    tier = 3,
  },
  brightscript = {
    install_info = {
      url = 'https://github.com/ajdelcimmuto/tree-sitter-brightscript',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ajdelcimmuto' },
    tier = 2,
  },
  c = {
    install_info = {
      revision = '492f7aaa37560204856a2b3f775398b66ba09f31',
      url = 'https://github.com/tree-sitter/tree-sitter-c',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },
  c_sharp = {
    install_info = {
      revision = '2c31cc87640ab6ad74fb408c0cf1262ce54da5bb',
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
  caddy = {
    install_info = {
      url = 'https://github.com/opa-oz/tree-sitter-caddy',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@opa-oz' },
    tier = 3,
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
      revision = 'b4cbe9ab7672d5106e9550d8413835395a1be362',
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
    tier = 3,
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
      revision = 'e409ae33f00e04cde30f2bcffb979caf1a33562a',
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
      revision = 'a352ed85f733f9c6cc458fe5a82bcd4c00f70eab',
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  css = {
    install_info = {
      revision = '6731f030693d3698ad94865ed0228fe45df07e30',
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
      revision = '757e0a61f9d38b3d9eaa299e8d866e8283ffc284',
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
  cylc = {
    install_info = {
      revision = '8b895c278f98d05e67997f5e3a43fb5531933023',
      url = 'https://github.com/elliotfontaine/tree-sitter-cylc',
    },
    maintainers = { '@elliotfontaine' },
    tier = 3,
  },
  d = {
    install_info = {
      revision = '45e5f1e9d6de2c68591bc8e5ec662cf18e950b4a',
      url = 'https://github.com/gdamore/tree-sitter-d',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  dart = {
    install_info = {
      revision = 'e81af6ab94a728ed99c30083be72d88e6d56cf9e',
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
    },
    maintainers = { '@akinsho' },
    tier = 3,
  },
  desktop = {
    install_info = {
      revision = '54133af61b2a9a75fd42c49ce0c771115f81f50b',
      url = 'https://github.com/ValdezFOmar/tree-sitter-desktop',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  devicetree = {
    install_info = {
      revision = '16f640f3c59117c9e749d581634afdb00e004f4c',
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
    },
    maintainers = { '@jedrzejboczar' },
    tier = 3,
  },
  dhall = {
    install_info = {
      revision = '4a6c08abfb54827db4e722d6cdca81b093898988',
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  diff = {
    install_info = {
      revision = 'e42b8def4f75633568f1aecfe01817bf15164928',
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
      revision = '971acdd908568b4531b0ba28a445bf0bb720aba5',
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
      revision = 'ce150c5be7f617e18ffa2064213e5d9c4cb5d69e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  earthfile = {
    install_info = {
      revision = 'a44f6f6d22ea4fe16fa37ababd90240ab87a9e0d',
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
      revision = '02f562e71dc28d573187809eecdffaee7c82321c',
      url = 'https://github.com/ValdezFOmar/tree-sitter-editorconfig',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  eds = {
    install_info = {
      revision = '26d529e6cfecde391a03c21d1474eb51e0285805',
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
      revision = '0e8eb7fc1dfb3d855398870827a9866a1529a5e4',
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  elm = {
    install_info = {
      revision = 'e34bdc5c512918628b05b48e633f711123204e45',
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
      revision = '8495d106154741e6d35d37064f864758ece75de6',
      url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
    },
    tier = 4,
  },
  enforce = {
    install_info = {
      url = 'https://github.com/simonvic/tree-sitter-enforce',
      files = { 'src/parser.c' },
    },
    maintainers = { '@simonvic' },
    tier = 3,
  },
  erlang = {
    install_info = {
      revision = '981fda038d2eb182a88a9374ccb1c14b840cba0b',
      url = 'https://github.com/WhatsApp/tree-sitter-erlang',
    },
    maintainers = { '@filmor' },
    tier = 3,
  },
  facility = {
    install_info = {
      revision = 'e4bfd3e960de9f4b4648acb1c92e9b95b47d8cfb',
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
      revision = '70640c0696abde32622afc43291a385681afbd32',
      url = 'https://github.com/ram02z/tree-sitter-fish',
    },
    maintainers = { '@ram02z' },
    tier = 3,
  },
  foam = {
    install_info = {
      revision = 'f08bb76892b93e5b23c45ac3bd6b1eea5df323cc',
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
      revision = '022b032d31299c5d8336cdfd0ece97de20a609c0',
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
  fsharp = {
    install_info = {
      location = 'fsharp',
      revision = '207f1c988f4649e12fe207e4a7e4f83b9da037d1',
      url = 'https://github.com/ionide/tree-sitter-fsharp',
    },
    maintainers = { '@nsidorenco' },
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
      revision = '7db79590d2f8b0e0246008ecfd569b4bfca587a9',
      url = 'https://github.com/gap-system/tree-sitter-gap',
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system',
    tier = 3,
  },
  gaptst = {
    install_info = {
      revision = '69086d7627c03e1f4baf766bcef14c60d9e92331',
      url = 'https://github.com/gap-system/tree-sitter-gaptst',
    },
    maintainers = { '@reiniscirpons' },
    readme_note = 'GAP system test files',
    requires = { 'gap' },
    tier = 3,
  },
  gdscript = {
    install_info = {
      revision = '48b49330888a4669b48619b211cc8da573827725',
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
      revision = '5425944fd61bf2b3bad2c17c2dc9f53172b0f01d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gitattributes',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  gitcommit = {
    install_info = {
      revision = 'db0e0c4fb9095fdc42a7af34019c0616c071e9eb',
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
      revision = '066704e4826699e754d351e3bbe12bf2e51de9d8',
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
      generate_from_json = true,
      revision = '7e8ea8cf39fc360cb97bd253442cd48e4f7a9ce3',
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript',
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'ecma' },
    tier = 3,
  },
  glimmer_typescript = {
    install_info = {
      generate_from_json = true,
      revision = '4006128790efb58ca82a4492d8ef0983b260fc6a',
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript',
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'typescript' },
    tier = 3,
  },
  glsl = {
    install_info = {
      generate_from_json = true,
      revision = '66aec57f7119c7e8e40665b723cd7af5594f15ee',
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
    tier = 3,
  },
  go = {
    install_info = {
      revision = '7cb21a65af6cc8e5c6742b9dba42881ea1158475',
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
      revision = '941955d027f1d8530501e77ce5e1d6035f5f99c1',
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
    tier = 3,
  },
  gomod = {
    install_info = {
      revision = '6efb59652d30e0e9cd5f3b3a669afd6f1a926d3c',
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
      revision = 'ab4a8c4a51f271f320f2bad6a5d499415bf541b1',
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
      revision = '63e80cfe1302da9f9c7ee8d9df295f47d7d181bf',
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
  gren = {
    install_info = {
      revision = '76554f4f2339f5a24eed19c58f2079b51c694152',
      url = 'https://github.com/MaeBrooks/tree-sitter-gren',
    },
    maintainers = { '@MaeBrooks' },
    tier = 3,
  },
  groovy = {
    install_info = {
      revision = '86911590a8e46d71301c66468e5620d9faa5b6af',
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
      revision = 'bc5b3a10d6d27e8220a113a9a7fe9bec0a1574b0',
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
      revision = '2c2fcb22e3b939ed59ae8d6f10500c3213c68670',
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
      revision = 'a63c69c20fd88d1e5614a02b4a6b48cfb7e54a45',
      url = 'https://github.com/connorlay/tree-sitter-heex',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  helm = {
    install_info = {
      location = 'dialects/helm',
      revision = 'ab4a8c4a51f271f320f2bad6a5d499415bf541b1',
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
      revision = 'b309425a7ab4456605cfe78774b80f7e275ca87d',
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
      revision = '1545137aadcc63660c47db9ad98d02fa602655d0',
      url = 'https://github.com/urbit-pilled/tree-sitter-hoon',
    },
    maintainers = { '@urbit-pilled' },
    tier = 3,
  },
  html = {
    install_info = {
      revision = 'd18f83f8bed0be99796c4eacafe9b295ab2ee144',
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
      revision = 'd2e4e4c7d03f70e0465d436f2b5f67497cd544ca',
      url = 'https://github.com/rest-nvim/tree-sitter-http',
    },
    maintainers = { '@amaanq', '@NTBBloodbath' },
    tier = 3,
  },
  hurl = {
    install_info = {
      revision = 'ff07a42d9ec95443b5c1b57ed793414bf7b79be5',
      url = 'https://github.com/pfeiferj/tree-sitter-hurl',
    },
    maintainers = { '@pfeiferj' },
    tier = 3,
  },
  hyprlang = {
    install_info = {
      revision = 'd719158abe537b1916daaea6fa03287089f0b601',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hyprlang',
    },
    maintainers = { '@luckasRanarison' },
    tier = 2,
  },
  idl = {
    install_info = {
      revision = '86ff7f19747a761dc8ba72f4045fd64aed94ba4c',
      url = 'https://github.com/cathaysia/tree-sitter-idl',
    },
    maintainers = { '@cathaysia' },
    tier = 3,
  },
  idris = {
    install_info = {
      revision = 'c56a25cf57c68ff929356db25505c1cc4c7820f6',
      url = 'https://github.com/kayhide/tree-sitter-idris',
    },
    maintainers = { '@srghma' },
    tier = 3,
  },
  ini = {
    install_info = {
      revision = '962568c9efa71d25720ab42c5d36e222626ef3a6',
      url = 'https://github.com/justinmk/tree-sitter-ini',
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },
  inko = {
    install_info = {
      revision = '0b08a8f976456a9271f70d4682143328d7224115',
      url = 'https://github.com/inko-lang/tree-sitter-inko',
    },
    maintainers = { '@yorickpeterse' },
    tier = 3,
  },
  ipkg = {
    install_info = {
      revision = '8d3e9782f2d091d0cd39c13bfb3068db0c675960',
      url = 'https://github.com/srghma/tree-sitter-ipkg',
    },
    maintainers = { '@srghma' },
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
      revision = 'ca4785b47a4ff15653f0408a49c764dec533e0d3',
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
    },
    maintainers = { '@sogaiu' },
    tier = 3,
  },
  java = {
    install_info = {
      revision = '677da92875756e31b3a42505d822cc8be7c5ab5e',
      url = 'https://github.com/tree-sitter/tree-sitter-java',
    },
    maintainers = { '@p00f' },
    tier = 2,
  },
  javadoc = {
    install_info = {
      url = 'https://github.com/rmuir/tree-sitter-javadoc',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@rmuir' },
    tier = 2,
  },
  javascript = {
    install_info = {
      revision = '3f1c835d05165050834da0e3cbc23a75e94aaa64',
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
    tier = 2,
  },
  jinja = {
    install_info = {
      url = 'https://github.com/cathaysia/tree-sitter-jinja',
      location = 'tree-sitter-jinja',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@cathaysia' },
    readme_note = 'basic highlighting',
    requires = { 'jinja_inline' },
    tier = 3,
  },
  jinja_inline = {
    install_info = {
      url = 'https://github.com/cathaysia/tree-sitter-jinja',
      location = 'tree-sitter-jinja_inline',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@cathaysia' },
    readme_note = 'needed for full highlighting',
    tier = 3,
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
      revision = 'a417db5dbdd869fccb6a8b75ec04459e1d4ccd2c',
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json = {
    install_info = {
      revision = '54ccd9485e0122a5e9faf5d8aaed7294c308e894',
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
      revision = 'ffdd9fe4dccdc26d62ce1654fceac52c394f0cf3',
      url = 'https://github.com/tree-sitter/tree-sitter-julia',
    },
    maintainers = { '@fredrikekre' },
    tier = 3,
  },
  just = {
    install_info = {
      revision = 'bb0c898a80644de438e6efe5d88d30bf092935cd',
      url = 'https://github.com/IndianBoy42/tree-sitter-just',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  kcl = {
    install_info = {
      url = 'https://github.com/kcl-lang/tree-sitter-kcl',
      files = { 'src/parser.c', 'src/scanner.c' },
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
  kotlin = {
    install_info = {
      revision = 'c4ddea359a7ff4d92360b2efcd6cfce5dc25afe6',
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
    },
    maintainers = { '@SalBakraa' },
    tier = 3,
  },
  koto = {
    install_info = {
      revision = '329b0e84ef6cc6950665de4accd0bdda1601a2f1',
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
      revision = 'a7f5ea297bd621d072ed4cb2cc8ba5ae64ae3c4b',
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
    },
    maintainers = { '@traxys' },
    tier = 3,
  },
  latex = {
    install_info = {
      generate = true,
      revision = '7b06f6ed394308e7407a1703d2724128c45fc9d7',
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },
  ledger = {
    install_info = {
      revision = 'd313153eef68c557ba4538b20de2d0e92f3ef6f8',
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
    },
    maintainers = { '@cbarrete' },
    tier = 3,
  },
  leo = {
    install_info = {
      revision = '44a061bac4d9443d75f2700c62a71cd4dcf16f05',
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
      revision = '23ac814111e2b4b4b083e2c92219af2d5b74d13d',
      url = 'https://github.com/hankthetank27/tree-sitter-liquid',
    },
    maintainers = { '@hankthetank27' },
    tier = 3,
  },
  liquidsoap = {
    install_info = {
      revision = '8e51fa63ddb93ac179d4e34a311d3d3f03780b42',
      url = 'https://github.com/savonet/tree-sitter-liquidsoap',
    },
    maintainers = { '@toots' },
    tier = 3,
  },
  llvm = {
    install_info = {
      revision = 'c14cb839003348692158b845db9edda201374548',
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
    },
    maintainers = { '@benwilliamgraham' },
    tier = 3,
  },
  lua = {
    install_info = {
      revision = '34e60e7f45fc313463c68090d88d742a55d1bd7a',
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
      revision = '192407ab5a24bfc24f13332979b5e7967518754a',
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
      revision = '192407ab5a24bfc24f13332979b5e7967518754a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown',
    },
    maintainers = { '@MDeiml' },
    readme_note = 'needed for full highlighting',
    tier = 1,
  },
  matlab = {
    install_info = {
      revision = 'b0a0198b182574cd3ca0447264c83331901b9338',
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
      revision = 'c5fffb8edd39f22644084ab3f73a924a75721ee3',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-meson',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  mlir = {
    install_info = {
      generate = true,
      revision = 'b5d5f238b371b7c9b764f6a053b045dda92bc836',
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
      revision = 'd1b3638d017f2a8585e26dcfc66fe1df94185e30',
      url = 'https://github.com/naclsn/tree-sitter-nasm',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  nginx = {
    install_info = {
      revision = '989da760be05a3334af3ec88705cbf57e6a9c41d',
      url = 'https://github.com/opa-oz/tree-sitter-nginx',
    },
    maintainers = { '@opa-oz' },
    tier = 3,
  },
  nickel = {
    install_info = {
      revision = '25464b33522c3f609fa512aa9651707c0b66d48b',
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
      revision = '4b952d99ce6fc795ff3cfa48b05637f2b1751d3b',
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
  nu = {
    install_info = {
      revision = '9822fc63a62ff87939c88ead9f381f951f092dee',
      url = 'https://github.com/nushell/tree-sitter-nu',
    },
    maintainers = { '@abhisheksingh0x558' },
    tier = 3,
  },
  objc = {
    install_info = {
      generate_from_json = true,
      revision = '18802acf31d0b5c1c1d50bdbc9eb0e1636cab9ed',
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
      revision = '37ad9efe601316248b22173d2ff19a6b4c992016',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    tier = 2,
  },
  ocaml_interface = {
    install_info = {
      location = 'grammars/interface',
      revision = '37ad9efe601316248b22173d2ff19a6b4c992016',
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
      revision = 'd2ca8efb4487e156a60d5bd6db2598b872629403',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-odin',
    },
    maintainers = { '@amaanq' },
    tier = 2,
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
      revision = '1d16b8e063fdf4385e389096c4bc4999eaaef05f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pem',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  perl = {
    install_info = {
      branch = 'release',
      generate_from_json = true,
      revision = '6f280c52662dc254eb7a5abc0889f7a9e1154ffd',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },
  php = {
    install_info = {
      location = 'php',
      revision = '5021edde6d0ea75aedc313e75cca2ac5aa064d41',
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
      revision = '5021edde6d0ea75aedc313e75cca2ac5aa064d41',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP without embedded HTML',
    tier = 2,
  },
  phpdoc = {
    install_info = {
      generate_from_json = true,
      revision = 'fe3202e468bc17332bec8969f2b50ff1f1da3a46',
      url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
    },
    maintainers = { '@mikehaertl' },
    tier = 3,
  },
  pioasm = {
    install_info = {
      revision = 'afece58efdb30440bddd151ef1347fa8d6f744a9',
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
      revision = '2902dc45439125b9386812c1089a8e9b5f71c4ab',
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
      revision = '32fe49cc5d4a2d5a976dacafc0da16d98787866b',
      url = 'https://github.com/airbus-cert/tree-sitter-powershell',
    },
    maintainers = { '@L2jLiga' },
    tier = 3,
  },
  printf = {
    install_info = {
      revision = '60d50a2247b0c1fb72b967562c64711d65c6a060',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-printf',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  prisma = {
    install_info = {
      revision = '73f39a6d5401cfdcd143951e499336cf5ab2ffaa',
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
      revision = '579b62f5ad8d96c2bb331f07d1408c92767531d9',
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
      revision = '13e9195370172c86a8b88184cc358b23b677cc46',
      url = 'https://github.com/zealot128/tree-sitter-pug',
    },
    maintainers = { '@zealot128' },
    tier = 3,
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
      revision = '44c2f7aebce0efac5867cdc5f2ea03c1d43a0305',
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
      generate_from_json = true,
      revision = '8fef30e231d74b65c713bcbac21956156d8963da',
      url = 'https://github.com/yuja/tree-sitter-qmljs',
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
    tier = 3,
  },
  query = {
    install_info = {
      revision = '5c2d02747250bc326bc33687b3319b7db8554e24',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-query',
    },
    maintainers = { '@steelsojka' },
    readme_note = 'Tree-sitter query language',
    tier = 1,
  },
  r = {
    install_info = {
      revision = 'a0d3e3307489c3ca54da8c7b5b4e0c5f5fd6953a',
      url = 'https://github.com/r-lib/tree-sitter-r',
    },
    maintainers = { '@ribru17' },
    tier = 3,
  },
  racket = {
    install_info = {
      revision = '5b211bf93021d1c45f39aa96898be9f794f087e4',
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
  razor = {
    install_info = {
      generate_from_json = true,
      revision = 'a47cd8ca148685629739a4ab69f58864800fbdab',
      url = 'https://github.com/tris203/tree-sitter-razor',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@tris203' },
    tier = 3,
  },
  rbs = {
    install_info = {
      revision = 'de893b166476205b09e79cd3689f95831269579a',
      url = 'https://github.com/joker1007/tree-sitter-rbs',
    },
    maintainers = { '@joker1007' },
    tier = 3,
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
      revision = '74addc90fc539d31d413c0c7cf7581997a7fa46e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-readline',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  regex = {
    install_info = {
      revision = 'b638d29335ef41215b86732dd51be34c701ef683',
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
      revision = '17c2300e91fc9da4ba14c16558bf4292941dc074',
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
      revision = 'de0839d6c7db2405e827435cf3ac62d22f4bd5e9',
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
      revision = 'dd5971ef7759583aadd5aa5e3a3a0905eb5734d5',
      url = 'https://github.com/stsewd/tree-sitter-rst',
    },
    maintainers = { '@stsewd' },
    tier = 3,
  },
  ruby = {
    install_info = {
      revision = '71bd32fb7607035768799732addba884a37a6210',
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
    tier = 3,
  },
  rust = {
    install_info = {
      revision = '2eaf126458a4d6a69401089b6ba78c5e5d6c1ced',
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  scala = {
    install_info = {
      revision = 'd3b9553b47d7ab413a146c4b6498e527265b966e',
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
    },
    maintainers = { '@stevanmilic' },
    tier = 2,
  },
  scfg = {
    install_info = {
      generate = true,
      revision = '2f3709e7656fa2c443f92041c91a9f843f8cd625',
      url = 'https://github.com/rockorager/tree-sitter-scfg',
    },
    maintainers = { '@WhyNotHugo' },
    tier = 4,
  },
  scheme = {
    install_info = {
      revision = '63e25a4a84142ae7ee0ee01fe3a32c985ca16745',
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
      revision = 'eade4054efc897f4bb18a5b7bf4b5a824dbffa74',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiaofinland' },
    readme_note = 'Salesforce debug log',
    tier = 3,
  },
  slang = {
    install_info = {
      generate_from_json = true,
      revision = '3ed23c04a412a0559162d9cadf96dfff7cb36079',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-slang',
    },
    maintainers = { '@theHamsta' },
    readme_note = 'Shader Slang',
    tier = 2,
  },
  slim = {
    install_info = {
      revision = 'a0f08e85b787248219ea645423c5916c8d620ef6',
      url = 'https://github.com/theoo/tree-sitter-slim',
    },
    maintainers = { '@theoo' },
    tier = 3,
  },
  slint = {
    install_info = {
      revision = 'f11da7e62051ba8b9d4faa299c26de8aeedfc1cd',
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
      revision = 'f36c1587624d6d84376c82a357c20fc319cbf02c',
      url = 'https://github.com/osthomas/tree-sitter-snakemake',
    },
    maintainers = { '@osthomas' },
    tier = 3,
  },
  solidity = {
    install_info = {
      revision = '727087514eff57d92e273a24303142308bce3381',
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  soql = {
    install_info = {
      location = 'soql',
      revision = 'eade4054efc897f4bb18a5b7bf4b5a824dbffa74',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sosl = {
    install_info = {
      location = 'sosl',
      revision = 'eade4054efc897f4bb18a5b7bf4b5a824dbffa74',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sourcepawn = {
    install_info = {
      revision = 'f2af8d0dc14c6790130cceb2a20027eb41a8297c',
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
      revision = 'b9d109588d5b5ed986c857464830c2f0bef53f18',
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
      revision = '0dd3c7e9f301758f6c69a6efde43d3048deb4d8a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ssh-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  starlark = {
    install_info = {
      generate_from_json = true,
      revision = 'a453dbf3ba433db0e5ec621a38a7e59d72e4dc69',
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
      revision = '75d3ad20818c30c49b445ca2cb35999c278b3453',
      url = 'https://github.com/mskelton/tree-sitter-styled',
    },
    maintainers = { '@mskelton' },
    tier = 3,
  },
  supercollider = {
    install_info = {
      revision = '1a8ee0da9a4f2df5a8a22f4d637ac863623a78a7',
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
    },
    maintainers = { '@madskjeldgaard' },
    tier = 3,
  },
  superhtml = {
    install_info = {
      location = 'tree-sitter-superhtml',
      revision = 'e6eba40bf54dd94d842154be0389c53a37be8dc8',
      url = 'https://github.com/kristoff-it/superhtml',
    },
    maintainers = { '@rockorager' },
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
      revision = 'ae5199db47757f785e43a14b332118a5474de1a2',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-svelte',
    },
    maintainers = { '@amaanq' },
    requires = { 'html_tags' },
    tier = 2,
  },
  sway = {
    install_info = {
      revision = '395006713db3bbb90d267ebdfcbf1881b399b05c',
      url = 'https://github.com/FuelLabs/tree-sitter-sway.git',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  swift = {
    install_info = {
      generate = true,
      revision = 'f4be8072f18fb9704fd35d4b8154ae2b19e314c0',
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
  t32 = {
    install_info = {
      revision = 'e5a12f798f056049642aa03fbb83786e3a5b95d4',
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
      revision = '83e264928fa194b7283428527259e88e54205264',
      url = 'https://github.com/tact-lang/tree-sitter-tact',
    },
    maintainers = { '@novusnota' },
    tier = 3,
  },
  tcl = {
    install_info = {
      revision = '98015ebe182d94e5a4439e32ffd91beaac32fcb9',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tcl',
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },
  tera = {
    install_info = {
      url = 'https://github.com/uncenter/tree-sitter-tera',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@uncenter' },
    tier = 2,
  },
  teal = {
    install_info = {
      generate = true,
      revision = '3db655924b2ff1c54fdf6371b5425ea6b5dccefe',
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
    },
    maintainers = { '@euclidianAce' },
    tier = 3,
  },
  templ = {
    install_info = {
      generate_from_json = true,
      revision = 'a9178bfc9cc8040c08f39b47bae5400a2bf06e50',
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
      revision = '568471b80fd8793d37ed01865d8c2208a9fefd1b',
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
      revision = 'd711f24c93221cdfc9a9b4dbb0998f528fc982ac',
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
      revision = '64b56832c2cffe41758f28e05c756a3a98d16f41',
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
      revision = '410947e9d2ca8e032cd2419bf1241406c7e6f9bb',
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
      revision = '410947e9d2ca8e032cd2419bf1241406c7e6f9bb',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma' },
    tier = 2,
  },
  typespec = {
    install_info = {
      revision = '42fb163442ef2691b9b720fb4e4e846809415d18',
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
      revision = '26dfb4b94a99cc9d6044342b7ad0ba761da77d60',
      url = 'https://github.com/uben0/tree-sitter-typst',
    },
    maintainers = { '@uben0', '@RaafatTurki' },
    tier = 3,
  },
  udev = {
    install_info = {
      revision = '18a1d183c4c0cc40438bae2ebf8191aaf2dee8dc',
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
      revision = '3c97db76d3cdbd002dfba493620c2d5df2fd6fa9',
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
      revision = '0461bf8addccb4df566827f1601f415d07b1ffbc',
      url = 'https://github.com/vlang/v-analyzer',
    },
    maintainers = { '@kkharji', '@amaanq' },
    tier = 3,
  },
  vala = {
    install_info = {
      revision = '97e6db3c8c73b15a9541a458d8e797a07f588ef4',
      url = 'https://github.com/vala-lang/tree-sitter-vala',
    },
    maintainers = { '@Prince781' },
    tier = 3,
  },
  vento = {
    install_info = {
      revision = '3b32474bc29584ea214e4e84b47102408263fe0e',
      url = 'https://github.com/ventojs/tree-sitter-vento',
    },
    maintainers = { '@wrapperup', '@oscarotero' },
    tier = 3,
  },
  verilog = {
    install_info = {
      revision = '15fbf73dafaffc89050d247857beb27500ea30e8',
      url = 'https://github.com/gmlarumbe/tree-sitter-systemverilog',
    },
    maintainers = { '@zhangwwpeng' },
    tier = 3,
  },
  vhdl = {
    install_info = {
      revision = 'da8ea8afa7899a99e43a7d61afef9f77b7a675eb',
      url = 'https://github.com/jpt13653903/tree-sitter-vhdl',
    },
    maintainers = { '@jpt13653903' },
    tier = 3,
  },
  vhs = {
    install_info = {
      revision = '037e675d547b18bbf3fdeb222e242ae5dccc39d7',
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
      revision = 'd2e4b5c172a109966c2ce0378f73df6cede39400',
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
      revision = '47c1818d245a6156a488c4c4d06e9336714bae9b',
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
    tier = 3,
  },
  wit = {
    install_info = {
      revision = '81490b4e74c792369e005f72b0d46fe082d3fed2',
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
      revision = 'ce150c5be7f617e18ffa2064213e5d9c4cb5d69e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'dtd' },
    tier = 2,
  },
  xresources = {
    install_info = {
      revision = 'd0f9dc7cec4dc15fc6f9d556bb4e9dd5050328a6',
      url = 'https://github.com/ValdezFOmar/tree-sitter-xresources',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  yaml = {
    install_info = {
      revision = '1805917414a9a8ba2473717fd69447277a175fae',
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
      revision = 'b670c8df85a1568f498aa5c8cae42f51a90473c0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-zig',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },
  ziggy = {
    install_info = {
      location = 'tree-sitter-ziggy',
      revision = '3518133e9ebea7c372eff4def368eda8488fad18',
      url = 'https://github.com/kristoff-it/ziggy',
    },
    maintainers = { '@rockorager' },
    tier = 3,
  },
  ziggy_schema = {
    install_info = {
      location = 'tree-sitter-ziggy-schema',
      revision = '3518133e9ebea7c372eff4def368eda8488fad18',
      url = 'https://github.com/kristoff-it/ziggy',
    },
    maintainers = { '@rockorager' },
    tier = 3,
  },
}
