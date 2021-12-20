local api = vim.api
local ts = vim.treesitter

local ft_to_parsername = {}

local function update_ft_to_parsername(name, parser)
  if type(parser.used_by) == "table" then
    for _, ft in pairs(parser.used_by) do
      ft_to_parsername[ft] = name
    end
  end
  ft_to_parsername[parser.filetype or name] = name
end

local list = setmetatable({}, {
  __newindex = function(table, parsername, parserconfig)
    rawset(
      table,
      parsername,
      setmetatable(parserconfig, {
        __newindex = function(parserconfigtable, key, value)
          if key == "used_by" then
            ft_to_parsername[value] = parsername
          else
            rawset(parserconfigtable, key, value)
          end
        end,
      })
    )

    update_ft_to_parsername(parsername, parserconfig)
  end,
})

list.javascript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = { "src/parser.c", "src/scanner.c" },
  },
  used_by = { "javascriptreact", "ecma", "jsx" },
  maintainers = { "@steelsojka" },
}

list.c = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = { "src/parser.c" },
  },
  maintainers = { "@vigoux" },
}

list.clojure = {
  install_info = {
    url = "https://github.com/sogaiu/tree-sitter-clojure",
    files = { "src/parser.c" },
  },
  maintainers = { "@sogaiu" },
}

list.commonlisp = {
  install_info = {
    url = "https://github.com/theHamsta/tree-sitter-commonlisp",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  filetype = "lisp",
  maintainers = { "@theHamsta" },
}

list.cpp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" },
    generate_requires_npm = true,
  },
  used_by = { "arduino" },
  maintainers = { "@theHamsta" },
}

list.cuda = {
  install_info = {
    url = "https://github.com/theHamsta/tree-sitter-cuda",
    files = { "src/parser.c", "src/scanner.cc" },
    generate_requires_npm = true,
  },
  maintainers = { "@theHamsta" },
}

list.d = {
  install_info = {
    url = "https://github.com/CyberShadow/tree-sitter-d",
    files = { "src/parser.c", "src/scanner.cc" },
    requires_generate_from_grammar = true,
  },
  maintainers = { "@nawordar" },
  -- Generating grammar takes ~60s
  experimental = true,
}

list.glsl = {
  install_info = {
    url = "https://github.com/theHamsta/tree-sitter-glsl",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  maintainers = { "@theHamsta" },
}

list.dockerfile = {
  install_info = {
    url = "https://github.com/camdencheek/tree-sitter-dockerfile",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@camdencheek" },
}

list.dot = {
  install_info = {
    url = "https://github.com/rydesun/tree-sitter-dot",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@rydesun" },
}

list.rust = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-rust",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@vigoux" },
}

list.fusion = {
  install_info = {
    url = "https://gitlab.com/jirgn/tree-sitter-fusion.git",
    files = { "src/parser.c" },
    branch = "main",
  },
  maintainers = { "@jirgn" },
  experimental = true,
}

list.ledger = {
  install_info = {
    url = "https://github.com/cbarrete/tree-sitter-ledger",
    files = { "src/parser.c" },
  },
  maintainers = { "@cbarrete" },
}

list.lua = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-lua",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@vigoux" },
}

list.python = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-python",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@stsewd", "@theHamsta" },
}

list.go = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-go",
    files = { "src/parser.c" },
  },
  maintainers = { "@theHamsta", "@WinWisely268" },
}

list.gomod = {
  install_info = {
    url = "https://github.com/camdencheek/tree-sitter-go-mod",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@camdencheek" },
  filetype = "gomod",
}

list.gowork = {
  install_info = {
    url = "https://github.com/omertuc/tree-sitter-go-work",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@omertuc" },
  filetype = "gowork",
}

list.graphql = {
  install_info = {
    url = "https://github.com/bkegley/tree-sitter-graphql",
    files = { "src/parser.c" },
  },
  maintainers = { "@bkegley" },
}

list.ruby = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ruby",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@TravonteD" },
}

list.perl = {
  install_info = {
    url = "https://github.com/ganezdragon/tree-sitter-perl",
    files = { "src/parser.c", "src/scanner.cc" },
    generate_requires_npm = true,
  },
  maintainers = { "@ganezdragon" },
}

list.bash = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-bash",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  used_by = { "PKGBUILD" },
  filetype = "sh",
  maintainers = { "@TravonteD" },
}

list.fish = {
  install_info = {
    url = "https://github.com/ram02z/tree-sitter-fish",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@ram02z" },
}

list.php = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-php",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@tk-shirasaka" },
}

