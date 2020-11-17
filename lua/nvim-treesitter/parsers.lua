local api = vim.api
local ts = vim.treesitter

local ft_to_parsername = {}

local function update_ft_to_parsername(name, parser)
  if type(parser.used_by) == 'table' then
    for _, ft in pairs(parser.used_by) do
      ft_to_parsername[ft] = name
    end
  end
  ft_to_parsername[parser.filetype or name] = name
end

local list = setmetatable({}, {
  __newindex = function(table, parsername, parserconfig)

    rawset(table, parsername, setmetatable(parserconfig, {
      __newindex = function(parserconfigtable, key, value)
        if key == "used_by" then
          ft_to_parsername[value] = parsername
        else
          rawset(parserconfigtable, key, value)
        end
      end
    }))

    update_ft_to_parsername(parsername, parserconfig)
   end
})

list.javascript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = { "src/parser.c", "src/scanner.c" },
  },
  used_by = { 'javascriptreact' },
  maintainers = {"@steelsojka"},
}

list.c = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = { "src/parser.c" }
  },
  maintainers = {"@vigoux"},
}

list.clojure = {
  install_info = {
    url = "https://github.com/sogaiu/tree-sitter-clojure",
    files = { "src/parser.c" }
  },
  maintainers = {"@sogaiu"},
}

list.cpp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" }
  },
  used_by = { "cuda" },
  maintainers = {"@theHamsta"},
}

list.rust = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-rust",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {"@vigoux"},
}

list.lua = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-lua",
    files = { "src/parser.c", "src/scanner.cc" }
  },
  maintainers = {"@vigoux"},
}

list.python = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-python",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {'@stsewd', "@theHamsta"},
}

list.go = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-go",
    files = { "src/parser.c" },
  },
  maintainers = {"@theHamsta", "@WinWisely268"},
}

list.graphql = {
  install_info = {
    url = "https://github.com/bkegley/tree-sitter-graphql",
    files = { "src/parser.c" },
  },
  maintainers = {"@bkegley"},
}

list.ruby = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ruby",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {'@TravonteD'},
}

list.bash = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-bash",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  used_by = { "zsh", "PKGBUILD" },
  filetype = 'sh',
  maintainers = {"@TravonteD"},
}

list.php = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-php",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {"@tk-shirasaka"},
}

list.java = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-java",
    files = { "src/parser.c" },
  },
  maintainers = {"@p00f"},
}

list.kotlin = {
  install_info = {
    url = "https://github.com/QthCN/tree-sitter-kotlin",
    files = { "src/parser.c" },
  },
  maintainers = {"@tormodatt"},
}

list.html = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-html",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {"@TravonteD"},
}

list.julia = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-julia",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.json = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-json",
    files = { "src/parser.c" },
  },
  maintainers = {"@steelsojka"},
}

list.css = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-css",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {"@TravonteD"},
}

list.erlang = {
  install_info = {
    url = "https://github.com/AbstractMachinesLab/tree-sitter-erlang",
    files = { "src/parser.c" },
    branch = "main",
  },
  maintainers = { '@ostera' },
}

list.ocaml = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
    location = "tree-sitter-ocaml/ocaml"
  },
  maintainers = {'@undu'},
}

list.ocaml_interface = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
    location = "tree-sitter-ocaml_interface/interface"
  },
  maintainers = {'@undu'},
  filetype = 'ocamlinterface'
}

list.ocamllex = {
  install_info = {
    url = "https://github.com/atom-ocaml/tree-sitter-ocamllex",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {'@undu'},
}

list.swift = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-swift",
    files = { "src/parser.c" },
  }
}

list.c_sharp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c-sharp",
    files = { "src/parser.c", "src/scanner.c" },
  },
  filetype = 'cs',
  maintainers = {'@svermeulen'},
}

list.typescript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-typescript/typescript"
  },
  maintainers = {"@steelsojka"},
}

list.tsx = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-tsx/tsx"
  },
  used_by = { "typescript.tsx" },
  filetype = 'typescriptreact'
}

list.scala = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-scala",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.haskell = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-haskell",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

-- FIXME(vigoux): markdown is broken for now
-- list.markdown = {
--   install_info = {
--     url = "https://github.com/ikatyang/tree-sitter-markdown",
--     files = { "src/parser.c", "src/scanner.cc" },
--   }
-- }

list.toml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-toml",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {"@tk-shirasaka"},
}

list.vue = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-vue",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.elm = {
  install_info = {
    url = "https://github.com/razzeee/tree-sitter-elm",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.yaml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-yaml",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.nix = {
  install_info = {
    url = "https://github.com/cstrahan/tree-sitter-nix",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  maintainers = {"@leo60228"},
}

list.dart = {
  install_info = {
    url = "https://github.com/UserNobody14/tree-sitter-dart",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {"@Akin909"},
}

list.rst = {
  install_info = {
    url = "https://github.com/stsewd/tree-sitter-rst",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {"@stsewd"},
}

list.fennel = {
  install_info = {
    url = "https://github.com/travonted/tree-sitter-fennel",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {'@TravonteD'},
}

list.teal = {
  install_info = {
    url = "https://github.com/euclidianAce/tree-sitter-teal",
    files = { "src/parser.c", "src/scanner.c" },
  },
  maintainers = {'@euclidianAce'},
}

list.ql = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ql",
    files = { "src/parser.c" },
  },
  maintainers = {'@pwntester'},
}

list.verilog = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-verilog",
    files = { "src/parser.c" },
  },
  used_by = { "systemverilog" },
  maintainers = { "@zegervdv" },
}
-- Parsers for injections
list.regex = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-regex",
    files = { "src/parser.c" }
  },
  maintainers = {"@theHamsta"},
}

list.jsdoc = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-jsdoc",
    files = { "src/parser.c" }
  },
  maintainers = {"@steelsojka"},
}

list.query = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-query",
    files = { "src/parser.c" }
  },
  readme_name = "Tree-sitter query language",
  maintainers = {"@steelsojka"},
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
  },
  readme_name = "Godot (gdscript)",
  maintainers = {"not @tjdevries"},
}

local M = {
  list = list
}

function M.ft_to_lang(ft)
  return ft_to_parsername[ft] or ft
end

function M.lang_to_ft(lang)
  local obj = M.list[lang]
  return vim.tbl_flatten({{obj.filetype or lang}, obj.used_by or {}})
end

function M.lang_match_ft(lang, ft)
  for _, f in pairs(M.lang_to_ft(lang)) do
    if ft == f then
      return true
    end
  end
  return false
end

function M.available_parsers()
  return vim.tbl_keys(M.list)
end

function M.maintained_parsers()
  return vim.tbl_filter(function(lang) return M.list[lang].maintainers end, M.available_parsers())
end

function M.get_parser_configs()
  return M.list
end

local parser_files

function M.reset_cache()
  parser_files = setmetatable({}, {
    __index = function(tbl, key)
      rawset(tbl, key, api.nvim_get_runtime_file('parser/' .. key .. '.*', false))
      return rawget(tbl, key)
    end
  })
end

M.reset_cache()

function M.has_parser(lang)
  local lang = lang or M.get_buf_lang(api.nvim_get_current_buf())

  if not lang or #lang == 0 then return false end
  -- HACK: nvim internal API
  if vim._ts_has_language(lang) then return true end
  return #parser_files[lang] > 0
end

function M.get_parser(bufnr, lang)
  local buf = bufnr or api.nvim_get_current_buf()
  local lang = lang or M.get_buf_lang(buf)

  if M.has_parser(lang) then
    return ts.get_parser(bufnr, lang)
  end
end

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
