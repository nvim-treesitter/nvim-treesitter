---@class InstallInfo
---@field url string
---@field branch string|nil
---@field files string[]
---@field generate_requires_npm boolean|nil
---@field requires_generate_from_grammar boolean|nil
---@field location string|nil

---@class ParserInfo
---@field install_info InstallInfo?
---@field filetype string[]?
---@field maintainers string[]?
---@field requires string[]?
---@field tier integer|nil
---@field readme_note string|nil?

local M = {}

M.tiers = { 'stable', 'core', 'community', 'unsupported' }

---@type table<string,ParserInfo>
M.configs = {
  ada = {
    install_info = {
      url = 'https://github.com/briot/tree-sitter-ada',
      files = { 'src/parser.c' },
    },
    maintainers = { '@briot' },
    tier = 3,
  },

  agda = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-agda',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Decodetalkers' },
    tier = 3,
  },

  angular = {
    install_info = {
      url = 'https://github.com/dlvandenberg/tree-sitter-angular',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@dlvandenberg' },
    requires = { 'html', 'html_tags' },
    tier = 4,
  },

  apex = {
    install_info = {
      url = 'https://github.com/aheber/tree-sitter-sfapex',
      files = { 'src/parser.c' },
      location = 'apex',
    },
    maintainers = { '@aheber' },
    tier = 3,
  },

  arduino = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-arduino',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'cpp' },
    tier = 2,
  },

  asm = {
    install_info = {
      url = 'https://github.com/RubixDev/tree-sitter-asm',
      files = { 'src/parser.c' },
    },
    maintainers = { '@RubixDev' },
    tier = 3,
  },

  astro = {
    install_info = {
      url = 'https://github.com/virchau13/tree-sitter-astro',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@virchau13' },
    requires = { 'html', 'html_tags' },
    tier = 4,
  },

  authzed = {
    install_info = {
      url = 'https://github.com/mleonidas/tree-sitter-authzed',
      files = { 'src/parser.c' },
    },
    maintainers = { '@mattpolzin' },
    tier = 3,
  },

  awk = {
    install_info = {
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  bash = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-bash',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@TravonteD' },
    tier = 3,
  },

  bass = {
    install_info = {
      url = 'https://github.com/vito/tree-sitter-bass',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  beancount = {
    install_info = {
      url = 'https://github.com/polarmutex/tree-sitter-beancount',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@polarmutex' },
    tier = 4,
  },

  bibtex = {
    install_info = {
      url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 2,
  },

  bicep = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-bicep',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  bitbake = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-bitbake',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  blueprint = {
    install_info = {
      url = 'https://gitlab.com/gabmus/tree-sitter-blueprint.git',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gabmus' },
    tier = 4,
  },

  c = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-c',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 1,
  },

  c_sharp = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Luxed' },
    tier = 3,
  },

  cairo = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-cairo',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  capnp = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-capnp',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  chatito = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-chatito',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  clojure = {
    install_info = {
      url = 'https://github.com/sogaiu/tree-sitter-clojure',
      files = { 'src/parser.c' },
    },
    maintainers = { '@NoahTheDuke' },
    tier = 3,
  },

  cmake = {
    install_info = {
      url = 'https://github.com/uyha/tree-sitter-cmake',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@uyha' },
    tier = 4,
  },

  comment = {
    install_info = {
      url = 'https://github.com/stsewd/tree-sitter-comment',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stsewd' },
    tier = 2,
  },

  commonlisp = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-commonlisp',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },

  cooklang = {
    install_info = {
      url = 'https://github.com/addcninblue/tree-sitter-cooklang',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@addcninblue' },
    tier = 3,
  },

  corn = {
    install_info = {
      url = 'https://github.com/jakestanger/tree-sitter-corn',
      files = { 'src/parser.c' },
    },
    maintainers = { '@jakestanger' },
    tier = 3,
  },

  cpon = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-cpon',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  cpp = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 1,
  },

  css = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-css',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@TravonteD' },
    tier = 3,
  },

  csv = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-csv',
      files = { 'src/parser.c' },
      location = 'csv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },

  cuda = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-cuda',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },

  cue = {
    install_info = {
      url = 'https://github.com/eonpatapon/tree-sitter-cue',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  d = {
    install_info = {
      url = 'https://github.com/gdamore/tree-sitter-d',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 2,
    maintainers = { '@amaanq' },
  },

  dart = {
    install_info = {
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@akinsho' },
    tier = 4,
  },

  devicetree = {
    install_info = {
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
      files = { 'src/parser.c' },
    },
    maintainers = { '@jedrzejboczar' },
    tier = 3,
  },

  dhall = {
    install_info = {
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  diff = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-diff',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },

  disassembly = {
    install_info = {
      url = 'https://github.com/ColinKennedy/tree-sitter-disassembly',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },

  dockerfile = {
    install_info = {
      url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
      files = { 'src/parser.c' },
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },

  dot = {
    install_info = {
      url = 'https://github.com/rydesun/tree-sitter-dot',
      files = { 'src/parser.c' },
    },
    maintainers = { '@rydesun' },
    tier = 3,
  },

  doxygen = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-doxygen',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  dtd = {
    install_info = {
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'dtd',
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  ebnf = {
    install_info = {
      url = 'https://github.com/RubixDev/ebnf',
      files = { 'src/parser.c' },
      location = 'crates/tree-sitter-ebnf',
    },
    maintainers = { '@RubixDev' },
    tier = 4,
  },

  ecma = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, typescript, tsx, qmljs',
    tier = 2,
  },

  eds = {
    install_info = {
      url = 'https://github.com/uyha/tree-sitter-eds',
      files = { 'src/parser.c' },
    },
    maintainers = { '@uyha' },
    tier = 3,
  },

  eex = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-eex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },

  elixir = {
    install_info = {
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },

  elm = {
    install_info = {
      url = 'https://github.com/elm-tooling/tree-sitter-elm',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@zweimach' },
    tier = 4,
  },

  elsa = {
    install_info = {
      url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
      files = { 'src/parser.c' },
    },
    maintainers = { '@glapa-grossklag', '@amaanq' },
    tier = 2,
  },

  elvish = {
    install_info = {
      url = 'https://github.com/elves/tree-sitter-elvish',
      files = { 'src/parser.c' },
    },
    maintainers = { '@elves' },
    tier = 3,
  },

  embedded_template = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
      files = { 'src/parser.c' },
    },
    tier = 4,
  },

  erlang = {
    install_info = {
      url = 'https://github.com/WhatsApp/tree-sitter-erlang',
      files = { 'src/parser.c' },
    },
    maintainers = { '@filmor' },
    tier = 3,
  },

  facility = {
    install_info = {
      url = 'https://github.com/FacilityApi/tree-sitter-facility',
      files = { 'src/parser.c' },
    },
    maintainers = { '@bryankenote' },
    tier = 3,
  },

  faust = {
    install_info = {
      url = 'https://github.com/khiner/tree-sitter-faust',
      files = { 'src/parser.c' },
    },
    maintainers = { '@khiner' },
    tier = 3,
  },

  fennel = {
    install_info = {
      url = 'https://github.com/alexmozaidze/tree-sitter-fennel',
      files = { 'src/parser.c' },
    },
    maintainers = { '@alexmozaidze' },
    tier = 3,
  },

  fidl = {
    install_info = {
      url = 'https://github.com/google/tree-sitter-fidl',
      files = { 'src/parser.c' },
    },
    maintainers = { '@chaopeng' },
    tier = 3,
  },

  firrtl = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-firrtl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  fish = {
    install_info = {
      url = 'https://github.com/ram02z/tree-sitter-fish',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ram02z' },
    tier = 3,
  },

  foam = {
    install_info = {
      url = 'https://github.com/FoamScience/tree-sitter-foam',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@FoamScience' },
    tier = 3,
  },

  forth = {
    install_info = {
      url = 'https://github.com/AlexanderBrevig/tree-sitter-forth',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  fortran = {
    install_info = {
      url = 'https://github.com/stadelmanma/tree-sitter-fortran',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  fsh = {
    install_info = {
      url = 'https://github.com/mgramigna/tree-sitter-fsh',
      files = { 'src/parser.c' },
    },
    maintainers = { '@mgramigna' },
    tier = 3,
  },

  func = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-func',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  fusion = {
    install_info = {
      url = 'https://gitlab.com/jirgn/tree-sitter-fusion.git',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@jirgn' },
    tier = 3,
  },

  gdscript = {
    install_info = {
      url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@PrestonKnopp' },
    readme_note = 'Godot',
    tier = 3,
  },

  git_rebase = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },

  gitattributes = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-gitattributes',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  gitcommit = {
    install_info = {
      url = 'https://github.com/gbprod/tree-sitter-gitcommit',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },

  git_config = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  gitignore = {
    install_info = {
      url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },

  gleam = {
    install_info = {
      url = 'https://github.com/gleam-lang/tree-sitter-gleam',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  glimmer = {
    install_info = {
      url = 'https://github.com/alexlafroscia/tree-sitter-glimmer',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@NullVoxPopuli' },
    readme_note = 'Glimmer and Ember',
    tier = 3,
  },

  glsl = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-glsl',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
    tier = 2,
  },

  gn = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-gn',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    readme_name = 'GN (Generate Ninja)',
    tier = 2,
  },

  gnuplot = {
    install_info = {
      url = 'https://github.com/dpezto/tree-sitter-gnuplot',
      files = { 'src/parser.c' },
    },
    maintainers = { '@dpezto' },
    tier = 3,
  },

  go = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-go',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta', '@WinWisely268' },
    tier = 1,
  },

  godot_resource = {
    install_info = {
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
    tier = 3,
  },

  gomod = {
    install_info = {
      url = 'https://github.com/camdencheek/tree-sitter-go-mod',
      files = { 'src/parser.c' },
    },
    maintainers = { '@camdencheek' },
    tier = 3,
  },

  gosum = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-go-sum',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  gowork = {
    install_info = {
      url = 'https://github.com/omertuc/tree-sitter-go-work',
      files = { 'src/parser.c' },
    },
    maintainers = { '@omertuc' },
    tier = 3,
  },

  graphql = {
    install_info = {
      url = 'https://github.com/bkegley/tree-sitter-graphql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@bkegley' },
    tier = 3,
  },

  gpg = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-gpg-config',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  groovy = {
    install_info = {
      url = 'https://github.com/murtaza64/tree-sitter-groovy',
      files = { 'src/parser.c' },
    },
    maintainers = { '@murtaza64' },
    tier = 3,
  },

  gstlaunch = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-gstlaunch',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },

  hack = {
    install_info = {
      url = 'https://github.com/slackhq/tree-sitter-hack',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  hare = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-hare',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  haskell = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-haskell',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@mrcjkb' },
    tier = 3,
  },

  haskell_persistent = {
    install_info = {
      url = 'https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@lykahb' },
    tier = 3,
  },

  hcl = {
    install_info = {
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@MichaHoffmann' },
    tier = 3,
  },

  heex = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-heex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },

  hjson = {
    install_info = {
      url = 'https://github.com/winston0410/tree-sitter-hjson',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@winston0410' },
    requires = { 'json' },
    tier = 3,
  },

  hlsl = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-hlsl',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
    tier = 2,
  },

  hlsplaylist = {
    install_info = {
      url = 'https://github.com/Freed-Wu/tree-sitter-hlsplaylist',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },

  hocon = {
    install_info = {
      url = 'https://github.com/antosha417/tree-sitter-hocon',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@antosha417' },
    tier = 4,
  },

  hoon = {
    install_info = {
      url = 'https://github.com/urbit-pilled/tree-sitter-hoon',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@urbit-pilled' },
    tier = 4,
  },

  html_tags = {
    maintainers = { '@TravonteD' },
    readme_note = 'queries required by html, astro, vue, svelte',
    tier = 3,
  },

  html = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-html',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@TravonteD' },
    requires = { 'html_tags' },
    tier = 3,
  },

  htmldjango = {
    install_info = {
      url = 'https://github.com/interdependence/tree-sitter-htmldjango',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 4,
  },

  http = {
    install_info = {
      url = 'https://github.com/rest-nvim/tree-sitter-http',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  hurl = {
    install_info = {
      url = 'https://github.com/pfeiferj/tree-sitter-hurl',
      files = { 'src/parser.c' },
    },
    maintainers = { '@pfeiferj' },
    tier = 3,
  },

  hyprlang = {
    install_info = {
      url = 'https://github.com/luckasRanarison/tree-sitter-hyprlang',
      files = { 'src/parser.c' },
    },
    maintainers = { '@luckasRanarison' },
    tier = 3,
  },

  ini = {
    install_info = {
      url = 'https://github.com/justinmk/tree-sitter-ini',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 4,
  },

  ispc = {
    install_info = {
      url = 'https://github.com/fab4100/tree-sitter-ispc',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@fab4100' },
    requires = { 'c' },
    tier = 3,
  },

  janet_simple = {
    install_info = {
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@sogaiu' },
    tier = 3,
  },

  java = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-java',
      files = { 'src/parser.c' },
    },
    maintainers = { '@p00f' },
    tier = 3,
  },

  javascript = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
    tier = 2,
  },

  jq = {
    install_info = {
      url = 'https://github.com/flurie/tree-sitter-jq',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  jsdoc = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },

  json = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-json',
      files = { 'src/parser.c' },
    },
    maintainers = { '@steelsojka' },
    tier = 2,
  },

  json5 = {
    install_info = {
      url = 'https://github.com/Joakker/tree-sitter-json5',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Joakker' },
    tier = 3,
  },

  jsonc = {
    install_info = {
      url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@WhyNotHugo' },
    requires = { 'json' },
    tier = 3,
  },

  jsonnet = {
    install_info = {
      url = 'https://github.com/sourcegraph/tree-sitter-jsonnet',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@nawordar' },
    tier = 3,
  },

  jsx = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, tsx',
    tier = 2,
  },

  julia = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-julia',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },

  kconfig = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-kconfig',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  kdl = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-kdl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  kotlin = {
    install_info = {
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@SalBakraa' },
    tier = 3,
  },

  kusto = {
    install_info = {
      url = 'https://github.com/Willem-J-an/tree-sitter-kusto',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Willem-J-an' },
    tier = 3,
  },

  lalrpop = {
    install_info = {
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@traxys' },
    tier = 3,
  },

  latex = {
    install_info = {
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 2,
  },

  ledger = {
    install_info = {
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
      files = { 'src/parser.c' },
    },
    maintainers = { '@cbarrete' },
    tier = 3,
  },

  leo = {
    install_info = {
      url = 'https://github.com/r001/tree-sitter-leo',
      files = { 'src/parser.c' },
    },
    maintainers = { '@r001' },
    tier = 3,
  },

  llvm = {
    install_info = {
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
      files = { 'src/parser.c' },
    },
    maintainers = { '@benwilliamgraham' },
    tier = 3,
  },

  linkerscript = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-linkerscript',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  liquidsoap = {
    install_info = {
      url = 'https://github.com/savonet/tree-sitter-liquidsoap',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@toots' },
    tier = 4,
  },

  lua = {
    install_info = {
      url = 'https://github.com/MunifTanjim/tree-sitter-lua',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@muniftanjim' },
    tier = 1,
  },

  luadoc = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-luadoc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  luap = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-luap',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    readme_note = 'Lua patterns',
    tier = 2,
  },

  luau = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-luau',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    requires = { 'lua' },
    tier = 2,
  },

  m68k = {
    install_info = {
      url = 'https://github.com/grahambates/tree-sitter-m68k',
      files = { 'src/parser.c' },
    },
    maintainers = { '@grahambates' },
    tier = 3,
  },

  make = {
    install_info = {
      url = 'https://github.com/alemuller/tree-sitter-make',
      files = { 'src/parser.c' },
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },

  markdown = {
    install_info = {
      url = 'https://github.com/MDeiml/tree-sitter-markdown',
      location = 'tree-sitter-markdown',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@MDeiml' },
    readme_note = 'basic highlighting',
    requires = { 'markdown_inline' },
    tier = 1,
  },

  markdown_inline = {
    install_info = {
      url = 'https://github.com/MDeiml/tree-sitter-markdown',
      location = 'tree-sitter-markdown-inline',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@MDeiml' },
    readme_note = 'needed for full highlighting',
    tier = 1,
  },

  matlab = {
    install_info = {
      url = 'https://github.com/acristoffers/tree-sitter-matlab',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@acristoffers' },
    tier = 3,
  },

  menhir = {
    install_info = {
      url = 'https://github.com/Kerl13/tree-sitter-menhir',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Kerl13' },
    tier = 3,
  },

  mermaid = {
    install_info = {
      url = 'https://github.com/monaqa/tree-sitter-mermaid',
      files = { 'src/parser.c' },
    },
    tier = 4,
  },

  meson = {
    install_info = {
      url = 'https://github.com/Decodetalkers/tree-sitter-meson',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Decodetalkers' },
    tier = 3,
  },

  mlir = {
    install_info = {
      url = 'https://github.com/artagnon/tree-sitter-mlir',
      files = { 'src/parser.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@artagnon' },
    tier = 4,
  },

  muttrc = {
    install_info = {
      url = 'https://github.com/neomutt/tree-sitter-muttrc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },

  nasm = {
    install_info = {
      url = 'https://github.com/naclsn/tree-sitter-nasm',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  nickel = {
    install_info = {
      url = 'https://github.com/nickel-lang/tree-sitter-nickel',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  nim = {
    install_info = {
      url = 'https://github.com/alaviss/tree-sitter-nim',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@aMOPel' },
    requires = { 'nim_format_string' },
    tier = 3,
  },

  nim_format_string = {
    install_info = {
      url = 'https://github.com/aMOPel/tree-sitter-nim-format-string',
      files = { 'src/parser.c' },
    },
    maintainers = { '@aMOPel' },
    tier = 3,
  },

  ninja = {
    install_info = {
      url = 'https://github.com/alemuller/tree-sitter-ninja',
      files = { 'src/parser.c' },
    },
    maintainers = { '@alemuller' },
    tier = 3,
  },

  nix = {
    install_info = {
      url = 'https://github.com/cstrahan/tree-sitter-nix',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },

  nqc = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-nqc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  objc = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-objc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    requires = { 'c' },
    tier = 2,
  },

  objdump = {
    install_info = {
      url = 'https://github.com/ColinKennedy/tree-sitter-objdump',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },

  ocaml = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'ocaml',
    },
    maintainers = { '@undu' },
    tier = 3,
  },

  ocaml_interface = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'interface',
    },
    maintainers = { '@undu' },
    requires = { 'ocaml' },
    tier = 3,
  },

  ocamllex = {
    install_info = {
      url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@undu' },
    tier = 3,
  },

  odin = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-odin',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  pascal = {
    install_info = {
      url = 'https://github.com/Isopod/tree-sitter-pascal.git',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Isopod' },
    tier = 3,
  },

  passwd = {
    install_info = {
      url = 'https://github.com/ath3/tree-sitter-passwd',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 3,
  },

  pem = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-pem',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  perl = {
    install_info = {
      url = 'https://github.com/tree-sitter-perl/tree-sitter-perl',
      branch = 'release',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },

  php = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-php',
      location = 'php',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@tk-shirasaka' },
    requires = { 'php_only' },
    readme_note = 'PHP with embedded HTML',
    tier = 3,
  },

  php_only = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-php',
      location = 'php_only',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@tk-shirasaka' },
    readme_note = 'PHP without embedded HTML',
    tier = 3,
  },

  phpdoc = {
    install_info = {
      url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@mikehaertl' },
    tier = 4,
  },

  pioasm = {
    install_info = {
      url = 'https://github.com/leo60228/tree-sitter-pioasm',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@leo60228' },
    tier = 3,
  },

  po = {
    install_info = {
      url = 'https://github.com/erasin/tree-sitter-po',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  pod = {
    install_info = {
      url = 'https://github.com/tree-sitter-perl/tree-sitter-pod',
      files = { 'src/parser.c', 'src/scanner.c' },
      branch = 'release',
    },
    maintainers = { '@RabbiVeesh', '@LeoNerd' },
    tier = 3,
  },

  poe_filter = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-poe-filter',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    readme_note = 'Path of Exile item filter',
    tier = 4,
  },

  pony = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-pony',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq', '@mfelsche' },
    tier = 2,
  },

  printf = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-printf',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  prisma = {
    install_info = {
      url = 'https://github.com/victorhqc/tree-sitter-prisma',
      files = { 'src/parser.c' },
    },
    maintainers = { '@elianiva' },
    tier = 3,
  },

  properties = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-properties',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
    readme_note = 'Java properties files',
  },

  proto = {
    install_info = {
      url = 'https://github.com/treywood/tree-sitter-proto',
      files = { 'src/parser.c' },
    },
    maintainers = { '@treywood' },
    tier = 3,
  },

  promql = {
    install_info = {
      url = 'https://github.com/MichaHoffmann/tree-sitter-promql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@MichaHoffmann' },
    tier = 4,
  },

  prql = {
    install_info = {
      url = 'https://github.com/PRQL/tree-sitter-prql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@matthias-Q' },
    tier = 2,
  },

  psv = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-csv',
      files = { 'src/parser.c' },
      location = 'psv',
    },
    maintainers = { '@amaanq' },
    requires = { 'tsv' },
    tier = 2,
  },

  pug = {
    install_info = {
      url = 'https://github.com/zealot128/tree-sitter-pug',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@zealot128' },
    tier = 4,
  },

  puppet = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-puppet',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  purescript = {
    install_info = {
      url = 'https://github.com/postsolar/tree-sitter-purescript',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@postsolar' },
    tier = 3,
  },

  pymanifest = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-pymanifest',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'PyPA manifest',
    tier = 2,
  },

  python = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-python',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stsewd', '@theHamsta' },
    tier = 1,
  },

  ql = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@pwntester' },
    tier = 3,
  },

  qmldir = {
    install_info = {
      url = 'https://github.com/Decodetalkers/tree-sitter-qmldir',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  qmljs = {
    install_info = {
      url = 'https://github.com/yuja/tree-sitter-qmljs',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
    tier = 3,
  },

  query = {
    install_info = {
      url = 'https://github.com/nvim-treesitter/tree-sitter-query',
      files = { 'src/parser.c' },
    },
    maintainers = { '@steelsojka' },
    readme_note = 'Tree-sitter query language',
    tier = 1,
  },

  r = {
    install_info = {
      url = 'https://github.com/r-lib/tree-sitter-r',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@echasnovski' },
    tier = 3,
  },

  racket = {
    install_info = {
      url = 'https://github.com/6cdh/tree-sitter-racket',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  rasi = {
    install_info = {
      url = 'https://github.com/Fymyte/tree-sitter-rasi',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Fymyte' },
    tier = 3,
  },

  rbs = {
    install_info = {
      url = 'https://github.com/joker1007/tree-sitter-rbs',
      files = { 'src/parser.c' },
    },
    maintainers = { '@joker1007' },
    tier = 3,
  },

  re2c = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-re2c',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  readline = {
    install_info = {
      url = 'https://github.com/ribru17/tree-sitter-readline',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ribru17' },
    tier = 3,
  },

  regex = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-regex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 1,
  },

  rego = {
    install_info = {
      url = 'https://github.com/FallenAngel97/tree-sitter-rego',
      files = { 'src/parser.c' },
    },
    maintainers = { '@FallenAngel97' },
    tier = 3,
  },

  requirements = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-requirements',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    readme_name = 'pip requirements',
    tier = 2,
  },

  rnoweb = {
    install_info = {
      url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@bamonroe' },
    tier = 3,
  },

  robot = {
    install_info = {
      url = 'https://github.com/Hubro/tree-sitter-robot',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },

  ron = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-ron',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  rst = {
    install_info = {
      url = 'https://github.com/stsewd/tree-sitter-rst',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stsewd' },
    tier = 2,
  },

  ruby = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ruby',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@TravonteD' },
    tier = 3,
  },

  rust = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  scala = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stevanmilic' },
    tier = 3,
  },

  scfg = {
    install_info = {
      url = 'https://git.sr.ht/~rockorager/tree-sitter-scfg',
      files = { 'src/parser.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@WhyNotHugo' },
    tier = 3,
  },

  scheme = {
    install_info = {
      url = 'https://github.com/6cdh/tree-sitter-scheme',
      files = { 'src/parser.c' },
    },
    tier = 4,
  },

  scss = {
    install_info = {
      url = 'https://github.com/serenadeai/tree-sitter-scss',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@elianiva' },
    requires = { 'css' },
    tier = 3,
  },

  slang = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-slang',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    readme_note = 'Shader Slang',
    maintainers = { '@theHamsta' },
    tier = 4,
  },

  slint = {
    install_info = {
      url = 'https://github.com/slint-ui/tree-sitter-slint',
      files = { 'src/parser.c' },
    },
    maintainers = { '@hunger' },
    tier = 3,
  },

  smali = {
    install_info = {
      url = 'https://git.sr.ht/~yotam/tree-sitter-smali',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  snakemake = {
    install_info = {
      url = 'https://github.com/osthomas/tree-sitter-snakemake',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainer = { '@osthomas' },
    tier = 4,
  },

  smithy = {
    install_info = {
      url = 'https://github.com/indoorvivants/tree-sitter-smithy',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq', '@keynmol' },
    tier = 2,
  },

  solidity = {
    install_info = {
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },
  soql = {
    install_info = {
      url = 'https://github.com/aheber/tree-sitter-sfapex',
      files = { 'src/parser.c' },
      location = 'soql',
    },
    maintainers = { '@aheber' },
    tier = 3,
  },

  sosl = {
    install_info = {
      url = 'https://github.com/aheber/tree-sitter-sfapex',
      files = { 'src/parser.c' },
      location = 'sosl',
    },
    maintainers = { '@aheber' },
  },

  sourcepawn = {
    install_info = {
      url = 'https://github.com/nilshelmig/tree-sitter-sourcepawn',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Sarrus1' },
    tier = 3,
  },

  sparql = {
    install_info = {
      url = 'https://github.com/BonaBeavis/tree-sitter-sparql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@BonaBeavis' },
    tier = 3,
  },

  sql = {
    install_info = {
      url = 'https://github.com/derekstride/tree-sitter-sql',
      files = { 'src/parser.c', 'src/scanner.c' },
      branch = 'gh-pages',
    },
    maintainers = { '@derekstride' },
    tier = 3,
  },

  squirrel = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-squirrel',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  ssh_config = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-ssh-config',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  starlark = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-starlark',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  strace = {
    install_info = {
      url = 'https://github.com/sigmaSd/tree-sitter-strace',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  styled = {
    install_info = {
      url = 'https://github.com/mskelton/tree-sitter-styled',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@mskelton' },
    tier = 3,
  },

  supercollider = {
    install_info = {
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@madskjeldgaard' },
    tier = 3,
  },

  surface = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-surface',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
    tier = 3,
  },

  svelte = {
    install_info = {
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-svelte',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    requires = { 'html_tags' },
    tier = 2,
  },

  swift = {
    install_info = {
      url = 'https://github.com/alex-pinkus/tree-sitter-swift',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@alex-pinkus' },
    tier = 3,
  },

  sxhkdrc = {
    install_info = {
      url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@RaafatTurki' },
    tier = 3,
  },

  systemtap = {
    install_info = {
      url = 'https://github.com/ok-ryoko/tree-sitter-systemtap',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ok-ryoko' },
    tier = 3,
  },

  t32 = {
    install_info = {
      url = 'https://gitlab.com/xasc/tree-sitter-t32.git',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@xasc' },
    tier = 3,
  },

  tablegen = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-tablegen',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  teal = {
    install_info = {
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@euclidianAce' },
    tier = 3,
  },

  templ = {
    install_info = {
      url = 'https://github.com/vrischmann/tree-sitter-templ',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@vrischmann' },
    tier = 3,
  },

  tcl = {
    install_info = {
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-tcl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@lewis6991' },
    tier = 2,
  },

  terraform = {
    install_info = {
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'dialects/terraform',
    },
    maintainers = { '@MichaHoffmann' },
    requires = { 'hcl' },
    tier = 3,
  },

  textproto = {
    install_info = {
      url = 'https://github.com/PorterAtGoogle/tree-sitter-textproto',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Porter' },
    tier = 3,
  },

  thrift = {
    install_info = {
      url = 'https://github.com/duskmoon314/tree-sitter-thrift',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq', '@duskmoon314' },
    tier = 2,
  },

  tiger = {
    install_info = {
      url = 'https://github.com/ambroisie/tree-sitter-tiger',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ambroisie' },
    tier = 3,
  },

  tlaplus = {
    install_info = {
      url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@ahelwer', '@susliko' },
    tier = 4,
  },

  tmux = {
    install_info = {
      url = 'https://github.com/Freed-Wu/tree-sitter-tmux',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },

  todotxt = {
    install_info = {
      url = 'https://github.com/arnarg/tree-sitter-todotxt.git',
      files = { 'src/parser.c' },
    },
    maintainers = { '@arnarg' },
    tier = 4,
  },

  toml = {
    install_info = {
      url = 'https://github.com/ikatyang/tree-sitter-toml',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@tk-shirasaka' },
    tier = 3,
  },

  tsv = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-csv',
      files = { 'src/parser.c' },
      location = 'tsv',
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  tsx = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'tsx',
      generate_requires_npm = true,
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx', 'typescript' },
    tier = 2,
  },

  turtle = {
    install_info = {
      url = 'https://github.com/BonaBeavis/tree-sitter-turtle',
      files = { 'src/parser.c' },
    },
    maintainers = { '@BonaBeavis' },
    tier = 3,
  },

  twig = {
    install_info = {
      url = 'https://github.com/gbprod/tree-sitter-twig',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
    tier = 3,
  },

  typescript = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-typescript',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'typescript',
      generate_requires_npm = true,
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma' },
    tier = 2,
  },

  typoscript = {
    install_info = {
      url = 'https://github.com/Teddytrombone/tree-sitter-typoscript',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Teddytrombone' },
    tier = 3,
  },

  typst = {
    install_info = {
      url = 'https://github.com/uben0/tree-sitter-typst',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@uben0', '@RaafatTurki' },
    tier = 3,
  },

  udev = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-udev',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  ungrammar = {
    install_info = {
      url = 'https://github.com/Philipp-M/tree-sitter-ungrammar',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 3,
  },

  unison = {
    install_info = {
      url = 'https://github.com/kylegoetz/tree-sitter-unison',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@tapegram' },
    tier = 4,
  },

  usd = {
    install_info = {
      url = 'https://github.com/ColinKennedy/tree-sitter-usd',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ColinKennedy' },
    tier = 3,
  },

  uxntal = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-uxntal',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    tier = 2,
  },

  v = {
    install_info = {
      url = 'https://github.com/vlang/v-analyzer',
      files = { 'src/parser.c' },
      location = 'tree_sitter_v',
    },
    maintainers = { '@kkharji', '@amaanq' },
    tier = 3,
  },

  vala = {
    install_info = {
      url = 'https://github.com/vala-lang/tree-sitter-vala',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Prince781' },
    tier = 3,
  },

  verilog = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-verilog',
      files = { 'src/parser.c' },
    },
    maintainers = { '@zegervdv' },
    tier = 3,
  },

  vhs = {
    install_info = {
      url = 'https://github.com/charmbracelet/tree-sitter-vhs',
      files = { 'src/parser.c' },
    },
    maintainers = { '@caarlos0' },
    tier = 3,
  },

  vim = {
    install_info = {
      url = 'https://github.com/neovim/tree-sitter-vim',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@clason' },
    tier = 1,
  },

  vimdoc = {
    install_info = {
      url = 'https://github.com/neovim/tree-sitter-vimdoc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@clason' },
    tier = 1,
  },

  vue = {
    install_info = {
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-vue',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@WhyNotHugo' },
    requires = { 'html_tags' },
    tier = 3,
  },

  wing = {
    install_info = {
      url = 'https://github.com/winglang/wing',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'libs/tree-sitter-wing',
      requires_generate_from_grammar = true,
    },
    maintainers = { '@gshpychka', '@MarkMcCulloh' },
    tier = 4,
  },

  wgsl = {
    install_info = {
      url = 'https://github.com/szebniok/tree-sitter-wgsl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@szebniok' },
    tier = 3,
  },

  wgsl_bevy = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-wgsl-bevy',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    tier = 2,
  },

  xcompose = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-xcompose',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
    tier = 2,
  },

  xml = {
    install_info = {
      url = 'https://github.com/tree-sitter-grammars/tree-sitter-xml',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'xml',
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'dtd' },
    tier = 2,
  },

  yaml = {
    install_info = {
      url = 'https://github.com/ikatyang/tree-sitter-yaml',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@stsewd' },
    tier = 4,
  },

  yang = {
    install_info = {
      url = 'https://github.com/Hubro/tree-sitter-yang',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Hubro' },
    tier = 3,
  },

  yuck = {
    install_info = {
      url = 'https://github.com/Philipp-M/tree-sitter-yuck',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Philipp-M', '@amaanq' },
    tier = 3,
  },

  zathurarc = {
    install_info = {
      url = 'https://github.com/Freed-Wu/tree-sitter-zathurarc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Freed-Wu' },
    tier = 3,
  },

  zig = {
    install_info = {
      url = 'https://github.com/maxxnino/tree-sitter-zig',
      files = { 'src/parser.c' },
    },
    maintainers = { '@maxxnino' },
    tier = 3,
  },
}

-- Get a list of all available parsers
---@param tier integer? only get parsers of specified tier
---@return string[]
function M.get_available(tier)
  --- @type string[]
  local parsers = vim.tbl_keys(M.configs)
  table.sort(parsers)
  if tier then
    parsers = vim.iter.filter(function(p)
      return M.configs[p].tier == tier
    end, parsers) --[[@as string[] ]]
  end
  if vim.fn.executable('tree-sitter') == 0 or vim.fn.executable('node') == 0 then
    parsers = vim.iter.filter(function(p)
      return not M.configs[p].install_info.requires_generate_from_grammar
    end, parsers) --[[@as string[] ]]
  end
  return parsers
end

return M