list.java = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-java",
    files = { "src/parser.c" },
  },
  maintainers = { "@p00f" },
}

list.kotlin = {
  install_info = {
    url = "https://github.com/Joakker/tree-sitter-kotlin",
    files = { "src/parser.c" },
  },
  maintainers = { "@Joakker" },
}

list.html = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-html",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  used_by = { "html_tags" },
  maintainers = { "@TravonteD" },
}

list.julia = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-julia",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@mroavi", "@theHamsta" },
}

list.json = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-json",
    files = { "src/parser.c" },
  },
  maintainers = { "@steelsojka" },
}

list.css = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-css",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@TravonteD" },
}

list.scss = {
  install_info = {
    url = "https://github.com/serenadeai/tree-sitter-scss",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@elianiva" },
}

list.erlang = {
  install_info = {
    url = "https://github.com/AbstractMachinesLab/tree-sitter-erlang",
    files = { "src/parser.c" },
    branch = "main",
  },
  maintainers = { "@ostera" },
}

list.elixir = {
  install_info = {
    url = "https://github.com/elixir-lang/tree-sitter-elixir",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
  },
  maintainers = { "@jonatanklosko" },
}

list.surface = {
  install_info = {
    url = "https://github.com/connorlay/tree-sitter-surface",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "sface",
  maintainers = { "@connorlay" },
}

list.heex = {
  install_info = {
    url = "https://github.com/connorlay/tree-sitter-heex",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "heex",
  maintainers = { "@connorlay" },
}

list.ocaml = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
    location = "tree-sitter-ocaml/ocaml",
  },
  maintainers = { "@undu" },
}

list.ocaml_interface = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
    location = "tree-sitter-ocaml_interface/interface",
  },
  maintainers = { "@undu" },
  filetype = "ocamlinterface",
}

list.ocamllex = {
  install_info = {
    url = "https://github.com/atom-ocaml/tree-sitter-ocamllex",
    files = { "src/parser.c", "src/scanner.cc" },
    requires_generate_from_grammar = true,
  },
  maintainers = { "@undu" },
}

list.swift = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-swift",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
}

list.c_sharp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c-sharp",
    files = { "src/parser.c", "src/scanner.c" },
  },
  filetype = "cs",
  maintainers = { "@Luxed" },
}

list.typescript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-typescript/typescript",
    generate_requires_npm = true,
  },
  maintainers = { "@steelsojka" },
}

list.tsx = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-tsx/tsx",
    generate_requires_npm = true,
  },
  used_by = { "typescript.tsx" },
  filetype = "typescriptreact",
  maintainers = { "@steelsojka" },
}

list.scala = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-scala",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@stevanmilic" },
}

list.supercollider = {
  install_info = {
    url = "https://github.com/madskjeldgaard/tree-sitter-supercollider",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  maintainers = { "@madskjeldgaard" },
  filetype = "supercollider",
}

list.haskell = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-haskell",
    files = { "src/parser.c", "src/scanner.cc" },
  },
}

list.hcl = {
  install_info = {
    url = "https://github.com/MichaHoffmann/tree-sitter-hcl",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
  },
  maintainers = { "@MichaHoffmann" },
  filetype = "hcl",
  used_by = { "terraform" },
}

list.markdown = {
  install_info = {
    url = "https://github.com/MDeiml/tree-sitter-markdown",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
  },
  experimental = true,
}

list.tlaplus = {
  install_info = {
    url = "https://github.com/tlaplus-community/tree-sitter-tlaplus",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@ahelwer" },
  filetype = "tla",
}

list.toml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-toml",
    files = { "src/parser.c", "src/scanner.c" },
    generate_requires_npm = true,
  },
  maintainers = { "@tk-shirasaka" },
}

list.glimmer = {
  install_info = {
    url = "https://github.com/alexlafroscia/tree-sitter-glimmer",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  readme_name = "Glimmer and Ember",
  maintainers = { "@alexlafroscia" },
  filetype = "handlebars",
  used_by = { "html.handlebars" },
}

list.pug = {
  install_info = {
    url = "https://github.com/zealot128/tree-sitter-pug",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@zealot128" },
  filetype = "pug",
}

list.vue = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-vue",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@WhyNotHugo" },
}

list.jsonc = {
  install_info = {
    url = "https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  readme_name = "JSON with comments",
  maintainers = { "@WhyNotHugo" },
}

list.elm = {
  install_info = {
    url = "https://github.com/elm-tooling/tree-sitter-elm",
    files = { "src/parser.c", "src/scanner.cc" },
  },
}

list.yaml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-yaml",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@stsewd" },
}

