---@class InstallInfo
---@field url string
---@field branch string|nil
---@field revision string|nil
---@field files string[]
---@field generate_requires_npm boolean|nil
---@field requires_generate_from_grammar boolean|nil
---@field location string|nil
---@field use_makefile boolean|nil

---@class ParserInfo
---@field install_info InstallInfo
---@field filetype string[]
---@field maintainers string[]
---@field requires string[]
---@field tier integer|nil
---@field readme_note string|nil

local M = {}

M.tiers = { 'core', 'stable', 'community', 'unstable' }

---@type ParserInfo[]
M.configs = {
  ada = {
    install_info = {
      url = 'https://github.com/briot/tree-sitter-ada',
      files = { 'src/parser.c' },
    },
    maintainers = { '@briot' },
  },

  agda = {
    install_info = {
      url = 'https://github.com/AusCyberman/tree-sitter-agda',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@Decodetalkers' },
  },

  arduino = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-arduino',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@ObserverOfTime' },
    requires = { 'cpp' },
  },

  astro = {
    install_info = {
      url = 'https://github.com/virchau13/tree-sitter-astro',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@virchau13' },
    requires = { 'html', 'html_tags' },
  },

  awk = {
    install_info = {
      url = 'https://github.com/Beaglefoot/tree-sitter-awk',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
  },

  bash = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-bash',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@TravonteD' },
  },

  bass = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-bass',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  beancount = {
    install_info = {
      url = 'https://github.com/polarmutex/tree-sitter-beancount',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@polarmutex' },
  },

  bibtex = {
    install_info = {
      url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },

  bicep = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-bicep',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
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
  },

  capnp = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-capnp',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  chatito = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-chatito',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
  },

  clojure = {
    install_info = {
      url = 'https://github.com/sogaiu/tree-sitter-clojure',
      files = { 'src/parser.c' },
    },
    maintainers = { '@sogaiu' },
  },

  cmake = {
    install_info = {
      url = 'https://github.com/uyha/tree-sitter-cmake',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@uyha' },
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
  },

  cooklang = {
    install_info = {
      url = 'https://github.com/addcninblue/tree-sitter-cooklang',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@addcninblue' },
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
  },

  cpp = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-cpp',
      files = { 'src/parser.c', 'src/scanner.cc' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
  },

  css = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-css',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@TravonteD' },
  },

  cuda = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-cuda',
      files = { 'src/parser.c', 'src/scanner.cc' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
  },

  cue = {
    install_info = {
      url = 'https://github.com/eonpatapon/tree-sitter-cue',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  d = {
    install_info = {
      url = 'https://github.com/CyberShadow/tree-sitter-d',
      files = { 'src/parser.c', 'src/scanner.cc' },
      requires_generate_from_grammar = true,
    },
    tier = 4,
    maintainers = { '@nawordar' },
  },

  dart = {
    install_info = {
      url = 'https://github.com/UserNobody14/tree-sitter-dart',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@akinsho' },
  },

  devicetree = {
    install_info = {
      url = 'https://github.com/joelspadin/tree-sitter-devicetree',
      files = { 'src/parser.c' },
    },
    maintainers = { '@jedrzejboczar' },
  },

  dhall = {
    install_info = {
      url = 'https://github.com/jbellerb/tree-sitter-dhall',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  diff = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-diff',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
  },

  dockerfile = {
    install_info = {
      url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
      files = { 'src/parser.c' },
    },
    maintainers = { '@camdencheek' },
  },

  dot = {
    install_info = {
      url = 'https://github.com/rydesun/tree-sitter-dot',
      files = { 'src/parser.c' },
    },
    maintainers = { '@rydesun' },
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
  },

  eex = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-eex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
  },

  elixir = {
    install_info = {
      url = 'https://github.com/elixir-lang/tree-sitter-elixir',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@connorlay' },
  },

  elm = {
    install_info = {
      url = 'https://github.com/elm-tooling/tree-sitter-elm',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@zweimach' },
  },

  elsa = {
    install_info = {
      url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
      files = { 'src/parser.c' },
    },
    maintainers = { '@glapa-grossklag', '@amaanq' },
  },

  elvish = {
    install_info = {
      url = 'https://github.com/ckafi/tree-sitter-elvish',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ckafi' },
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
  },

  fennel = {
    install_info = {
      url = 'https://github.com/travonted/tree-sitter-fennel',
      files = { 'src/parser.c' },
    },
    maintainers = { '@TravonteD' },
  },

  firrtl = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-firrtl',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@amaanq' },
  },

  fish = {
    install_info = {
      url = 'https://github.com/ram02z/tree-sitter-fish',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ram02z' },
  },

  foam = {
    install_info = {
      url = 'https://github.com/FoamScience/tree-sitter-foam',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@FoamScience' },
    tier = 4,
  },

  fortran = {
    install_info = {
      url = 'https://github.com/stadelmanma/tree-sitter-fortran',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@amaanq' },
  },

  fsh = {
    install_info = {
      url = 'https://github.com/mgramigna/tree-sitter-fsh',
      files = { 'src/parser.c' },
    },
    maintainers = { '@mgramigna' },
  },

  func = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-func',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  fusion = {
    install_info = {
      url = 'https://gitlab.com/jirgn/tree-sitter-fusion.git',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@jirgn' },
  },

  gdscript = {
    install_info = {
      url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@PrestonKnopp' },
    readme_note = 'Godot',
  },

  git_rebase = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
  },

  gitattributes = {
    install_info = {
      url = 'https://github.com/ObserverOfTime/tree-sitter-gitattributes',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
  },

  gitcommit = {
    install_info = {
      url = 'https://github.com/gbprod/tree-sitter-gitcommit',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@gbprod' },
  },

  git_config = {
    install_info = {
      url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    readme_note = 'git_config',
  },

  gitignore = {
    install_info = {
      url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
  },

  gleam = {
    install_info = {
      url = 'https://github.com/gleam-lang/tree-sitter-gleam',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  glimmer = {
    install_info = {
      url = 'https://github.com/alexlafroscia/tree-sitter-glimmer',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@NullVoxPopuli' },
    readme_note = 'Glimmer and Ember',
  },

  glsl = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-glsl',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'c' },
  },

  go = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-go',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta', '@WinWisely268' },
  },

  godot_resource = {
    install_info = {
      url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@pierpo' },
    readme_note = 'Godot Resources',
  },

  gomod = {
    install_info = {
      url = 'https://github.com/camdencheek/tree-sitter-go-mod',
      files = { 'src/parser.c' },
    },
    maintainers = { '@camdencheek' },
  },

  gosum = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-go-sum',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  gowork = {
    install_info = {
      url = 'https://github.com/omertuc/tree-sitter-go-work',
      files = { 'src/parser.c' },
    },
    maintainers = { '@omertuc' },
  },

  graphql = {
    install_info = {
      url = 'https://github.com/bkegley/tree-sitter-graphql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@bkegley' },
  },

  hack = {
    install_info = {
      url = 'https://github.com/slackhq/tree-sitter-hack',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    tier = 4,
  },

  hare = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-hare',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  haskell = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-haskell',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    tier = 4,
  },

  hcl = {
    install_info = {
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@MichaHoffmann' },
  },

  heex = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-heex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
  },

  hjson = {
    install_info = {
      url = 'https://github.com/winston0410/tree-sitter-hjson',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@winston0410' },
    requires = { 'json' },
  },

  hlsl = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-hlsl',
      files = { 'src/parser.c', 'src/scanner.cc' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
    requires = { 'cpp' },
  },

  hocon = {
    install_info = {
      url = 'https://github.com/antosha417/tree-sitter-hocon',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@antosha417' },
  },

  html_tags = {
    maintainers = { '@TravonteD' },
    readme_note = 'queries required by html, astro, vue, svelte',
  },

  html = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-html',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@TravonteD' },
    requires = { 'html_tags' },
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
  },

  janet_simple = {
    install_info = {
      url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@sogaiu' },
  },

  java = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-java',
      files = { 'src/parser.c' },
    },
    maintainers = { '@p00f' },
  },

  javascript = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-javascript',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@steelsojka' },
    requires = { 'ecma', 'jsx' },
  },

  jq = {
    install_info = {
      url = 'https://github.com/flurie/tree-sitter-jq',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ObserverOfTime' },
  },

  jsdoc = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@steelsojka' },
  },

  json = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-json',
      files = { 'src/parser.c' },
    },
    maintainers = { '@steelsojka' },
  },

  json5 = {
    install_info = {
      url = 'https://github.com/Joakker/tree-sitter-json5',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Joakker' },
  },

  jsonc = {
    install_info = {
      url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git',
      files = { 'src/parser.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@WhyNotHugo' },
    requires = { 'json' },
  },

  jsonnet = {
    install_info = {
      url = 'https://github.com/sourcegraph/tree-sitter-jsonnet',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@nawordar' },
  },

  jsx = {
    maintainers = { '@steelsojka' },
    readme_note = 'queries required by javascript, tsx',
  },

  julia = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-julia',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@theHamsta' },
    tier = 3,
  },

  kdl = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-kdl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  kotlin = {
    install_info = {
      url = 'https://github.com/fwcd/tree-sitter-kotlin',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@SalBakraa' },
  },

  lalrpop = {
    install_info = {
      url = 'https://github.com/traxys/tree-sitter-lalrpop',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@traxys' },
  },

  latex = {
    install_info = {
      url = 'https://github.com/latex-lsp/tree-sitter-latex',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@theHamsta', '@clason' },
    tier = 3,
  },

  ledger = {
    install_info = {
      url = 'https://github.com/cbarrete/tree-sitter-ledger',
      files = { 'src/parser.c' },
    },
    maintainers = { '@cbarrete' },
  },

  llvm = {
    install_info = {
      url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
      files = { 'src/parser.c' },
    },
    maintainers = { '@benwilliamgraham' },
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
  },

  luap = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-luap',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    readme_note = 'Lua patterns',
  },

  luau = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-luau',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    requires = { 'lua' },
  },

  m68k = {
    install_info = {
      url = 'https://github.com/grahambates/tree-sitter-m68k',
      files = { 'src/parser.c' },
    },
    maintainers = { '@grahambates' },
  },

  make = {
    install_info = {
      url = 'https://github.com/alemuller/tree-sitter-make',
      files = { 'src/parser.c' },
    },
    maintainers = { '@lewis6991' },
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
      url = 'https://github.com/mstanciu552/tree-sitter-matlab',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  menhir = {
    install_info = {
      url = 'https://github.com/Kerl13/tree-sitter-menhir',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@Kerl13' },
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

  nickel = {
    install_info = {
      url = 'https://github.com/nickel-lang/tree-sitter-nickel',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    tier = 4,
  },

  ninja = {
    install_info = {
      url = 'https://github.com/alemuller/tree-sitter-ninja',
      files = { 'src/parser.c' },
    },
    maintainers = { '@alemuller' },
  },

  nix = {
    install_info = {
      url = 'https://github.com/cstrahan/tree-sitter-nix',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@leo60228' },
  },

  norg = {
    install_info = {
      url = 'https://github.com/nvim-neorg/tree-sitter-norg',
      files = { 'src/parser.c', 'src/scanner.cc' },
      use_makefile = true,
    },
    maintainers = { '@JoeyGrajciar', '@vhyrro' },
    tier = 4,
  },

  objc = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-objc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
    requires = { 'c' },
  },

  ocaml = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
      files = { 'src/parser.c', 'src/scanner.cc' },
      location = 'ocaml',
    },
    maintainers = { '@undu' },
  },

  ocaml_interface = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
      files = { 'src/parser.c', 'src/scanner.cc' },
      location = 'interface',
    },
    maintainers = { '@undu' },
    requires = { 'ocaml' },
  },

  ocamllex = {
    install_info = {
      url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
      files = { 'src/parser.c', 'src/scanner.cc' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@undu' },
  },

  odin = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-odin',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  org = {
    install_info = {
      url = 'https://github.com/milisims/tree-sitter-org',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    tier = 4,
  },

  pascal = {
    install_info = {
      url = 'https://github.com/Isopod/tree-sitter-pascal.git',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Isopod' },
  },

  passwd = {
    install_info = {
      url = 'https://github.com/ath3/tree-sitter-passwd',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  perl = {
    install_info = {
      url = 'https://github.com/ganezdragon/tree-sitter-perl',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@lcrownover' },
  },

  php = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-php',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@tk-shirasaka' },
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
  },

  po = {
    install_info = {
      url = 'https://github.com/erasin/tree-sitter-po',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
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
  },

  prisma = {
    install_info = {
      url = 'https://github.com/victorhqc/tree-sitter-prisma',
      files = { 'src/parser.c' },
    },
    maintainers = { '@elianiva' },
  },

  proto = {
    install_info = {
      url = 'https://github.com/mitchellh/tree-sitter-proto',
      files = { 'src/parser.c' },
    },
    maintainers = { '@fsouza' },
  },

  prql = {
    install_info = {
      url = 'https://github.com/PRQL/tree-sitter-prql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@matthias-Q' },
  },

  pug = {
    install_info = {
      url = 'https://github.com/zealot128/tree-sitter-pug',
      files = { 'src/parser.c', 'src/scanner.cc' },
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
  },

  python = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-python',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@stsewd', '@theHamsta' },
  },

  ql = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@pwntester' },
  },

  qmldir = {
    install_info = {
      url = 'https://github.com/Decodetalkers/tree-sitter-qmldir',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  qmljs = {
    install_info = {
      url = 'https://github.com/yuja/tree-sitter-qmljs',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Decodetalkers' },
    requires = { 'ecma' },
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
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@echasnovski' },
  },

  racket = {
    install_info = {
      url = 'https://github.com/6cdh/tree-sitter-racket',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@6cdh' },
  },

  rasi = {
    install_info = {
      url = 'https://github.com/Fymyte/tree-sitter-rasi',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Fymyte' },
  },

  regex = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-regex',
      files = { 'src/parser.c' },
    },
    maintainers = { '@theHamsta' },
  },

  rego = {
    install_info = {
      url = 'https://github.com/FallenAngel97/tree-sitter-rego',
      files = { 'src/parser.c' },
    },
    maintainers = { '@FallenAngel97' },
  },

  rnoweb = {
    install_info = {
      url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@bamonroe' },
  },

  ron = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-ron',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  rst = {
    install_info = {
      url = 'https://github.com/stsewd/tree-sitter-rst',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stsewd' },
  },

  ruby = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-ruby',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@TravonteD' },
  },

  rust = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-rust',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  scala = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-scala',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@stevanmilic' },
  },

  scheme = {
    install_info = {
      url = 'https://github.com/6cdh/tree-sitter-scheme',
      files = { 'src/parser.c' },
    },
    maintainers = { '@6cdh' },
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

  slint = {
    install_info = {
      url = 'https://github.com/jrmoulton/tree-sitter-slint',
      files = { 'src/parser.c' },
    },
    maintainers = { '@jrmoulton' },
    tier = 4,
  },

  smali = {
    install_info = {
      url = 'https://git.sr.ht/~yotam/tree-sitter-smali',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  smithy = {
    install_info = {
      url = 'https://github.com/indoorvivants/tree-sitter-smithy',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq', '@keynmol' },
  },

  solidity = {
    install_info = {
      url = 'https://github.com/JoranHonig/tree-sitter-solidity',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq' },
  },

  sparql = {
    install_info = {
      url = 'https://github.com/BonaBeavis/tree-sitter-sparql',
      files = { 'src/parser.c' },
    },
    maintainers = { '@BonaBeavis' },
  },

  sql = {
    install_info = {
      url = 'https://github.com/derekstride/tree-sitter-sql',
      files = { 'src/parser.c' },
      branch = 'gh-pages',
    },
    maintainers = { '@derekstride' },
  },

  squirrel = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-squirrel',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  starlark = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-starlark',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@amaanq' },
  },

  supercollider = {
    install_info = {
      url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@madskjeldgaard' },
  },

  surface = {
    install_info = {
      url = 'https://github.com/connorlay/tree-sitter-surface',
      files = { 'src/parser.c' },
    },
    maintainers = { '@connorlay' },
  },

  svelte = {
    install_info = {
      url = 'https://github.com/Himujjal/tree-sitter-svelte',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@elianiva' },
    requires = { 'html_tags' },
  },

  swift = {
    install_info = {
      url = 'https://github.com/alex-pinkus/tree-sitter-swift',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@alex-pinkus' },
  },

  sxhkdrc = {
    install_info = {
      url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
      files = { 'src/parser.c' },
    },
    maintainers = { '@RaafatTurki' },
  },

  t32 = {
    install_info = {
      url = 'https://codeberg.org/xasc/tree-sitter-t32',
      files = { 'src/parser.c', 'src/scanner.c' },
      revision = '1dd98248b01e4a3933c1b85b58bab0875e2ba437',
    },
    maintainers = { '@xasc' },
  },

  tablegen = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-tablegen',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
  },

  teal = {
    install_info = {
      url = 'https://github.com/euclidianAce/tree-sitter-teal',
      files = { 'src/parser.c', 'src/scanner.c' },
      requires_generate_from_grammar = true,
    },
    maintainers = { '@euclidianAce' },
  },

  terraform = {
    install_info = {
      url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
      files = { 'src/parser.c', 'src/scanner.cc' },
      location = 'dialects/terraform',
    },
    maintainers = { '@MichaHoffmann' },
    requires = { 'hcl' },
    tier = 3,
  },

  thrift = {
    install_info = {
      url = 'https://github.com/duskmoon314/tree-sitter-thrift',
      files = { 'src/parser.c' },
    },
    maintainers = { '@amaanq', '@duskmoon314' },
  },

  tiger = {
    install_info = {
      url = 'https://github.com/ambroisie/tree-sitter-tiger',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@ambroisie' },
  },

  tlaplus = {
    install_info = {
      url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@ahelwer', '@susliko' },
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
  },

  turtle = {
    install_info = {
      url = 'https://github.com/BonaBeavis/tree-sitter-turtle',
      files = { 'src/parser.c' },
    },
    maintainers = { '@BonaBeavis' },
  },

  twig = {
    install_info = {
      url = 'https://github.com/gbprod/tree-sitter-twig',
      files = { 'src/parser.c' },
    },
    maintainers = { '@gbprod' },
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
  },

  ungrammar = {
    install_info = {
      url = 'https://github.com/Philipp-M/tree-sitter-ungrammar',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Philipp-M', '@amaanq' },
  },

  usd = {
    install_info = {
      url = 'https://github.com/ColinKennedy/tree-sitter-usd',
      files = { 'src/parser.c' },
    },
    maintainers = { '@ColinKennedy' },
  },

  uxntal = {
    install_info = {
      url = 'https://github.com/amaanq/tree-sitter-uxntal',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@amaanq' },
    readme_note = 'uxn tal',
  },

  v = {
    install_info = {
      url = 'https://github.com/vlang/vls',
      files = { 'src/parser.c', 'src/scanner.c' },
      location = 'tree_sitter_v',
    },
    maintainers = { '@kkharji' },
  },

  vala = {
    install_info = {
      url = 'https://github.com/vala-lang/tree-sitter-vala',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Prince781' },
  },

  verilog = {
    install_info = {
      url = 'https://github.com/tree-sitter/tree-sitter-verilog',
      files = { 'src/parser.c' },
    },
    maintainers = { '@zegervdv' },
  },

  vhs = {
    install_info = {
      url = 'https://github.com/charmbracelet/tree-sitter-vhs',
      files = { 'src/parser.c' },
    },
    maintainers = { '@caarlos0' },
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
      url = 'https://github.com/ikatyang/tree-sitter-vue',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@WhyNotHugo' },
    requires = { 'html_tags' },
  },

  wgsl = {
    install_info = {
      url = 'https://github.com/szebniok/tree-sitter-wgsl',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@szebniok' },
  },

  wgsl_bevy = {
    install_info = {
      url = 'https://github.com/theHamsta/tree-sitter-wgsl-bevy',
      files = { 'src/parser.c', 'src/scanner.c' },
      generate_requires_npm = true,
    },
    maintainers = { '@theHamsta' },
  },

  yaml = {
    install_info = {
      url = 'https://github.com/ikatyang/tree-sitter-yaml',
      files = { 'src/parser.c', 'src/scanner.cc' },
    },
    maintainers = { '@stsewd' },
  },

  yang = {
    install_info = {
      url = 'https://github.com/Hubro/tree-sitter-yang',
      files = { 'src/parser.c' },
    },
    maintainers = { '@Hubro' },
  },

  yuck = {
    install_info = {
      url = 'https://github.com/Philipp-M/tree-sitter-yuck',
      files = { 'src/parser.c', 'src/scanner.c' },
    },
    maintainers = { '@Philipp-M', '@amaanq' },
  },

  zig = {
    install_info = {
      url = 'https://github.com/maxxnino/tree-sitter-zig',
      files = { 'src/parser.c' },
    },
    maintainers = { '@maxxnino' },
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
