---@class InstallInfo
---@field url string
---@field branch string|nil
---@field revision string|nil
---@field files string[]
---@field generate_requires_npm boolean|nil
---@field requires_generate_from_grammar boolean|nil
---@field location string|nil
---@field use_makefile boolean|nil
---@field cxx_standard string|nil

---@class ParserInfo
---@field install_info InstallInfo
---@field filetype string[]
---@field maintainers string[]
---@field tier integer|nil
---@field readme_note string|nil

local M = {}

M.tiers = { 'core', 'stable', 'community', 'unstable' }

---@type ParserInfo[]
M.configs = setmetatable({}, {
  __newindex = function(table, parsername, parserconfig)
    rawset(table, parsername, parserconfig)
    if parserconfig.filetype then
      for _, ft in pairs(parserconfig.filetype) do
        vim.treesitter.language.register(parsername, ft)
      end
    end
  end,
})

M.configs.ada = {
  install_info = {
    url = 'https://github.com/briot/tree-sitter-ada',
    files = { 'src/parser.c' },
  },
  maintainers = { '@briot' },
}

M.configs.agda = {
  install_info = {
    url = 'https://github.com/AusCyberman/tree-sitter-agda',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@Decodetalkers' },
}

M.configs.arduino = {
  install_info = {
    url = 'https://github.com/ObserverOfTime/tree-sitter-arduino',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@ObserverOfTime' },
}

M.configs.astro = {
  install_info = {
    url = 'https://github.com/virchau13/tree-sitter-astro',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@virchau13' },
}

M.configs.awk = {
  install_info = {
    url = 'https://github.com/Beaglefoot/tree-sitter-awk',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
}

M.configs.bash = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-bash',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = { 'sh', 'PKGBUILD' },
  maintainers = { '@TravonteD' },
}

M.configs.bass = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-bass',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.beancount = {
  install_info = {
    url = 'https://github.com/polarmutex/tree-sitter-beancount',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@polarmutex' },
}

M.configs.bibtex = {
  install_info = {
    url = 'https://github.com/latex-lsp/tree-sitter-bibtex',
    files = { 'src/parser.c' },
  },
  filetype = { 'bib' },
  maintainers = { '@theHamsta', '@clason' },
}

M.configs.bicep = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-bicep',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.blueprint = {
  install_info = {
    url = 'https://gitlab.com/gabmus/tree-sitter-blueprint.git',
    files = { 'src/parser.c' },
  },
  maintainers = { '@gabmus' },
  tier = 4,
}

M.configs.c = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-c',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.c_sharp = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'cs' },
  maintainers = { '@Luxed' },
}

M.configs.capnp = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-capnp',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.chatito = {
  install_info = {
    url = 'https://github.com/ObserverOfTime/tree-sitter-chatito',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ObserverOfTime' },
}

M.configs.clojure = {
  install_info = {
    url = 'https://github.com/sogaiu/tree-sitter-clojure',
    files = { 'src/parser.c' },
  },
  maintainers = { '@sogaiu' },
}

M.configs.cmake = {
  install_info = {
    url = 'https://github.com/uyha/tree-sitter-cmake',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@uyha' },
}

M.configs.comment = {
  install_info = {
    url = 'https://github.com/stsewd/tree-sitter-comment',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@stsewd' },
}

M.configs.commonlisp = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-commonlisp',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  filetype = { 'lisp' },
  maintainers = { '@theHamsta' },
}

M.configs.cooklang = {
  install_info = {
    url = 'https://github.com/addcninblue/tree-sitter-cooklang',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@addcninblue' },
}

M.configs.cpon = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-cpon',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.cpp = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-cpp',
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
  },
  maintainers = { '@theHamsta' },
}

M.configs.css = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-css',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@TravonteD' },
}

M.configs.cuda = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-cuda',
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
  },
  maintainers = { '@theHamsta' },
}

