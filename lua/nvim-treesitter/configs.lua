local api = vim.api
local parsers = {}

parsers.javascript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-javascript",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

parsers.c = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c",
    files = { "src/parser.c" }
  }
}

parsers.cpp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-cpp",
    files = { "src/parser.c", "src/scanner.cc" }
  }
}

parsers.rust = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-rust",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

parsers.lua = {
  install_info = {
    url = "https://github.com/nvim-treesitter/tree-sitter-lua",
    files = { "src/parser.c", "src/scanner.cc" }
  }
}

parsers.python = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-python",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.go = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-go",
    files = { "src/parser.c" },
  }
}

parsers.ruby = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ruby",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.bash = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-bash",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.php = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-php",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.java = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-java",
    files = { "src/parser.c" },
  }
}

parsers.html = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-html",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.julia = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-julia",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

parsers.json = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-json",
    files = { "src/parser.c" },
  }
}

parsers.css = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-css",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

parsers.ocaml = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-ocaml",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}

parsers.swift = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-swift",
    files = { "src/parser.c" },
  }
}

parsers.csharp = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-c-sharp",
    files = { "src/parser.c", "src/scanner.c" },
  }
}

parsers.typescript = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-typescript/typescript"
  }
}

parsers.tsx = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-typescript",
    files = { "src/parser.c", "src/scanner.c" },
    location = "tree-sitter-tsx/tsx"
  }
}

local M = {}

function M.get_configs()
  return parsers
end

function M.available_parsers()
  return vim.tbl_keys(parsers)
end

return M