list.yang = {
  install_info = {
    url = "https://github.com/Hubro/tree-sitter-yang",
    files = { "src/parser.c" },
  },
  maintainers = { "@Hubro" },
  filetype = "yang",
}

list.nix = {
  install_info = {
    url = "https://github.com/cstrahan/tree-sitter-nix",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@leo60228" },
}

list.dart = {
  install_info = {
    url = "https://github.com/UserNobody14/tree-sitter-dart",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@Akin909" },
}

list.rst = {
  install_info = {
    url = "https://github.com/stsewd/tree-sitter-rst",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@stsewd" },
}

list.fennel = {
  install_info = {
    url = "https://github.com/travonted/tree-sitter-fennel",
    files = { "src/parser.c" },
  },
  maintainers = { "@TravonteD" },
}

list.teal = {
  install_info = {
    url = "https://github.com/euclidianAce/tree-sitter-teal",
    files = { "src/parser.c", "src/scanner.c" },
    requires_generate_from_grammar = true,
  },
  maintainers = { "@euclidianAce" },
}

list.ql = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ql",
    files = { "src/parser.c" },
  },
  maintainers = { "@pwntester" },
}

list.verilog = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-verilog",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  used_by = { "systemverilog" },
  maintainers = { "@zegervdv" },
  -- The parser still uses API version 12, because it does not compile with 13
  experimental = true,
}

-- Parsers for injections
list.regex = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-regex",
    files = { "src/parser.c" },
  },
  maintainers = { "@theHamsta" },
}

list.comment = {
  install_info = {
    url = "https://github.com/stsewd/tree-sitter-comment",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@stsewd" },
}

list.jsdoc = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-jsdoc",
    files = { "src/parser.c" },
  },
  maintainers = { "@steelsojka" },
}

list.query = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-query",
    files = { "src/parser.c" },
  },
  readme_name = "Tree-sitter query language",
  maintainers = { "@steelsojka" },
}

list.sparql = {
  install_info = {
    url = "https://github.com/BonaBeavis/tree-sitter-sparql",
    files = { "src/parser.c" },
    branch = "main",
  },
  maintainers = { "@bonabeavis" },
}

list.gdscript = {
  install_info = {
    url = "https://github.com/PrestonKnopp/tree-sitter-gdscript",
    files = { "src/parser.c", "src/scanner.cc" },
    requires_generate_from_grammar = true,
  },
  readme_name = "Godot (gdscript)",
  maintainers = { "@Shatur95" },
}