M.configs.cue = {
  install_info = {
    url = 'https://github.com/eonpatapon/tree-sitter-cue',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.d = {
  install_info = {
    url = 'https://github.com/CyberShadow/tree-sitter-d',
    files = { 'src/parser.c', 'src/scanner.cc' },
    requires_generate_from_grammar = true,
  },
  -- Generating grammar takes ~60s
  tier = 4,
  maintainers = { '@nawordar' },
}

M.configs.dart = {
  install_info = {
    url = 'https://github.com/UserNobody14/tree-sitter-dart',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@akinsho' },
}

M.configs.devicetree = {
  install_info = {
    url = 'https://github.com/joelspadin/tree-sitter-devicetree',
    files = { 'src/parser.c' },
  },
  filetype = { 'dts' },
  maintainers = { '@jedrzejboczar' },
}

M.configs.dhall = {
  install_info = {
    url = 'https://github.com/jbellerb/tree-sitter-dhall',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.diff = {
  install_info = {
    url = 'https://github.com/the-mikedavis/tree-sitter-diff',
    files = { 'src/parser.c' },
  },
  filetype = { 'gitdiff' },
  maintainers = { '@gbprod' },
}

M.configs.dockerfile = {
  install_info = {
    url = 'https://github.com/camdencheek/tree-sitter-dockerfile',
    files = { 'src/parser.c' },
  },
  maintainers = { '@camdencheek' },
}

M.configs.dot = {
  install_info = {
    url = 'https://github.com/rydesun/tree-sitter-dot',
    files = { 'src/parser.c' },
  },
  maintainers = { '@rydesun' },
}

M.configs.ebnf = {
  install_info = {
    url = 'https://github.com/RubixDev/ebnf',
    files = { 'src/parser.c' },
    location = 'crates/tree-sitter-ebnf',
  },
  maintainers = { '@RubixDev' },
  tier = 4,
}

M.configs.eex = {
  install_info = {
    url = 'https://github.com/connorlay/tree-sitter-eex',
    files = { 'src/parser.c' },
  },
  filetype = { 'eelixir' },
  maintainers = { '@connorlay' },
}

M.configs.elixir = {
  install_info = {
    url = 'https://github.com/elixir-lang/tree-sitter-elixir',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@connorlay' },
}

M.configs.elm = {
  install_info = {
    url = 'https://github.com/elm-tooling/tree-sitter-elm',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@zweimach' },
}

M.configs.elsa = {
  install_info = {
    url = 'https://github.com/glapa-grossklag/tree-sitter-elsa',
    files = { 'src/parser.c' },
  },
  maintainers = { '@glapa-grossklag', '@amaanq' },
}

M.configs.elvish = {
  install_info = {
    url = 'https://github.com/ckafi/tree-sitter-elvish',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ckafi' },
}

M.configs.embedded_template = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
    files = { 'src/parser.c' },
  },
  filetype = { 'eruby' },
}

M.configs.erlang = {
  install_info = {
    url = 'https://github.com/WhatsApp/tree-sitter-erlang',
    files = { 'src/parser.c' },
  },
  maintainers = { '@filmor' },
}

M.configs.fennel = {
  install_info = {
    url = 'https://github.com/travonted/tree-sitter-fennel',
    files = { 'src/parser.c' },
  },
  maintainers = { '@TravonteD' },
}

M.configs.firrtl = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-firrtl',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@amaanq' },
}

M.configs.fish = {
  install_info = {
    url = 'https://github.com/ram02z/tree-sitter-fish',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@ram02z' },
}

M.configs.foam = {
  install_info = {
    url = 'https://github.com/FoamScience/tree-sitter-foam',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@FoamScience' },
  -- Queries might change over time on the grammar's side
  -- Otherwise everything runs fine
  tier = 4,
}

M.configs.fortran = {
  install_info = {
    url = 'https://github.com/stadelmanma/tree-sitter-fortran',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@amaanq' },
}

M.configs.fsh = {
  install_info = {
    url = 'https://github.com/mgramigna/tree-sitter-fsh',
    files = { 'src/parser.c' },
  },
  maintainers = { '@mgramigna' },
}

M.configs.func = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-func',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.fusion = {
  install_info = {
    url = 'https://gitlab.com/jirgn/tree-sitter-fusion.git',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@jirgn' },
}

M.configs.gdscript = {
  install_info = {
    url = 'https://github.com/PrestonKnopp/tree-sitter-gdscript',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@PrestonKnopp' },
  readme_note = 'Godot',
}

M.configs.git_rebase = {
  install_info = {
    url = 'https://github.com/the-mikedavis/tree-sitter-git-rebase',
    files = { 'src/parser.c' },
  },
  filetype = { 'gitrebase' },
  maintainers = { '@gbprod' },
}

M.configs.gitattributes = {
  install_info = {
    url = 'https://github.com/ObserverOfTime/tree-sitter-gitattributes',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ObserverOfTime' },
}

M.configs.gitcommit = {
  install_info = {
    url = 'https://github.com/gbprod/tree-sitter-gitcommit',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@gbprod' },
}

M.configs.git_config = {
  install_info = {
    url = 'https://github.com/the-mikedavis/tree-sitter-git-config',
    files = { 'src/parser.c' },
  },
  filetype = { 'gitconfig' },
  maintainers = { '@amaanq' },
  readme_note = 'git_config',
}

M.configs.gitignore = {
  install_info = {
    url = 'https://github.com/shunsambongi/tree-sitter-gitignore',
    files = { 'src/parser.c' },
  },
  maintainers = { '@theHamsta' },
}

M.configs.gleam = {
  install_info = {
    url = 'https://github.com/gleam-lang/tree-sitter-gleam',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.glimmer = {
  install_info = {
    url = 'https://github.com/alexlafroscia/tree-sitter-glimmer',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'handlebars', 'html.handlebars' },
  maintainers = { '@NullVoxPopuli' },
  readme_note = 'Glimmer and Ember',
}

M.configs.glsl = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-glsl',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@theHamsta' },
}

M.configs.go = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-go',
    files = { 'src/parser.c' },
  },
  maintainers = { '@theHamsta', '@WinWisely268' },
}

M.configs.godot_resource = {
  install_info = {
    url = 'https://github.com/PrestonKnopp/tree-sitter-godot-resource',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'gdresource' },
  maintainers = { '@pierpo' },
  readme_note = 'Godot Resources',
}

M.configs.gomod = {
  install_info = {
    url = 'https://github.com/camdencheek/tree-sitter-go-mod',
    files = { 'src/parser.c' },
  },
  maintainers = { '@camdencheek' },
}

M.configs.gosum = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-go-sum',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.gowork = {
  install_info = {
    url = 'https://github.com/omertuc/tree-sitter-go-work',
    files = { 'src/parser.c' },
  },
  maintainers = { '@omertuc' },
}

M.configs.graphql = {
  install_info = {
    url = 'https://github.com/bkegley/tree-sitter-graphql',
    files = { 'src/parser.c' },
  },
  maintainers = { '@bkegley' },
}

M.configs.hack = {
  install_info = {
    url = 'https://github.com/slackhq/tree-sitter-hack',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
}

M.configs.hare = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-hare',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.haskell = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-haskell',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
}

M.configs.hcl = {
  install_info = {
    url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@MichaHoffmann' },
}

M.configs.heex = {
  install_info = {
    url = 'https://github.com/connorlay/tree-sitter-heex',
    files = { 'src/parser.c' },
  },
  maintainers = { '@connorlay' },
}

M.configs.hjson = {
  install_info = {
    url = 'https://github.com/winston0410/tree-sitter-hjson',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@winston0410' },
}

M.configs.hlsl = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-hlsl',
    files = { 'src/parser.c', 'src/scanner.cc' },
    generate_requires_npm = true,
  },
  maintainers = { '@theHamsta' },
}

M.configs.hocon = {
  install_info = {
    url = 'https://github.com/antosha417/tree-sitter-hocon',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@antosha417' },
}

M.configs.html = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-html',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = { 'html_tags' },
  maintainers = { '@TravonteD' },
}

M.configs.htmldjango = {
  install_info = {
    url = 'https://github.com/interdependence/tree-sitter-htmldjango',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ObserverOfTime' },
  tier = 4,
}

M.configs.http = {
  install_info = {
    url = 'https://github.com/rest-nvim/tree-sitter-http',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@amaanq' },
}

M.configs.ini = {
  install_info = {
    url = 'https://github.com/justinmk/tree-sitter-ini',
    files = { 'src/parser.c' },
  },
  filetypes = { 'dosini', 'confini' },
  maintainers = { '@theHamsta' },
  tier = 4,
}

M.configs.janet_simple = {
  install_info = {
    url = 'https://github.com/sogaiu/tree-sitter-janet-simple',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'janet' },
  maintainers = { '@sogaiu' },
}

M.configs.java = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-java',
    files = { 'src/parser.c' },
  },
  maintainers = { '@p00f' },
}

M.configs.javascript = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-javascript',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { ' javascriptreact', 'ecma', 'jsx' },
  maintainers = { '@steelsojka' },
}

M.configs.jq = {
  install_info = {
    url = 'https://github.com/flurie/tree-sitter-jq',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ObserverOfTime' },
}

M.configs.jsdoc = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-jsdoc',
    files = { 'src/parser.c' },
  },
  maintainers = { '@steelsojka' },
}

M.configs.json = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-json',
    files = { 'src/parser.c' },
  },
  maintainers = { '@steelsojka' },
}

M.configs.json5 = {
  install_info = {
    url = 'https://github.com/Joakker/tree-sitter-json5',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Joakker' },
}

M.configs.jsonc = {
  install_info = {
    url = 'https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git',
    files = { 'src/parser.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@WhyNotHugo' },
  readme_note = 'JSON with comments',
}

M.configs.jsonnet = {
  install_info = {
    url = 'https://github.com/sourcegraph/tree-sitter-jsonnet',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@nawordar' },
}

M.configs.julia = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-julia',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@theHamsta' },
}

M.configs.kdl = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-kdl',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.kotlin = {
  install_info = {
    url = 'https://github.com/fwcd/tree-sitter-kotlin',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@SalBakraa' },
}

M.configs.lalrpop = {
  install_info = {
    url = 'https://github.com/traxys/tree-sitter-lalrpop',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@traxys' },
}

M.configs.latex = {
  install_info = {
    url = 'https://github.com/latex-lsp/tree-sitter-latex',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'tex', 'cls', 'sty' },
  maintainers = { '@theHamsta', '@clason' },
}

M.configs.ledger = {
  install_info = {
    url = 'https://github.com/cbarrete/tree-sitter-ledger',
    files = { 'src/parser.c' },
  },
  maintainers = { '@cbarrete' },
}

M.configs.llvm = {
  install_info = {
    url = 'https://github.com/benwilliamgraham/tree-sitter-llvm',
    files = { 'src/parser.c' },
  },
  maintainers = { '@benwilliamgraham' },
}

M.configs.lua = {
  install_info = {
    url = 'https://github.com/MunifTanjim/tree-sitter-lua',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  tier = 1,
  maintainers = { '@muniftanjim' },
}

M.configs.luadoc = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-luadoc',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.luap = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-luap',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
  readme_note = 'Lua patterns',
}

M.configs.luau = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-luau',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.m68k = {
  install_info = {
    url = 'https://github.com/grahambates/tree-sitter-m68k',
    files = { 'src/parser.c' },
  },
  filetype = { 'asm68k' },
  maintainers = { '@grahambates' },
}

M.configs.make = {
  install_info = {
    url = 'https://github.com/alemuller/tree-sitter-make',
    files = { 'src/parser.c' },
  },
  maintainers = { '@lewis6991' },
}

M.configs.markdown = {
  install_info = {
    url = 'https://github.com/MDeiml/tree-sitter-markdown',
    location = 'tree-sitter-markdown',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'pandoc', 'quarto', 'rmd' },
  maintainers = { '@MDeiml' },
  readme_note = 'basic highlighting',
}

M.configs.markdown_inline = {
  install_info = {
    url = 'https://github.com/MDeiml/tree-sitter-markdown',
    location = 'tree-sitter-markdown-inline',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@MDeiml' },
  readme_note = 'needed for full highlighting',
}

M.configs.matlab = {
  install_info = {
    url = 'https://github.com/mstanciu552/tree-sitter-matlab',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.menhir = {
  install_info = {
    url = 'https://github.com/Kerl13/tree-sitter-menhir',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@Kerl13' },
}

M.configs.mermaid = {
  install_info = {
    url = 'https://github.com/monaqa/tree-sitter-mermaid',
    files = { 'src/parser.c' },
  },
  tier = 4,
}

M.configs.meson = {
  install_info = {
    url = 'https://github.com/Decodetalkers/tree-sitter-meson',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Decodetalkers' },
}

M.configs.mlir = {
  install_info = {
    url = 'https://github.com/artagnon/tree-sitter-mlir',
    files = { 'src/parser.c' },
    requires_generate_from_grammar = true,
  },
  tier = 4,
  maintainers = { '@artagnon' },
}

M.configs.nickel = {
  install_info = {
    url = 'https://github.com/nickel-lang/tree-sitter-nickel',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
}

M.configs.ninja = {
  install_info = {
    url = 'https://github.com/alemuller/tree-sitter-ninja',
    files = { 'src/parser.c' },
  },
  maintainers = { '@alemuller' },
}

M.configs.nix = {
  install_info = {
    url = 'https://github.com/cstrahan/tree-sitter-nix',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@leo60228' },
}

M.configs.norg = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg',
    files = { 'src/parser.c', 'src/scanner.cc' },
    cxx_standard = 'c++14',
    use_makefile = true,
  },
  maintainers = { '@JoeyGrajciar', '@vhyrro' },
}

M.configs.ocaml = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    files = { 'src/parser.c', 'src/scanner.cc' },
    location = 'ocaml',
  },
  maintainers = { '@undu' },
}

M.configs.ocaml_interface = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-ocaml',
    files = { 'src/parser.c', 'src/scanner.cc' },
    location = 'interface',
  },
  filetype = { 'ocamlinterface' },
  maintainers = { '@undu' },
}

M.configs.ocamllex = {
  install_info = {
    url = 'https://github.com/atom-ocaml/tree-sitter-ocamllex',
    files = { 'src/parser.c', 'src/scanner.cc' },
    requires_generate_from_grammar = true,
  },
  maintainers = { '@undu' },
}

M.configs.odin = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-odin',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
}

M.configs.pascal = {
  install_info = {
    url = 'https://github.com/Isopod/tree-sitter-pascal.git',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Isopod' },
}

M.configs.passwd = {
  install_info = {
    url = 'https://github.com/ath3/tree-sitter-passwd',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.perl = {
  install_info = {
    url = 'https://github.com/ganezdragon/tree-sitter-perl',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@lcrownover' },
}

M.configs.php = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-php',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@tk-shirasaka' },
}

-- Parsers for injections
M.configs.phpdoc = {
  install_info = {
    url = 'https://github.com/claytonrcarter/tree-sitter-phpdoc',
    files = { 'src/parser.c', 'src/scanner.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@mikehaertl' },
  tier = 4,
}

M.configs.pioasm = {
  install_info = {
    url = 'https://github.com/leo60228/tree-sitter-pioasm',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@leo60228' },
}

M.configs.po = {
  install_info = {
    url = 'https://github.com/erasin/tree-sitter-po',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.poe_filter = {
  install_info = {
    url = 'https://github.com/ObserverOfTime/tree-sitter-poe-filter',
    files = { 'src/parser.c' },
  },
  filetype = { 'poefilter' },
  maintainers = { '@ObserverOfTime' },
  readme_note = 'Path of Exile item filter',
  tier = 4,
}

M.configs.pony = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-pony',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq', '@mfelsche' },
}

M.configs.prisma = {
  install_info = {
    url = 'https://github.com/victorhqc/tree-sitter-prisma',
    files = { 'src/parser.c' },
  },
  maintainers = { '@elianiva' },
}

M.configs.proto = {
  install_info = {
    url = 'https://github.com/mitchellh/tree-sitter-proto',
    files = { 'src/parser.c' },
  },
  maintainers = { '@fsouza' },
}

M.configs.prql = {
  install_info = {
    url = 'https://github.com/PRQL/tree-sitter-prql',
    files = { 'src/parser.c' },
  },
  maintainers = { '@matthias-Q' },
}

M.configs.pug = {
  install_info = {
    url = 'https://github.com/zealot128/tree-sitter-pug',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@zealot128' },
  tier = 4,
}

M.configs.puppet = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-puppet',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.python = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-python',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@stsewd', '@theHamsta' },
}

M.configs.ql = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-ql',
    files = { 'src/parser.c' },
  },
  maintainers = { '@pwntester' },
}

M.configs.qmldir = {
  install_info = {
    url = 'https://github.com/Decodetalkers/tree-sitter-qmldir',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.qmljs = {
  install_info = {
    url = 'https://github.com/yuja/tree-sitter-qmljs',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'qml' },
  maintainers = { '@Decodetalkers' },
}

M.configs.query = {
  install_info = {
    url = 'https://github.com/nvim-treesitter/tree-sitter-query',
    files = { 'src/parser.c' },
  },
  maintainers = { '@steelsojka' },
  readme_note = 'Tree-sitter query language',
}

M.configs.r = {
  install_info = {
    url = 'https://github.com/r-lib/tree-sitter-r',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@echasnovski' },
}

M.configs.racket = {
  install_info = {
    url = 'https://github.com/6cdh/tree-sitter-racket',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@6cdh' },
}

M.configs.rasi = {
  install_info = {
    url = 'https://github.com/Fymyte/tree-sitter-rasi',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Fymyte' },
}

M.configs.regex = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-regex',
    files = { 'src/parser.c' },
  },
  maintainers = { '@theHamsta' },
}

M.configs.rego = {
  install_info = {
    url = 'https://github.com/FallenAngel97/tree-sitter-rego',
    files = { 'src/parser.c' },
  },
  maintainers = { '@FallenAngel97' },
}

M.configs.rnoweb = {
  install_info = {
    url = 'https://github.com/bamonroe/tree-sitter-rnoweb',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@bamonroe' },
}

M.configs.ron = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-ron',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.rst = {
  install_info = {
    url = 'https://github.com/stsewd/tree-sitter-rst',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@stsewd' },
}

M.configs.ruby = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-ruby',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@TravonteD' },
}

M.configs.rust = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-rust',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.scala = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-scala',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@stevanmilic' },
}

M.configs.scheme = {
  install_info = {
    url = 'https://github.com/6cdh/tree-sitter-scheme',
    files = { 'src/parser.c' },
  },
  maintainers = { '@6cdh' },
}

M.configs.scss = {
  install_info = {
    url = 'https://github.com/serenadeai/tree-sitter-scss',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@elianiva' },
}

M.configs.slint = {
  install_info = {
    url = 'https://github.com/jrmoulton/tree-sitter-slint',
    files = { 'src/parser.c' },
  },
  maintainers = { '@jrmoulton' },
  tier = 4,
}

M.configs.smali = {
  install_info = {
    url = 'https://git.sr.ht/~yotam/tree-sitter-smali',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.smithy = {
  install_info = {
    url = 'https://github.com/indoorvivants/tree-sitter-smithy',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq', '@keynmol' },
}

M.configs.solidity = {
  install_info = {
    url = 'https://github.com/JoranHonig/tree-sitter-solidity',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.sparql = {
  install_info = {
    url = 'https://github.com/BonaBeavis/tree-sitter-sparql',
    files = { 'src/parser.c' },
  },
  maintainers = { '@BonaBeavis' },
}

M.configs.sql = {
  install_info = {
    url = 'https://github.com/derekstride/tree-sitter-sql',
    files = { 'src/parser.c' },
    branch = 'gh-pages',
  },
  maintainers = { '@derekstride' },
}

M.configs.squirrel = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-squirrel',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.starlark = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-starlark',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = { 'bzl' },
  maintainers = { '@amaanq' },
}

M.configs.supercollider = {
  install_info = {
    url = 'https://github.com/madskjeldgaard/tree-sitter-supercollider',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@madskjeldgaard' },
}

M.configs.surface = {
  install_info = {
    url = 'https://github.com/connorlay/tree-sitter-surface',
    files = { 'src/parser.c' },
  },
  filetype = { 'sface' },
  maintainers = { '@connorlay' },
}

M.configs.svelte = {
  install_info = {
    url = 'https://github.com/Himujjal/tree-sitter-svelte',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@elianiva' },
}

M.configs.swift = {
  install_info = {
    url = 'https://github.com/alex-pinkus/tree-sitter-swift',
    files = { 'src/parser.c', 'src/scanner.c' },
    requires_generate_from_grammar = true,
  },
  maintainers = { '@alex-pinkus' },
}

M.configs.sxhkdrc = {
  install_info = {
    url = 'https://github.com/RaafatTurki/tree-sitter-sxhkdrc',
    files = { 'src/parser.c' },
  },
  maintainers = { '@RaafatTurki' },
}

M.configs.t32 = {
  install_info = {
    url = 'https://codeberg.org/xasc/tree-sitter-t32',
    files = { 'src/parser.c', 'src/scanner.c' },
    revision = '675cd7de4eb80f2faa1e6d3bc9ee195fa9ef9790',
  },
  maintainers = { '@xasc' },
}

M.configs.tablegen = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-tablegen',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@amaanq' },
}

M.configs.teal = {
  install_info = {
    url = 'https://github.com/euclidianAce/tree-sitter-teal',
    files = { 'src/parser.c', 'src/scanner.c' },
    requires_generate_from_grammar = true,
  },
  maintainers = { '@euclidianAce' },
}

M.configs.terraform = {
  install_info = {
    url = 'https://github.com/MichaHoffmann/tree-sitter-hcl',
    files = { 'src/parser.c', 'src/scanner.cc' },
    location = 'dialects/terraform',
  },
  maintainers = { '@MichaHoffmann' },
}

M.configs.thrift = {
  install_info = {
    url = 'https://github.com/duskmoon314/tree-sitter-thrift',
    files = { 'src/parser.c' },
  },
  maintainers = { '@amaanq', '@duskmoon314' },
}

M.configs.tiger = {
  install_info = {
    url = 'https://github.com/ambroisie/tree-sitter-tiger',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@ambroisie' },
}

M.configs.tlaplus = {
  install_info = {
    url = 'https://github.com/tlaplus-community/tree-sitter-tlaplus',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  filetype = { 'tla' },
  maintainers = { '@ahelwer', '@susliko' },
}

M.configs.todotxt = {
  install_info = {
    url = 'https://github.com/arnarg/tree-sitter-todotxt.git',
    files = { 'src/parser.c' },
  },
  maintainers = { '@arnarg' },
  tier = 4,
}

M.configs.toml = {
  install_info = {
    url = 'https://github.com/ikatyang/tree-sitter-toml',
    files = { 'src/parser.c', 'src/scanner.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@tk-shirasaka' },
}

M.configs.tsx = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    files = { 'src/parser.c', 'src/scanner.c' },
    location = 'tsx',
    generate_requires_npm = true,
  },
  filetype = { 'typescriptreact', 'typescript.tsx' },
  maintainers = { '@steelsojka' },
}

M.configs.turtle = {
  install_info = {
    url = 'https://github.com/BonaBeavis/tree-sitter-turtle',
    files = { 'src/parser.c' },
  },
  maintainers = { '@BonaBeavis' },
}

M.configs.twig = {
  install_info = {
    url = 'https://github.com/gbprod/tree-sitter-twig',
    files = { 'src/parser.c' },
  },
  maintainers = { '@gbprod' },
}

M.configs.typescript = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-typescript',
    files = { 'src/parser.c', 'src/scanner.c' },
    location = 'typescript',
    generate_requires_npm = true,
  },
  maintainers = { '@steelsojka' },
}

M.configs.ungrammar = {
  install_info = {
    url = 'https://github.com/Philipp-M/tree-sitter-ungrammar',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Philipp-M', '@amaanq' },
}

M.configs.usd = {
  install_info = {
    url = 'https://github.com/ColinKennedy/tree-sitter-usd',
    files = { 'src/parser.c' },
  },
  maintainers = { '@ColinKennedy' },
}

M.configs.uxntal = {
  install_info = {
    url = 'https://github.com/amaanq/tree-sitter-uxntal',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  filetype = { 'tal' },
  maintainers = { '@amaanq' },
  readme_note = 'uxn tal',
}

M.configs.v = {
  install_info = {
    url = 'https://github.com/vlang/vls',
    files = { 'src/parser.c', 'src/scanner.c' },
    location = 'tree_sitter_v',
  },
  filetype = { 'vlang' },
  maintainers = { '@kkharji' },
}

M.configs.vala = {
  install_info = {
    url = 'https://github.com/vala-lang/tree-sitter-vala',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Prince781' },
}

M.configs.verilog = {
  install_info = {
    url = 'https://github.com/tree-sitter/tree-sitter-verilog',
    files = { 'src/parser.c' },
  },
  filetype = { 'sysverilog' },
  maintainers = { '@zegervdv' },
}

M.configs.vhs = {
  install_info = {
    url = 'https://github.com/charmbracelet/tree-sitter-vhs',
    files = { 'src/parser.c' },
  },
  filetype = { 'tape' },
  maintainers = { '@caarlos0' },
}

M.configs.vim = {
  install_info = {
    url = 'https://github.com/neovim/tree-sitter-vim',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@clason' },
}

M.configs.vimdoc = {
  install_info = {
    url = 'https://github.com/neovim/tree-sitter-vimdoc',
    files = { 'src/parser.c' },
  },
  filetype = { 'help' },
  maintainers = { '@clason' },
}

M.configs.vue = {
  install_info = {
    url = 'https://github.com/ikatyang/tree-sitter-vue',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@WhyNotHugo' },
}

M.configs.wgsl = {
  install_info = {
    url = 'https://github.com/szebniok/tree-sitter-wgsl',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@szebniok' },
}

M.configs.wgsl_bevy = {
  install_info = {
    url = 'https://github.com/theHamsta/tree-sitter-wgsl-bevy',
    files = { 'src/parser.c', 'src/scanner.c' },
    generate_requires_npm = true,
  },
  maintainers = { '@theHamsta' },
}

M.configs.yaml = {
  install_info = {
    url = 'https://github.com/ikatyang/tree-sitter-yaml',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
  maintainers = { '@stsewd' },
}

M.configs.yang = {
  install_info = {
    url = 'https://github.com/Hubro/tree-sitter-yang',
    files = { 'src/parser.c' },
  },
  maintainers = { '@Hubro' },
}

M.configs.yuck = {
  install_info = {
    url = 'https://github.com/Philipp-M/tree-sitter-yuck',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
  maintainers = { '@Philipp-M', '@amaanq' },
}

M.configs.zig = {
  install_info = {
    url = 'https://github.com/maxxnino/tree-sitter-zig',
    files = { 'src/parser.c' },
  },
  maintainers = { '@maxxnino' },
}

-- Get a list of all available parsers
---@param tier integer? only get parsers of specified tier
---@return string[]
function M.get_available(tier)
  local parsers = vim.tbl_keys(M.configs)
  table.sort(parsers)
  if tier then
    parsers = vim.iter.filter(function(p)
      return M.configs[p].tier == tier
    end, parsers)
  end
  if vim.fn.executable('tree-sitter') == 0 or vim.fn.executable('node') == 0 then
    parsers = vim.iter.filter(function(p)
      return not M.configs[p].install_info.requires_generate_from_grammar
    end, parsers)
  end
  return parsers
end

return M
