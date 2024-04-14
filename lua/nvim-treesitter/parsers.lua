---@type nvim-ts.parsers
return {
  ada = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e8e2515465cc2d7c444498e68bdb9f1d86767f95',
      url = 'https://github.com/briot/tree-sitter-ada',
    },
    maintainers = { '@briot' },
    tier = 3,
  },
  agda = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'd3dc807692e6bca671d4491b3bf5c67eeca8c016',
      url = 'https://github.com/tree-sitter/tree-sitter-agda',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  angular = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '10f21f3f1b10584e62ecc113ab3cda1196d0ceb8',
      url = 'https://github.com/dlvandenberg/tree-sitter-angular',
    },
    maintainers = { '@dlvandenberg' },
    requires = { 'html', 'html_tags' },
    tier = 3,
  },
  apex = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'apex',
      revision = 'c99ad4b16d112fea91745e3f1b769754239fdaba',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  arduino = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c' },
      revision = 'b0306e9bb2ebe01c6562f1aef265cc42ccc53070',
      url = 'https://github.com/RubixDev/tree-sitter-asm',
    },
    maintainers = { '@RubixDev' },
    tier = 3,
  },
  astro = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c' },
      revision = '1dec7e1af96c56924e3322cd85fdce15d0a31d00',
      url = 'https://github.com/mleonidas/tree-sitter-authzed',
    },
    maintainers = { '@mattpolzin' },
    tier = 3,
  },
  awk = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'ba7472152d79a8c916550c80fdbfd5724d07a0c9',
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
    },
    tier = 4,
  },
  bash = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '2fbd860f802802ca76a6661ce025b3a3bca2d3ed',
      url = 'https://github.com/tree-sitter/tree-sitter-bash',
    },
    maintainers = { '@TravonteD' },
    tier = 1,
  },
  bass = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '28dc7059722be090d04cd751aed915b2fee2f89a',
      url = 'https://github.com/vito/tree-sitter-bass',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  beancount = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'c25f8034c977681653a8acd541c8b4877a58f474',
      url = 'https://github.com/polarmutex/tree-sitter-beancount',
    },
    maintainers = { '@polarmutex' },
    tier = 3,
  },
  bibtex = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'ccfd77db0ed799b6c22c214fe9d2937f47bc8b34',
      url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },
  bicep = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '0092c7d1bd6bb22ce0a6f78497d50ea2b87f19c0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-bicep',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  bitbake = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a5d04fdb5a69a02b8fa8eb5525a60dfb5309b73b',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-bitbake',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  blueprint = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '60ba73739c6083c693d86a1a7cf039c07eb4ed59',
      url = 'https://gitlab.com/gabmus/tree-sitter-blueprint',
    },
    maintainers = { '@gabmus' },
    tier = 4,
  },
  bp = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '2326d709fb9cf73cf124fdbc803c267f851721a4',
      url = 'https://github.com/ambroisie/tree-sitter-bp',
    },
    maintainers = { '@ambroisie' },
    readme_note = 'Android Blueprint',
    tier = 3,
  },
  c = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'deca017a554045b4c203e7ddff39ae64ff05e071',
      url = 'https://github.com/tree-sitter/tree-sitter-c',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },
  c_sharp = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '82fa8f05f41a33e9bc830f85d74a9548f0291738',
      url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  cairo = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '6238f609bea233040fe927858156dee5515a0745',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cairo',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  capnp = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '7b0883c03e5edd34ef7bcf703194204299d7099f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-capnp',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  chatito = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'a461f20dedb43905febb12c1635bc7d2e43e96f0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-chatito',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  circom = {
    install_info = {
      url = 'https://github.com/Decurity/tree-sitter-circom',
      files = { 'src/parser.c' },
    },
    maintainers = { '@alexandr-martirosyan' },
    tier = 3,
  },
  clojure = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f4236d4da8aa92bc105d9c118746474c608e6af7',
      url = 'https://github.com/sogaiu/tree-sitter-clojure',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 3,
  },
  cmake = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '20ffd6d3b4da1acdbf2d08204b2130a5b2f7c4b3',
      url = 'https://github.com/uyha/tree-sitter-cmake',
    },
    maintainers = { '@uyha' },
    tier = 3,
  },
  comment = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '5d8b29f6ef3bf64d59430dcfe76b31cc44b5abfd',
      url = 'https://github.com/stsewd/tree-sitter-comment',
    },
    maintainers = { '@stsewd' },
    tier = 3,
  },
  commonlisp = {
    install_info = {
      files = { 'src/parser.c' },
      generate_from_json = true,
      revision = 'bf2a65b1c119898a1a17389e07f2a399c05cdc0c',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-commonlisp',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  cooklang = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '4ebe237c1cf64cf3826fc249e9ec0988fe07e58e',
      url = 'https://github.com/addcninblue/tree-sitter-cooklang',
    },
    maintainers = { '@addcninblue' },
    tier = 3,
  },
  corn = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '604d73c38d4c28ca68e9e441ffd405d68cb63051',
      url = 'https://github.com/jakestanger/tree-sitter-corn',
    },
    maintainers = { '@jakestanger' },
    tier = 3,
  },
  cpon = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '594289eadfec719198e560f9d7fd243c4db678d5',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cpon',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  cpp = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = 'd29fbff09a8c9ff4f3074de2595dfca12cb33da9',
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  css = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'f6be52c3d1cdb1c5e4dd7d8bce0a57497f55d6af',
      url = 'https://github.com/tree-sitter/tree-sitter-css',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  csv = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '1f188eff83b562ffae36d13e1b804ec6f3b9f1d9',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-cuda',
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },
  cue = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '8a5f273bfa281c66354da562f2307c2d394b6c81',
      url = 'https://github.com/eonpatapon/tree-sitter-cue',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  cylc = {
    install_info = {
      url = 'https://github.com/elliotfontaine/tree-sitter-cylc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@elliotfontaine' },
    tier = 3,
  },
  d = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '750dde90ed9cdbd82493bc28478d8ab1976b0e9f',
      url = 'https://github.com/gdamore/tree-sitter-d',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  dart = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'ac0bb849ccd1a923963af47573b5e396736ff582',
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
    },
    maintainers = { '@akinsho' },
    tier = 3,
  },
  desktop = {
    install_info = {
      files = { 'src/parser.c' },
      url = 'https://github.com/ValdezFOmar/tree-sitter-desktop',
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  devicetree = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'fb07e6044ffd36932c57a5be01ba5d6b8a9337bb',
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
    },
    maintainers = { '@jedrzejboczar' },
    tier = 3,
  },
  dhall = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'affb6ee38d629c9296749767ab832d69bb0d9ea8',
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  diff = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '629676fc3919606964231b2c7b9677d6998a2cb4',
      url = 'https://github.com/the-mikedavis/tree-sitter-diff',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  disassembly = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '0229c0211dba909c5d45129ac784a3f4d49c243a',
      url = 'https://github.com/ColinKennedy/tree-sitter-disassembly',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  djot = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '0e9a836ec47612ade15645fb1680adb549894a6c',
      url = 'https://github.com/treeman/tree-sitter-djot',
    },
    maintainers = { '@NoahTheDuke' },
    tier = 3,
  },
  dockerfile = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '087daa20438a6cc01fa5e6fe6906d77c869d19fe',
      url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },
  dot = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '9ab85550c896d8b294d9b9ca1e30698736f08cea',
      url = 'https://github.com/rydesun/tree-sitter-dot',
    },
    maintainers = { '@rydesun' },
    tier = 3,
  },
  doxygen = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '4a30eba5d047d6a8c5b005202b4848c0b33d76ca',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-doxygen',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  dtd = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'dtd',
      revision = '648183d86f6f8ffb240ea11b4c6873f6f45d8b67',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  earthfile = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '6de809419cdfb23e3a8383b6575fa3634900f276',
      url = 'https://github.com/glehmann/tree-sitter-earthfile',
    },
    maintainers = { '@glehmann' },
    tier = 3,
  },
  ebnf = {
    install_info = {
      files = { 'src/parser.c' },
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
      url = 'https://github.com/ValdezFOmar/tree-sitter-editorconfig',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  eds = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '5517bdb90c90703df49579a4b04689a614780be2',
      url = 'https://github.com/uyha/tree-sitter-eds',
    },
    maintainers = { '@uyha' },
    tier = 3,
  },
  eex = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f742f2fe327463335e8671a87c0b9b396905d1d1',
      url = 'https://github.com/connorlay/tree-sitter-eex',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  elixir = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'de690fa8a028f122af46d9d2685679fe5f2d7d60',
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  elm = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '09dbf221d7491dc8d8839616b27c21b9c025c457',
      url = 'https://github.com/elm-tooling/tree-sitter-elm',
    },
    maintainers = { '@zweimach' },
    tier = 3,
  },
  elsa = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '0a66b2b3f3c1915e67ad2ef9f7dbd2a84820d9d7',
      url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
    },
    maintainers = { '@glapa-grossklag', '@amaanq' },
    tier = 3,
  },
  elvish = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '5e7210d945425b77f82cbaebc5af4dd3e1ad40f5',
      url = 'https://github.com/elves/tree-sitter-elvish',
    },
    maintainers = { '@elves' },
    tier = 3,
  },
  embedded_template = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '38d5004a797298dc42c85e7706c5ceac46a3f29f',
      url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
    },
    tier = 4,
  },
  erlang = {
    install_info = {
      files = { 'src/parser.c', 'src/parser.c' },
      revision = '98ea1f9c957b2ad520415eecb5a5b406e931101e',
      url = 'https://github.com/WhatsApp/tree-sitter-erlang',
    },
    maintainers = { '@filmor' },
    tier = 3,
  },
  facility = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'a52579670e2b14ec03d410c3c980fafaf6d659c4',
      url = 'https://github.com/FacilityApi/tree-sitter-facility',
    },
    maintainers = { '@bryankenote' },
    tier = 3,
  },
  faust = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f3b9274514b5f9bf6b0dd4a01c30f9cc15c58bc4',
      url = 'https://github.com/khiner/tree-sitter-faust',
    },
    maintainers = { '@khiner' },
    tier = 3,
  },
  fennel = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = 'cfbfa478dc2dbef267ee94ae4323d9c886f45e94',
      url = 'https://github.com/alexmozaidze/tree-sitter-fennel',
    },
    maintainers = { '@alexmozaidze' },
    tier = 3,
  },
  fidl = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '0a8910f293268e27ff554357c229ba172b0eaed2',
      url = 'https://github.com/google/tree-sitter-fidl',
    },
    maintainers = { '@chaopeng' },
    tier = 3,
  },
  firrtl = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '8503d3a0fe0f9e427863cb0055699ff2d29ae5f5',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-firrtl',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fish = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a78aef9abc395c600c38a037ac779afc7e3cc9e0',
      url = 'https://github.com/ram02z/tree-sitter-fish',
    },
    maintainers = { '@ram02z' },
    tier = 3,
  },
  foam = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '04664b40c0dadb7ef37028acf3422c63271d377b',
      url = 'https://github.com/FoamScience/tree-sitter-foam',
    },
    maintainers = { '@FoamScience' },
    tier = 3,
  },
  forth = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '90189238385cf636b9ee99ce548b9e5b5e569d48',
      url = 'https://github.com/AlexanderBrevig/tree-sitter-forth',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  fortran = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'f73d473e3530862dee7cbb38520f28824e7804f6',
      url = 'https://github.com/stadelmanma/tree-sitter-fortran',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  fsh = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'fad2e175099a45efbc98f000cc196d3674cc45e0',
      url = 'https://github.com/mgramigna/tree-sitter-fsh',
    },
    maintainers = { '@mgramigna' },
    tier = 3,
  },
  fsharp = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'fsharp',
      url = 'https://github.com/ionide/tree-sitter-fsharp',
    },
    maintainers = { '@nsidorenco' },
    tier = 3,
  },
  func = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f780ca55e65e7d7360d0229331763e16c452fc98',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-func',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  fusion = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '1f1e782fe2600f50ae57b53876505b8282388d77',
      url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
    },
    maintainers = { '@PrestonKnopp' },
    readme_note = 'Godot',
    tier = 3,
  },
  gdshader = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'ffd9f958df13cae04593781d7d2562295a872455',
      url = 'https://github.com/GodOfAvacyn/tree-sitter-gdshader',
    },
    maintainers = { '@godofavacyn' },
    tier = 3,
  },
  git_config = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '9c2a1b7894e6d9eedfe99805b829b4ecd871375e',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  git_rebase = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'd8a4207ebbc47bd78bacdf48f883db58283f9fd8',
      url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  gitattributes = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '41940e199ba5763abea1d21b4f717014b45f01ea',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gitattributes',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  gitcommit = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'edd817e0532f179b7f7f371dc180629070945f0c',
      url = 'https://github.com/gbprod/tree-sitter-gitcommit',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  gitignore = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f4685bf11ac466dd278449bcfe5fd014e94aa504',
      url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },
  gleam = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '02a17bf9d0553406268cdbf466d57808ae712bf3',
      url = 'https://github.com/gleam-lang/tree-sitter-gleam',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  glimmer = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '6b25d265c990139353e1f7f97baf84987ebb7bf0',
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
      generate_requires_npm = true,
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'ecma' },
    tier = 3,
  },
  glimmer_typescript = {
    install_info = {
      url = 'https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@NullVoxPopuli' },
    requires = { 'typescript' },
    tier = 3,
  },
  glsl = {
    install_info = {
      files = { 'src/parser.c' },
      generate_from_json = true,
      revision = '7f91bf34cadc06a96efc475df501ffca4dda9410',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-glsl',
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },
  gn = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'bc06955bc1e3c9ff8e9b2b2a55b38b94da923c05',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gn',
    },
    maintainers = { '@amaanq' },
    readme_name = 'GN (Generate Ninja)',
    tier = 2,
  },
  gnuplot = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '3c895f5d9c0b3a3c7e02383766b462c21913c000',
      url = 'https://github.com/dpezto/tree-sitter-gnuplot',
    },
    maintainers = { '@dpezto' },
    tier = 3,
  },
  go = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '7ee8d928db5202f6831a78f8112fd693bf69f98b',
      url = 'https://github.com/tree-sitter/tree-sitter-go',
    },
    maintainers = { '@theHamsta', '@WinWisely268' },
    tier = 2,
  },
  goctl = {
    install_info = {
      url = 'https://github.com/chaozwn/tree-sitter-goctl',
      files = { 'src/parser.c' },
    },
    maintainers = { '@chaozwn' },
    tier = 3,
  },
  godot_resource = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '2ffb90de47417018651fc3b970e5f6b67214dc9d',
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
    tier = 3,
  },
  gomod = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'bbe2fe3be4b87e06a613e685250f473d2267f430',
      url = 'https://github.com/camdencheek/tree-sitter-go-mod',
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },
  gosum = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e2ac513b2240c7ff1069ae33b2df29ce90777c11',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-go-sum',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  gotmpl = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '9d3f6e526dd074b9edae9070b7bb778f00e87a5b',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 3,
  },
  gowork = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '949a8a470559543857a62102c84700d291fc984c',
      url = 'https://github.com/omertuc/tree-sitter-go-work',
    },
    maintainers = { '@omertuc' },
    tier = 3,
  },
  gpg = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f99323fb8f3f10b6c69db0c2f6d0a14bd7330675',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gpg-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  graphql = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '5e66e961eee421786bdda8495ed1db045e06b5fe',
      url = 'https://github.com/bkegley/tree-sitter-graphql',
    },
    maintainers = { '@bkegley' },
    tier = 3,
  },
  gren = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      url = 'https://github.com/MaeBrooks/tree-sitter-gren',
    },
    maintainers = { '@MaeBrooks' },
    tier = 3,
  },
  groovy = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '6c5c8813233fe326e24c5ef032858d13f8006a8d',
      url = 'https://github.com/murtaza64/tree-sitter-groovy',
    },
    maintainers = { '@murtaza64' },
    tier = 3,
  },
  gstlaunch = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '549aef253fd38a53995cda1bf55c501174372bf7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-gstlaunch',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  hack = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'fca1e294f6dce8ec5659233a6a21f5bd0ed5b4f2',
      url = 'https://github.com/slackhq/tree-sitter-hack',
    },
    tier = 4,
  },
  hare = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '070524937539eb8bb4f10debd9c83b66c434f3a2',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hare',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  haskell = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a50070d5bb5bd5c1281740a6102ecf1f4b0c4f19',
      url = 'https://github.com/tree-sitter/tree-sitter-haskell',
    },
    maintainers = { '@mrcjkb' },
    tier = 2,
  },
  haskell_persistent = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '577259b4068b2c281c9ebf94c109bd50a74d5857',
      url = 'https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent',
    },
    maintainers = { '@lykahb' },
    tier = 3,
  },
  hcl = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'e936d3fef8bac884661472dce71ad82284761eb1',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 2,
  },
  heex = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'b5ad6e34eea18a15bbd1466ca707a17f9bff7b93',
      url = 'https://github.com/connorlay/tree-sitter-heex',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  helm = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'dialects/helm',
      revision = '9d3f6e526dd074b9edae9070b7bb778f00e87a5b',
      url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    },
    maintainers = { '@qvalentin' },
    tier = 3,
  },
  hjson = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '5e1225a30712ca0a9040509806c7ba274a1bbcde',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hlsl',
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },
  hlsplaylist = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '64f19029339e75d6762feae39e7878595860c980',
      url = 'https://github.com/Freed-Wu/tree-sitter-hlsplaylist',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  hocon = {
    install_info = {
      files = { 'src/parser.c' },
      generate_from_json = true,
      revision = 'c390f10519ae69fdb03b3e5764f5592fb6924bcc',
      url = 'https://github.com/antosha417/tree-sitter-hocon',
    },
    maintainers = { '@antosha417' },
    tier = 4,
  },
  hoon = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a24c5a39d1d7e993a8bee913c8e8b6a652ca5ae8',
      url = 'https://github.com/urbit-pilled/tree-sitter-hoon',
    },
    maintainers = { '@urbit-pilled' },
    tier = 3,
  },
  html = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'e4d834eb4918df01dcad5c27d1b15d56e3bd94cd',
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
      files = { 'src/parser.c' },
      revision = 'ea71012d3fe14dd0b69f36be4f96bdfe9155ebae',
      url = 'https://github.com/interdependence/tree-sitter-htmldjango',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  http = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8d22f33faa5aa95c6526606fb656ada342e59e40',
      url = 'https://github.com/rest-nvim/tree-sitter-http',
    },
    maintainers = { '@amaanq', '@NTBBloodbath' },
    tier = 3,
  },
  hurl = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'ad705af8c44c737bdb965fc081329c50716d2d03',
      url = 'https://github.com/pfeiferj/tree-sitter-hurl',
    },
    maintainers = { '@pfeiferj' },
    tier = 3,
  },
  hyprlang = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e5da7d0aa44403153e0394d87d9edea4e5bd6609',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-hyprlang',
    },
    maintainers = { '@luckasRanarison' },
    tier = 2,
  },
  idl = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '9f56001f8ed29b0ea9fa4f02813f3e83ab0a2aaa',
      url = 'https://github.com/cathaysia/tree-sitter-idl',
    },
    maintainers = { '@cathaysia' },
    tier = 3,
  },
  ini = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '87176e524f0a98f5be75fa44f4f0ff5c6eac069c',
      url = 'https://github.com/justinmk/tree-sitter-ini',
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },
  inko = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '234c87be1dac20f766ddf6f486a7bde2a4bc5594',
      url = 'https://github.com/inko-lang/tree-sitter-inko',
    },
    maintainers = { '@yorickpeterse' },
    tier = 3,
  },
  ispc = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '6bfbaadac2ba0da21087041eff85d26129c4c920',
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
    },
    maintainers = { '@sogaiu' },
    tier = 3,
  },
  java = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '953abfc8bb3eb2f578e1f461edba4a9885f974b8',
      url = 'https://github.com/tree-sitter/tree-sitter-java',
    },
    maintainers = { '@p00f' },
    tier = 2,
  },
  javascript = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '391a8fcc48a11f63bf18ec9885f6f069e760949a',
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
    tier = 2,
  },
  jq = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '13990f530e8e6709b7978503da9bc8701d366791',
      url = 'https://github.com/flurie/tree-sitter-jq',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  jsdoc = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '49fde205b59a1d9792efc21ee0b6d50bbd35ff14',
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '94f5c527b2965465956c2000ed6134dd24daf2a7',
      url = 'https://github.com/tree-sitter/tree-sitter-json',
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },
  json5 = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'ab0ba8229d639ec4f3fa5f674c9133477f4b77bd',
      url = 'https://github.com/Joakker/tree-sitter-json5',
    },
    maintainers = { '@Joakker' },
    tier = 3,
  },
  jsonc = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'd34615fa12cc1d1cfc1f1f1a80acc9db80ee4596',
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'f1baa5f8e271109d01cc8ff7473c11df2d8a9aee',
      url = 'https://github.com/tree-sitter/tree-sitter-julia',
    },
    maintainers = { '@fredrikekre' },
    tier = 3,
  },
  just = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'fd814fc6c579f68c2a642f5e0268cf69daae92d7',
      url = 'https://github.com/IndianBoy42/tree-sitter-just',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  kconfig = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '486fea71f61ad9f3fd4072a118402e97fe88d26c',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-kconfig',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  kdl = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '49fb89a854d93b58a65a19724ac307195ca11941',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-kdl',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  kotlin = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'c9cb8504b81684375e7beb8907517dbd6947a1be',
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
    },
    maintainers = { '@SalBakraa' },
    tier = 3,
  },
  koto = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'eb8d866cff5751c0a7650623d244280618b0a378',
      url = 'https://github.com/koto-lang/tree-sitter-koto',
    },
    maintainers = { '@irh' },
    tier = 3,
  },
  kusto = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8353a1296607d6ba33db7c7e312226e5fc83e8ce',
      url = 'https://github.com/Willem-J-an/tree-sitter-kusto',
    },
    maintainers = { '@Willem-J-an' },
    tier = 3,
  },
  lalrpop = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '854a40e99f7c70258e522bdb8ab584ede6196e2e',
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
    },
    maintainers = { '@traxys' },
    tier = 3,
  },
  latex = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate = true,
      revision = 'cd82eb40d31bdfe65f846f4e06292d6c804b5e0e',
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },
  ledger = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8a841fb20ce683bfbb3469e6ba67f2851cfdf94a',
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
    },
    maintainers = { '@cbarrete' },
    tier = 3,
  },
  leo = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '304611b5eaf53aca07459a0a03803b83b6dfd3b3',
      url = 'https://github.com/r001/tree-sitter-leo',
    },
    maintainers = { '@r001' },
    tier = 3,
  },
  linkerscript = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f99011a3554213b654985a4b0a65b3b032ec4621',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-linkerscript',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  liquid = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '293369818da219d97327908aab33707b04b63fd9',
      url = 'https://github.com/hankthetank27/tree-sitter-liquid',
    },
    maintainers = { '@hankthetank27' },
    tier = 3,
  },
  liquidsoap = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '14feafa91630afb1ab9988cf9b738b7ea29f3f89',
      url = 'https://github.com/savonet/tree-sitter-liquidsoap',
    },
    maintainers = { '@toots' },
    tier = 3,
  },
  llvm = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '1b96e58faf558ce057d4dc664b904528aee743cb',
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
    },
    maintainers = { '@benwilliamgraham' },
    tier = 3,
  },
  lua = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a24dab177e58c9c6832f96b9a73102a0cfbced4a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-lua',
    },
    maintainers = { '@muniftanjim' },
    tier = 1,
  },
  luadoc = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '873612aadd3f684dd4e631bdf42ea8990c57634e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luadoc',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  luap = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '31461ae9bd0866cb5117cfe5de71189854fd0f3e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luap',
    },
    maintainers = { '@amaanq' },
    readme_note = 'Lua patterns',
    tier = 2,
  },
  luau = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '5aa9b88a8e3327276ec6e72de997f04ac80b1ae4',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-luau',
    },
    maintainers = { '@amaanq' },
    requires = { 'lua' },
    tier = 2,
  },
  m68k = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'd097b123f19c6eaba2bf181c05420d88b9fc489d',
      url = 'https://github.com/grahambates/tree-sitter-m68k',
    },
    maintainers = { '@grahambates' },
    tier = 3,
  },
  make = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'a4b9187417d6be349ee5fd4b6e77b4172c6827dd',
      url = 'https://github.com/alemuller/tree-sitter-make',
    },
    maintainers = { '@lewis6991' },
    tier = 3,
  },
  markdown = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '79d8b25f57b48f83ae1333aff6723b83c9532e37',
      url = 'https://github.com/acristoffers/tree-sitter-matlab',
    },
    maintainers = { '@acristoffers' },
    tier = 3,
  },
  menhir = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'be8866a6bcc2b563ab0de895af69daeffa88fe70',
      url = 'https://github.com/Kerl13/tree-sitter-menhir',
    },
    maintainers = { '@Kerl13' },
    tier = 3,
  },
  mermaid = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '90ae195b31933ceb9d079abfa8a3ad0a36fee4cc',
      url = 'https://github.com/monaqa/tree-sitter-mermaid',
    },
    tier = 4,
  },
  meson = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'bd17c824196ce70800f64ad39cfddd1b17acc13f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-meson',
    },
    maintainers = { '@Decodetalkers' },
    tier = 2,
  },
  mlir = {
    install_info = {
      files = { 'src/parser.c' },
      generate = true,
      revision = '00c32d8562dc957b187da110a3443307962b8da8',
      url = 'https://github.com/artagnon/tree-sitter-mlir',
    },
    maintainers = { '@artagnon' },
    tier = 3,
  },
  muttrc = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '90ef60852c410bd964cd3b954366e4c403c17314',
      url = 'https://github.com/neomutt/tree-sitter-muttrc',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  nasm = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '570f3d7be01fffc751237f4cfcf52d04e20532d1',
      url = 'https://github.com/naclsn/tree-sitter-nasm',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 3,
  },
  nginx = {
    install_info = {
      url = 'https://github.com/opa-oz/tree-sitter-nginx',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@opa-oz' },
    tier = 3,
  },
  nickel = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '0a796f3a312917724c1d9f486a201f7402a8acfd',
      url = 'https://github.com/nickel-lang/tree-sitter-nickel',
    },
    tier = 4,
  },
  nim = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '961c2798cec9250c44f7d7225ddb33d47d25856a',
      url = 'https://github.com/alaviss/tree-sitter-nim',
    },
    maintainers = { '@aMOPel' },
    requires = { 'nim_format_string' },
    tier = 3,
  },
  nim_format_string = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'd45f75022d147cda056e98bfba68222c9c8eca3a',
      url = 'https://github.com/aMOPel/tree-sitter-nim-format-string',
    },
    maintainers = { '@aMOPel' },
    tier = 3,
  },
  ninja = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '0a95cfdc0745b6ae82f60d3a339b37f19b7b9267',
      url = 'https://github.com/alemuller/tree-sitter-ninja',
    },
    maintainers = { '@alemuller' },
    tier = 3,
  },
  nix = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'b3cda619248e7dd0f216088bd152f59ce0bbe488',
      url = 'https://github.com/cstrahan/tree-sitter-nix',
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },
  nqc = {
    install_info = {
      files = { 'src/parser.c' },
      generate_from_json = true,
      revision = '14e6da1627aaef21d2b2aa0c37d04269766dcc1d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-nqc',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  nu = {
    install_info = {
      url = 'https://github.com/nushell/tree-sitter-nu',
      files = { 'src/parser.c' },
    },
    maintainers = { '@abhisheksingh0x558' },
    tier = 3,
  },
  objc = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '28d3b2e25a0b1881d1b47ed1924ca276c7003d45',
      url = 'https://github.com/ColinKennedy/tree-sitter-objdump',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  ocaml = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'grammars/ocaml',
      revision = '0b12614ded3ec7ed7ab7933a9ba4f695ba4c342e',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    tier = 2,
  },
  ocaml_interface = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'grammars/interface',
      revision = '0b12614ded3ec7ed7ab7933a9ba4f695ba4c342e',
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    },
    maintainers = { '@undu' },
    requires = { 'ocaml' },
    tier = 2,
  },
  ocamllex = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate = true,
      revision = '4b9898ccbf198602bb0dec9cd67cc1d2c0a4fad2',
      url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
    },
    maintainers = { '@undu' },
    tier = 3,
  },
  odin = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'd37b8f24f653378b268ec18404e9c14ad355b128',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-odin',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  org = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '64cfbc213f5a83da17632c95382a5a0a2f3357c1',
      url = 'https://github.com/milisims/tree-sitter-org',
    },
    tier = 4,
  },
  pascal = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'a9ee969dec5b2e3b2ccccc5954fec04100c7619e',
      url = 'https://github.com/Isopod/tree-sitter-pascal',
    },
    maintainers = { '@Isopod' },
    tier = 3,
  },
  passwd = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '20239395eacdc2e0923a7e5683ad3605aee7b716',
      url = 'https://github.com/ath3/tree-sitter-passwd',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  pem = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '217ff2af3f2db15a79ab7e3d21ea1e0c17e71a1a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pem',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  perl = {
    install_info = {
      branch = 'release',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '309cb8d33bcfd0a81050b21be08f9eb3f2fe2138',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },
  php = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'php',
      revision = 'b38c53537769df05871643c9688c264074fb6076',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP with embedded HTML',
    requires = { 'php_only' },
    tier = 2,
  },
  php_only = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'php_only',
      revision = 'b38c53537769df05871643c9688c264074fb6076',
      url = 'https://github.com/tree-sitter/tree-sitter-php',
    },
    maintainers = { '@tk-shirasaka', '@calebdw' },
    readme_note = 'PHP without embedded HTML',
    tier = 2,
  },
  phpdoc = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '1d0e255b37477d0ca46f1c9e9268c8fa76c0b3fc',
      url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
    },
    maintainers = { '@mikehaertl' },
    tier = 3,
  },
  pioasm = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '924aadaf5dea2a6074d72027b064f939acf32e20',
      url = 'https://github.com/leo60228/tree-sitter-pioasm',
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },
  po = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'bd860a0f57f697162bf28e576674be9c1500db5e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-po',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  pod = {
    install_info = {
      branch = 'release',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '39da859947b94abdee43e431368e1ae975c0a424',
      url = 'https://github.com/tree-sitter-perl/tree-sitter-pod',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },
  poe_filter = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '592476d81f95d2451f2ca107dc872224c76fecdf',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-poe-filter',
    },
    maintainers = { '@ObserverOfTime' },
    readme_note = 'Path of Exile item filter',
    tier = 2,
  },
  pony = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '73ff874ae4c9e9b45462673cbc0a1e350e2522a7',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pony',
    },
    maintainers = { '@amaanq', '@mfelsche' },
    tier = 2,
  },
  powershell = {
    install_info = {
      url = 'https://github.com/airbus-cert/tree-sitter-powershell',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    filetype = 'ps1',
    maintainers = { '@L2jLiga' },
    tier = 3,
  },
  printf = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '0e0aceabbf607ea09e03562f5d8a56f048ddea3d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-printf',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  prisma = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'eca2596a355b1a9952b4f80f8f9caed300a272b5',
      url = 'https://github.com/victorhqc/tree-sitter-prisma',
    },
    maintainers = { '@elianiva' },
    tier = 3,
  },

  problog = {
    install_info = {
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
      files = { 'src/parser.c' },
      location = 'grammars/problog',
    },
    maintainers = { '@foxyseta' },
    requires = { 'prolog' },
    tier = 3,
  },

  prolog = {
    install_info = {
      url = 'https://github.com/foxyseta/tree-sitter-prolog',
      files = { 'src/parser.c' },
      location = 'grammars/prolog',
    },
    maintainers = { '@foxyseta' },
    tier = 3,
  },
  promql = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '77625d78eebc3ffc44d114a07b2f348dff3061b0',
      url = 'https://github.com/MichaHoffmann/tree-sitter-promql',
    },
    maintainers = { '@MichaHoffmann' },
    tier = 3,
  },
  properties = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '9d09f5f200c356c50c4103d36441309fd61b48d1',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-properties',
    },
    maintainers = { '@ObserverOfTime' },
    readme_note = 'Java properties files',
    tier = 2,
  },
  proto = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e9f6b43f6844bd2189b50a422d4e2094313f6aa3',
      url = 'https://github.com/treywood/tree-sitter-proto',
    },
    maintainers = { '@treywood' },
    tier = 3,
  },
  prql = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '09e158cd3650581c0af4c49c2e5b10c4834c8646',
      url = 'https://github.com/PRQL/tree-sitter-prql',
    },
    maintainers = { '@matthias-Q' },
    tier = 3,
  },
  psv = {
    install_info = {
      files = { 'src/parser.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a7ff31a38908df9b9f34828d21d6ca5e12413e18',
      url = 'https://github.com/zealot128/tree-sitter-pug',
    },
    maintainers = { '@zealot128' },
    tier = 3,
  },
  puppet = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '584522f32495d648b18a53ccb52d988e60de127d',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-puppet',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  purescript = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'daf9b3e2be18b0b2996a1281f7783e0d041d8b80',
      url = 'https://github.com/postsolar/tree-sitter-purescript',
    },
    maintainers = { '@postsolar' },
    tier = 3,
  },
  pymanifest = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e3b82b78721aee07f676dac8473ae69db51debcf',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-pymanifest',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'PyPA manifest',
    tier = 2,
  },
  python = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '71778c2a472ed00a64abf4219544edbf8e4b86d7',
      url = 'https://github.com/tree-sitter/tree-sitter-python',
    },
    maintainers = { '@stsewd', '@theHamsta' },
    tier = 1,
  },
  ql = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '42becd6f8f7bae82c818fa3abb1b6ff34b552310',
      url = 'https://github.com/tree-sitter/tree-sitter-ql',
    },
    maintainers = { '@pwntester' },
    tier = 2,
  },
  qmldir = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '6b2b5e41734bd6f07ea4c36ac20fb6f14061c841',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-qmldir',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  qmljs = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '2c57cac27e207425f8df15327884434cb12365a3',
      url = 'https://github.com/yuja/tree-sitter-qmljs',
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
    tier = 3,
  },
  query = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f767fb0ac5e711b6d44c5e0c8d1f349687a86ce0',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-query',
    },
    maintainers = { '@steelsojka' },
    readme_note = 'Tree-sitter query language',
    tier = 1,
  },
  r = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '391400572538ff9854341a175ed8ab4b1e45f44b',
      url = 'https://github.com/r-lib/tree-sitter-r',
    },
    maintainers = { '@ribru17' },
    tier = 3,
  },
  racket = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '171f52a8c0ed635b85cd42d1e36d82f1066a03b4',
      url = 'https://github.com/6cdh/tree-sitter-racket',
    },
    tier = 4,
  },
  ralph = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '48b9d9d6e2b55ce8f9eb09ceb0d952e4b1cc87a0',
      url = 'https://github.com/alephium/tree-sitter-ralph',
    },
    maintainers = { '@tdroxler' },
    tier = 3,
  },
  rasi = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '6c9bbcfdf5f0f553d9ebc01750a3aa247a37b8aa',
      url = 'https://github.com/Fymyte/tree-sitter-rasi',
    },
    maintainers = { '@Fymyte' },
    tier = 3,
  },
  rbs = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'e5e807a50fcd104a2d740d354632fc671700a0bf',
      url = 'https://github.com/joker1007/tree-sitter-rbs',
    },
    maintainers = { '@joker1007' },
    tier = 3,
  },
  re2c = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '47aa19cf5f7aba2ed30e2b377f7172df76e819a6',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-re2c',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  readline = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '3d4768b04d7cfaf40533e12b28672603428b8f31',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-readline',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  regex = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '47007f195752d8e57bda80b0b6cdb2d173a9f7d7',
      url = 'https://github.com/tree-sitter/tree-sitter-regex',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  rego = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '23b1da8de9766d766c4f01531e8be14b5c00c493',
      url = 'https://github.com/FallenAngel97/tree-sitter-rego',
    },
    maintainers = { '@FallenAngel97' },
    tier = 3,
  },
  requirements = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '360c6a6b31076a482663806f7a8241de9cad6b4e',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-requirements',
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'pip requirements',
    tier = 2,
  },
  rescript = {
    install_info = {
      url = 'https://github.com/rescript-lang/tree-sitter-rescript',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  rnoweb = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '1a74dc0ed731ad07db39f063e2c5a6fe528cae7f',
      url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
    },
    maintainers = { '@bamonroe' },
    tier = 3,
  },
  robot = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '322e4cc65754d2b3fdef4f2f8a71e0762e3d13af',
      url = 'https://github.com/Hubro/tree-sitter-robot',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  robots = {
    install_info = {
      url = 'https://github.com/opa-oz/tree-sitter-robots-txt',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@opa-oz' },
    tier = 3,
  },
  roc = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '7df2c0892e62efb81a7504d9799d4e0d0443d241',
      url = 'https://github.com/faldor20/tree-sitter-roc',
    },
    maintainers = { '@nat-418' },
    tier = 3,
  },
  ron = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '78938553b93075e638035f624973083451b29055',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ron',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  rst = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '5120f6e59284cb8b85b450bd2db0bd352635ba9f',
      url = 'https://github.com/stsewd/tree-sitter-rst',
    },
    maintainers = { '@stsewd' },
    tier = 3,
  },
  ruby = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'dc2d7d6b50f9975bc3c35bbec0ba11b2617b736b',
      url = 'https://github.com/tree-sitter/tree-sitter-ruby',
    },
    maintainers = { '@TravonteD' },
    tier = 2,
  },
  runescript = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      url = 'https://github.com/2004Scape/tree-sitter-runescript',
    },
    maintainers = { '@2004Scape' },
    tier = 3,
  },
  rust = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '9c84af007b0f144954adb26b3f336495cbb320a7',
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  scala = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'b76db435a7f876cf1ede837d66054c534783c72f',
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
    },
    maintainers = { '@stevanmilic' },
    tier = 2,
  },
  scfg = {
    install_info = {
      files = { 'src/parser.c' },
      generate = true,
      revision = '6deae0cbb458c849a4d1e2985093e9c9c32d7fd0',
      url = 'https://github.com/rockorager/tree-sitter-scfg',
    },
    maintainers = { '@WhyNotHugo' },
    tier = 3,
  },
  scheme = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8f9dff3d038f09934db5ea113cebc59c74447743',
      url = 'https://github.com/6cdh/tree-sitter-scheme',
    },
    tier = 4,
  },
  scss = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'c478c6868648eff49eb04a4df90d703dc45b312a',
      url = 'https://github.com/serenadeai/tree-sitter-scss',
    },
    maintainers = { '@elianiva' },
    requires = { 'css' },
    tier = 3,
  },
  sflog = {
    install_info = {
      url = 'https://github.com/aheber/tree-sitter-sfapex',
      files = { 'src/parser.c' },
      location = 'sflog',
    },
    maintainers = { '@aheber', '@xixiaofinland' },
    readme_note = 'Salesforce debug log',
    tier = 3,
  },
  slang = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '865d79e236c7f0e04276c969453d021d1da4b15f',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-slang',
    },
    maintainers = { '@theHamsta' },
    readme_note = 'Shader Slang',
    tier = 2,
  },
  slint = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'd82ab8c19ea1b60ff570256eaef7d137cc5ecb63',
      url = 'https://github.com/slint-ui/tree-sitter-slint',
    },
    maintainers = { '@hunger' },
    tier = 3,
  },
  smali = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'fdfa6a1febc43c7467aa7e937b87b607956f2346',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-smali',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  smithy = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'fa898ac0885d1da9a253695c3e0e91f5efc587cd',
      url = 'https://github.com/indoorvivants/tree-sitter-smithy',
    },
    maintainers = { '@amaanq', '@keynmol' },
    tier = 3,
  },
  snakemake = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = 'ba1b3868eaa960b945593404af9a7c2f296d3643',
      url = 'https://github.com/osthomas/tree-sitter-snakemake',
    },
    maintainers = { '@osthomas' },
    tier = 3,
  },
  solidity = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '1c94fe3d5351dfcff3551ec1f49614cbf758e444',
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  soql = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'soql',
      revision = 'c99ad4b16d112fea91745e3f1b769754239fdaba',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sosl = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'sosl',
      revision = 'c99ad4b16d112fea91745e3f1b769754239fdaba',
      url = 'https://github.com/aheber/tree-sitter-sfapex',
    },
    maintainers = { '@aheber', '@xixiafinland' },
    tier = 3,
  },
  sourcepawn = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '64ad670dd59e88c5d32bc3d759ae8562b522cad9',
      url = 'https://github.com/nilshelmig/tree-sitter-sourcepawn',
    },
    maintainers = { '@Sarrus1' },
    tier = 3,
  },
  sparql = {
    install_info = {
      files = { 'src/parser.c' },
      generate_from_json = true,
      revision = '05f949d3c1c15e3261473a244d3ce87777374dec',
      url = 'https://github.com/GordianDziwis/tree-sitter-sparql',
    },
    maintainers = { '@GordianDziwis' },
    tier = 3,
  },
  sql = {
    install_info = {
      branch = 'gh-pages',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '6a99f4aff780f98bc119c7f034406e41d7e0b80d',
      url = 'https://github.com/derekstride/tree-sitter-sql',
    },
    maintainers = { '@derekstride' },
    tier = 3,
  },
  squirrel = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '0a50d31098e83c668d34d1160a0f6c7d23b571cc',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-squirrel',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  ssh_config = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '77450e8bce8853921512348f83c73c168c71fdfb',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ssh-config',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  starlark = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '018d0e09d9d0f0dd6740a37682b8ee4512e8b2ac',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-starlark',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  strace = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'd819cdd5dbe455bd3c859193633c8d91c0df7c36',
      url = 'https://github.com/sigmaSd/tree-sitter-strace',
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },
  styled = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '65835cca33a5f033bcde580ed66cde01c1fabbbe',
      url = 'https://github.com/mskelton/tree-sitter-styled',
    },
    maintainers = { '@mskelton' },
    tier = 3,
  },
  supercollider = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'affa4389186b6939d89673e1e9d2b28364f5ca6f',
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
    },
    maintainers = { '@madskjeldgaard' },
    tier = 3,
  },
  superhtml = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'tree-sitter-superhtml',
      url = 'https://github.com/kristoff-it/superhtml',
    },
    maintainers = { '@rockorager' },
    tier = 3,
  },
  surface = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'f4586b35ac8548667a9aaa4eae44456c1f43d032',
      url = 'https://github.com/connorlay/tree-sitter-surface',
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },
  svelte = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '2c97326cd96b7c3016c3d249e8dc244c89b4abeb',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-svelte',
    },
    maintainers = { '@amaanq' },
    requires = { 'html_tags' },
    tier = 2,
  },
  sway = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      url = 'https://github.com/FuelLabs/tree-sitter-sway.git',
    },
    maintainers = { '@ribru17' },
    tier = 2,
  },
  swift = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate = true,
      revision = '26354ddec08c7efde4fa16bd29429f3310d2e2c5',
      url = 'https://github.com/alex-pinkus/tree-sitter-swift',
    },
    maintainers = { '@alex-pinkus' },
    tier = 3,
  },
  sxhkdrc = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '440d5f913d9465c9c776a1bd92334d32febcf065',
      url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
    },
    maintainers = { '@RaafatTurki' },
    tier = 3,
  },
  systemtap = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '1af543a96d060b1f808982037bfc54cc02218edd',
      url = 'https://github.com/ok-ryoko/tree-sitter-systemtap',
    },
    maintainers = { '@ok-ryoko' },
    tier = 3,
  },
  t32 = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '6182836f4128725f1e74ce986840d7317021a015',
      url = 'https://gitlab.com/xasc/tree-sitter-t32',
    },
    maintainers = { '@xasc' },
    tier = 3,
  },
  tablegen = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'b1170880c61355aaf38fc06f4af7d3c55abdabc4',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tablegen',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  tact = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '034df2162ed7b654efd999942e266be713c7cde0',
      url = 'https://github.com/tact-lang/tree-sitter-tact',
    },
    maintainers = { '@novusnota' },
    tier = 3,
  },
  tcl = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '8784024358c233efd0f3a6fd9e7a3c5852e628bc',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tcl',
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },
  teal = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate = true,
      revision = '19b02da829d1721a521bf7b802eb80a50bd53aab',
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
    },
    maintainers = { '@euclidianAce' },
    tier = 3,
  },
  templ = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = 'cf84ea53e2e2531f23009d676ac206090c1e2392',
      url = 'https://github.com/vrischmann/tree-sitter-templ',
    },
    maintainers = { '@vrischmann' },
    tier = 3,
  },
  terraform = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'dialects/terraform',
      revision = 'e936d3fef8bac884661472dce71ad82284761eb1',
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
    },
    maintainers = { '@MichaHoffmann' },
    requires = { 'hcl' },
    tier = 3,
  },
  textproto = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8dacf02aa402892c91079f8577998ed5148c0496',
      url = 'https://github.com/PorterAtGoogle/tree-sitter-textproto',
    },
    maintainers = { '@Porter' },
    tier = 3,
  },
  thrift = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '68fd0d80943a828d9e6f49c58a74be1e9ca142cf',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-thrift',
    },
    maintainers = { '@amaanq', '@duskmoon314' },
    tier = 2,
  },
  tiger = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'a7f11d946b44244f71df41d2a78af0665d618dae',
      url = 'https://github.com/ambroisie/tree-sitter-tiger',
    },
    maintainers = { '@ambroisie' },
    tier = 3,
  },
  tlaplus = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '200f9dab6b23f3b9bb8f67fc811221517f56c373',
      url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
    },
    maintainers = { '@ahelwer', '@susliko' },
    tier = 3,
  },
  tmux = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '9138ea508410e0f34da2666609f600f65e944f22',
      url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  todotxt = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '3937c5cd105ec4127448651a21aef45f52d19609',
      url = 'https://github.com/arnarg/tree-sitter-todotxt',
    },
    maintainers = { '@arnarg' },
    tier = 3,
  },
  toml = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '16a30c83ce427385b8d14939c45c137fcfca6c42',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-toml',
    },
    maintainers = { '@tk-shirasaka' },
    tier = 2,
  },
  tsv = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'tsv',
      revision = '7eb7297823605392d2bbcc4c09b1cd18d6fa9529',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-csv',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  tsx = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      location = 'tsx',
      revision = '4ad3010c91d700026d036b5230e2d99ba94ae8a4',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx', 'typescript' },
    tier = 2,
  },
  turtle = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '085437f5cb117703b7f520dd92161140a684f092',
      url = 'https://github.com/GordianDziwis/tree-sitter-turtle',
    },
    maintainers = { '@GordianDziwis' },
    tier = 3,
  },
  twig = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'eaf80e6af969e25993576477a9dbdba3e48c1305',
      url = 'https://github.com/gbprod/tree-sitter-twig',
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },
  typescript = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      location = 'typescript',
      revision = '4ad3010c91d700026d036b5230e2d99ba94ae8a4',
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma' },
    tier = 2,
  },
  typespec = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '28821d0d6da5f0a6b5eb02b9bad953fecafd7248',
      url = 'https://github.com/happenslol/tree-sitter-typespec',
    },
    maintainers = { '@happenslol' },
    tier = 3,
  },
  typoscript = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '43b221c0b76e77244efdaa9963e402a17c930fbc',
      url = 'https://github.com/Teddytrombone/tree-sitter-typoscript',
    },
    maintainers = { '@Teddytrombone' },
    tier = 3,
  },
  typst = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '3924cb9ed9e0e62ce7df9c4fe0faa4c234795999',
      url = 'https://github.com/uben0/tree-sitter-typst',
    },
    maintainers = { '@uben0', '@RaafatTurki' },
    tier = 3,
  },
  udev = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8f58696e79092b4ad6bf197415bbd0970acf15cd',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-udev',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  ungrammar = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'debd26fed283d80456ebafa33a06957b0c52e451',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-ungrammar',
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 2,
  },
  unison = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate = true,
      revision = '59d36a09282be7e4d3374854126590f3dcebee6e',
      url = 'https://github.com/kylegoetz/tree-sitter-unison',
    },
    maintainers = { '@tapegram' },
    tier = 3,
  },
  usd = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '4e0875f724d94d0c2ff36f9b8cb0b12f8b20d216',
      url = 'https://github.com/ColinKennedy/tree-sitter-usd',
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },
  uxntal = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'ad9b638b914095320de85d59c49ab271603af048',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-uxntal',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  v = {
    install_info = {
      files = { 'src/parser.c' },
      location = 'tree_sitter_v',
      revision = '7e11a6f8f369df935664fadd2f0c99d90fe3226f',
      url = 'https://github.com/vlang/v-analyzer',
    },
    maintainers = { '@kkharji', '@amaanq' },
    tier = 3,
  },
  vala = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '8f690bfa639f2b83d1fb938ed3dd98a7ba453e8b',
      url = 'https://github.com/vala-lang/tree-sitter-vala',
    },
    maintainers = { '@Prince781' },
    tier = 3,
  },
  vento = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '3321077d7446c1b3b017c294fd56ce028ed817fe',
      url = 'https://github.com/ventojs/tree-sitter-vento',
    },
    maintainers = { '@wrapperup', '@oscarotero' },
    tier = 3,
  },
  verilog = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '075ebfc84543675f12e79a955f79d717772dcef3',
      url = 'https://github.com/gmlarumbe/tree-sitter-systemverilog',
    },
    maintainers = { '@zhangwwpeng' },
    tier = 3,
  },
  vhdl = {
    install_info = {
      url = 'https://github.com/jpt13653903/tree-sitter-vhdl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@jpt13653903' },
    tier = 3,
  },
  vhs = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '90028bbadb267ead5b87830380f6a825147f0c0f',
      url = 'https://github.com/charmbracelet/tree-sitter-vhs',
    },
    maintainers = { '@caarlos0' },
    tier = 3,
  },
  vim = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'b448ca63f972ade12c373c808acdd2bf972937db',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-vim',
    },
    maintainers = { '@clason' },
    tier = 1,
  },
  vimdoc = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'b711df784dd43d0a8ed8ddbfca0ddcc3239d94b4',
      url = 'https://github.com/neovim/tree-sitter-vimdoc',
    },
    maintainers = { '@clason' },
    tier = 1,
  },
  vrl = {
    install_info = {
      url = 'https://github.com/belltoy/tree-sitter-vrl',
      files = { 'src/parser.c' },
    },
    maintainers = { '@belltoy' },
    tier = 3,
  },
  vue = {
    install_info = {
      branch = 'main',
      files = { 'src/parser.c', 'src/scanner.c' },
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
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '40259f3c77ea856841a4e0c4c807705f3e4a2b65',
      url = 'https://github.com/szebniok/tree-sitter-wgsl',
    },
    maintainers = { '@szebniok' },
    tier = 3,
  },
  wgsl_bevy = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_from_json = true,
      revision = '1e12c7925c41bb09818d86e30cd78644fde7d31a',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy',
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },
  wing = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'bd1d35cf3e013dc7e189b46a593bdc2b281b0dd7',
      url = 'https://github.com/winglang/tree-sitter-wing',
    },
    maintainers = { '@gshpychka', '@MarkMcCulloh' },
    tier = 3,
  },
  wit = {
    install_info = {
      files = { 'src/parser.c' },
      revision = 'cab94791450524a542324d8cbe8017d69c516d8e',
      url = 'https://github.com/liamwh/tree-sitter-wit',
    },
    maintainers = { '@liamwh' },
    tier = 3,
  },
  xcompose = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '2383cc69a2c42cfade41c7cb971fb3862bec6df1',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xcompose',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },
  xml = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'xml',
      revision = '648183d86f6f8ffb240ea11b4c6873f6f45d8b67',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'dtd' },
    tier = 2,
  },
  xresources = {
    install_info = {
      url = 'https://github.com/ValdezFOmar/tree-sitter-xresources',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ValdezFOmar' },
    tier = 3,
  },
  yaml = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '7b03feefd36b5f155465ca736c6304aca983b267',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-yaml',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  yang = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '2c0e6be8dd4dcb961c345fa35c309ad4f5bd3502',
      url = 'https://github.com/Hubro/tree-sitter-yang',
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },
  yuck = {
    install_info = {
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = 'e877f6ade4b77d5ef8787075141053631ba12318',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-yuck',
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 2,
  },
  zathurarc = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '6e7c8edfcd6f5f7c12b2fa9ffc6d042f1b6d7068',
      url = 'https://github.com/Freed-Wu/tree-sitter-zathurarc',
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },
  zig = {
    install_info = {
      files = { 'src/parser.c' },
      revision = '0d08703e4c3f426ec61695d7617415fff97029bd',
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-zig',
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },

  ziggy = {
    install_info = {
      url = 'https://github.com/kristoff-it/ziggy',
      files = { 'src/parser.c' },
      location = 'tree-sitter-ziggy',
    },
    maintainers = { '@rockorager' },
    tier = 3,
  },

  ziggy_schema = {
    install_info = {
      url = 'https://github.com/kristoff-it/ziggy',
      files = { 'src/parser.c' },
      location = 'tree-sitter-ziggy-schema',
    },
    maintainers = { '@rockorager' },
    tier = 3,
  },
}