list.godot_resource = {
  install_info = {
    url = "https://github.com/PrestonKnopp/tree-sitter-godot-resource",
    files = { "src/parser.c", "src/scanner.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "gdresource",
  readme_name = "Godot Resources (gdresource)",
  maintainers = { "@pierpo" },
}

list.turtle = {
  install_info = {
    url = "https://github.com/BonaBeavis/tree-sitter-turtle",
    files = { "src/parser.c" },
    branch = "main",
  },
  maintainers = { "@bonabeavis" },
}

list.devicetree = {
  install_info = {
    url = "https://github.com/joelspadin/tree-sitter-devicetree",
    files = { "src/parser.c" },
    branch = "main",
    requires_generate_from_grammar = true,
  },
  filetype = "dts",
  maintainers = { "@jedrzejboczar" },
}

list.svelte = {
  install_info = {
    url = "https://github.com/Himujjal/tree-sitter-svelte",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
  maintainers = { "@elianiva" },
}

list.r = {
  install_info = {
    url = "https://github.com/r-lib/tree-sitter-r",
    files = { "src/parser.c" },
  },
  maintainers = { "@jimhester" },
}

list.beancount = {
  install_info = {
    url = "https://github.com/polarmutex/tree-sitter-beancount",
    files = { "src/parser.c" },
    branch = "master",
  },
  maintainers = { "@polarmutex" },
}

list.latex = {
  install_info = {
    url = "https://github.com/latex-lsp/tree-sitter-latex",
    files = { "src/parser.c" },
  },
  filetype = "tex",
  used_by = { "cls", "sty" },
  maintainers = { "@theHamsta by asking @clason" },
}

list.bibtex = {
  install_info = {
    url = "https://github.com/latex-lsp/tree-sitter-bibtex",
    files = { "src/parser.c" },
  },
  filetype = "bib",
  maintainers = { "@theHamsta by asking @clason" },
}

list.zig = {
  install_info = {
    url = "https://github.com/maxxnino/tree-sitter-zig",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "zig",
  maintainers = { "@maxxnino" },
}

list.fortran = {
  install_info = {
    url = "https://github.com/stadelmanma/tree-sitter-fortran",
    files = { "src/parser.c", "src/scanner.cc" },
  },
}

list.cmake = {
  install_info = {
    url = "https://github.com/uyha/tree-sitter-cmake",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = { "@uyha" },
}

list.vim = {
  install_info = {
    url = "https://github.com/vigoux/tree-sitter-viml",
    files = { "src/parser.c", "src/scanner.c" },
  },
  filetype = "vim",
  maintainers = { "@vigoux" },
}

list.json5 = {
  install_info = {
    url = "https://github.com/Joakker/tree-sitter-json5",
    files = { "src/parser.c" },
  },
  filetype = "json5",
  maintainers = { "@Joakker" },
}

list.pioasm = {
  install_info = {
    url = "https://github.com/leo60228/tree-sitter-pioasm",
    branch = "main",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = { "@leo60228" },
}

list.hjson = {
  install_info = {
    url = "https://github.com/winston0410/tree-sitter-hjson",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  maintainers = { "@winston0410" },
}

list.llvm = {
  install_info = {
    url = "https://github.com/benwilliamgraham/tree-sitter-llvm",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@benwilliamgraham" },
}

list.http = {
  install_info = {
    url = "https://github.com/NTBBloodbath/tree-sitter-http",
    branch = "main",
    files = { "src/parser.c" },
    generate_requires_npm = true,
  },
  maintainers = { "@NTBBloodbath" },
}

list.prisma = {
  install_info = {
    url = "https://github.com/victorhqc/tree-sitter-prisma",
    branch = "master",
    files = { "src/parser.c" },
  },
  maintainers = { "@elianiva" },
}

list.make = {
  install_info = {
    url = "https://github.com/alemuller/tree-sitter-make",
    branch = "main",
    files = { "src/parser.c" },
  },
  maintainers = { "@lewis6991" },
}

local M = {
  list = list,
}

function M.ft_to_lang(ft)
  local result = ft_to_parsername[ft]
  if result then
    return result
  else
    ft = vim.split(ft, ".", true)[1]
    return ft_to_parsername[ft] or ft
  end
end

function M.available_parsers()
  if vim.fn.executable "tree-sitter" == 1 and vim.fn.executable "node" == 1 then
    return vim.tbl_keys(M.list)
  else
    return vim.tbl_filter(function(p)
      return not M.list[p].install_info.requires_generate_from_grammar
    end, vim.tbl_keys(M.list))
  end
end

function M.maintained_parsers()
  local has_tree_sitter_cli = vim.fn.executable "tree-sitter" == 1 and vim.fn.executable "node" == 1
  return vim.tbl_filter(function(lang)
    return M.list[lang].maintainers
      and not M.list[lang].experimental
      and (has_tree_sitter_cli or not M.list[lang].install_info.requires_generate_from_grammar)
  end, M.available_parsers())
end

function M.get_parser_configs()
  return M.list
end

local parser_files

function M.reset_cache()
  parser_files = setmetatable({}, {
    __index = function(tbl, key)
      rawset(tbl, key, api.nvim_get_runtime_file("parser/" .. key .. ".*", false))
      return rawget(tbl, key)
    end,
  })
end

M.reset_cache()

function M.has_parser(lang)
  local lang = lang or M.get_buf_lang(api.nvim_get_current_buf())

  if not lang or #lang == 0 then
    return false
  end
  -- HACK: nvim internal API
  if vim._ts_has_language(lang) then
    return true
  end
  return #parser_files[lang] > 0
end

function M.get_parser(bufnr, lang)
  local buf = bufnr or api.nvim_get_current_buf()
  local lang = lang or M.get_buf_lang(buf)

  if M.has_parser(lang) then
    return ts.get_parser(bufnr, lang)
  end
end

-- @deprecated This is only kept for legacy purposes.
--             All root nodes should be accounted for.
function M.get_tree_root(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  return M.get_parser(bufnr):parse()[1]:root()
end

-- get language of given buffer
-- @param optional buffer number or current buffer
-- @returns language string of buffer
function M.get_buf_lang(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  return M.ft_to_lang(api.nvim_buf_get_option(bufnr, "ft"))
end

return M
