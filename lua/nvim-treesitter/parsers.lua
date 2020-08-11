local api = vim.api
local ts = vim.treesitter

local list = {}

list.javascript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.c = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = { "src/parser.c" }
  }
}

list.cpp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" }
  },
  used_by = { "cuda" },
}

list.rust = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-rust",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.lua = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-lua",
    files = { "src/parser.c", "src/scanner.cc" }
  }
}

list.python = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-python",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.go = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-go",
    files = { "src/parser.c" },
  }
}

list.ruby = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ruby",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.bash = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-bash",
    files = { "src/parser.c", "src/scanner.cc" },
  },
  used_by = { "zsh" },
  filetype = 'sh'
}

list.php = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-php",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.java = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-java",
    files = { "src/parser.c" },
  }
}

list.html = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-html",
    files = { "src/parser.c", "src/scanner.cc" },
  }
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
  }
}

list.css = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-css",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.ocaml = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
  }
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
  filetype = 'cs'
}

list.typescript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-typescript/typescript"
  }
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

list.markdown = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-markdown",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.toml = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-toml",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.vue = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-vue",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

list.elm = {
  install_info = {
    url = "https://github.com//razzeee/tree-sitter-elm",
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
  }
}

list.dart = {
  install_info = {
    url = "https://github.com/UserNobody14/tree-sitter-dart",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

list.rst = {
  install_info = {
    url = "https://github.com/stsewd/tree-sitter-rst",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

-- Parsers for injections
list.regex = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-regex",
    files = { "src/parser.c" }
  }
}

list.jsdoc = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-jsdoc",
    files = { "src/parser.c" }
  }
}

list.query = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-query",
    files = { "src/parser.c" }
  }
}

local M = {
  list = list
}

local ft_to_parsername = {}

for name, obj in pairs(M.list) do
  if type(obj.used_by) == 'table' then
    for _, ft in pairs(obj.used_by) do
      ft_to_parsername[ft] = name
    end
  end
  ft_to_parsername[obj.filetype or name] = name
end

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

function M.get_parser_configs()
  return M.list
end

function M.has_parser(lang)
  local buf = api.nvim_get_current_buf()
  local lang = lang or M.get_buf_lang(buf)
  if not lang or #lang == 0 then return false end
  return #api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
end

function M.get_parser(bufnr, lang)
  local buf = bufnr or api.nvim_get_current_buf()
  local lang = lang or M.get_buf_lang(buf)

  if M.has_parser(lang) then
    if not M[buf] then
      M[buf] = {}
    end
    if not M[buf][lang] then
      M[buf][lang] = ts.get_parser(buf, lang)
    end
    return M[buf][lang]
  end
end

function M.get_tree_root(bufnr)
  local bufnr = bufnr or api.nvim_get_current_buf()

  return M.get_parser(bufnr).tree:root()
end

-- get language of given buffer
-- @param optional buffer number or current buffer
-- @returns language string of buffer
function M.get_buf_lang(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  return M.ft_to_lang(api.nvim_buf_get_option(bufnr, "ft"))
end

return M
