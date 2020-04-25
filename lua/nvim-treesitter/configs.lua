local api = vim.api
local queries = require'nvim-treesitter.query'
local parser_utils = require'nvim-treesitter.parsers'
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

-- @enable can be true or false
-- @disable is a list of languages, only relevant if enable is true
-- @keymaps list of user mappings for a given module if relevant
-- @is_supported function which, given a ft, will return true if the ft works on the module
local config = {
  highlight = {
    enable = false,
    disable = {},
    is_supported = function(ft)
      return queries.get_query(ft, 'highlights') ~= nil
    end
  },
  -- selection = {
  --   enable = false,
  --   disable = {},
  --   keymaps = {},
  --   is_supported = function() return false end
  -- },
  -- folding = {
  --   enable = false,
  --   disable = {},
  --   keymaps = {},
  --   is_supported = function() return false end
  -- }
}

local M = {}

local function enable_module(mod, bufnr, ft)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(bufnr, 'ft')
  if not parsers[ft] or not config[mod] then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.attach(bufnr, ft)
end

local function enable_mod_conf_autocmd(mod, ft)
  if not config[mod] or M.is_enabled(mod, ft) then return end

  local cmd = string.format("lua require'nvim-treesitter.%s'.attach()", mod)
  api.nvim_command(string.format("autocmd FileType %s %s", ft, cmd))
  for i, parser in pairs(config[mod].disable) do
    if parser == ft then
      table.remove(config[mod].disable, i)
      break
    end
  end
end

local function enable_all(mod, ft)
  if not config[mod] then return end

  for _, bufnr in pairs(api.nvim_list_bufs()) do
    if not ft or api.nvim_buf_get_option(bufnr, 'ft') == ft then
      enable_module(mod, bufnr, ft)
    end
  end
  if ft then
    enable_mod_conf_autocmd(mod, ft)
  else
    for _, ft in pairs(M.available_parsers()) do
      if parser_utils.has_parser(ft) then
        enable_mod_conf_autocmd(mod, ft)
      end
    end
  end
  config[mod].enable = true
end

local function disable_module(mod, bufnr, ft)
  local bufnr = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(bufnr, 'ft')
  if not parsers[ft] or not config[mod] then
    return
  end

  local loaded_mod = require(string.format("nvim-treesitter.%s", mod))
  loaded_mod.detach(bufnr, ft)
end

local function disable_mod_conf_autocmd(mod, ft)
  if not config[mod] or not M.is_enabled(mod, ft) then return end

  api.nvim_command(string.format("autocmd! FileType %s", ft))
  table.insert(config[mod].disable, ft)
end

local function disable_all(mod, ft)
  for _, bufnr in pairs(api.nvim_list_bufs()) do
    if not ft or api.nvim_buf_get_option(bufnr, 'ft') == ft then
      disable_module(mod, bufnr, ft)
    end
  end
  if ft then
    disable_mod_conf_autocmd(mod, ft)
  else
    for _, ft in pairs(M.available_parsers()) do
      if parser_utils.has_parser(ft) then
        disable_mod_conf_autocmd(mod, ft)
      end
    end
    config[mod].enable = false
  end
end

M.commands = {
  TSBufEnable = {
    run = enable_module,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSBufEnable module_name` enable a specified module on the current buffer'
  },
  TSBufDisable = {
    run = disable_module,
    args = {
      "-nargs=1",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSBufDisable module_name` disable a specified module on the current buffer'
  },
  TSEnableAll = {
    run = enable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSEnableAll module_name (filetype)` enables a specified module on all buffers. If filetype is specified, enable only for specified filetype'
  },
  TSDisableAll = {
    run = disable_all,
    args = {
      "-nargs=+",
      "-complete=custom,v:lua.ts_available_modules"
    },
    description = '`:TSDisableAll module_name (filetype)` disables a specified module on all buffers. If filetype is specified, disable only for specified filetype'
  },
}

-- @param mod: module (string)
-- @param ft: filetype (string)
function M.is_enabled(mod, ft)
  if not M.get_parser_configs()[ft] then return false end

  local module_config = M.get_config()[mod]
  if not module_config then return false end

  if not module_config.enable or not module_config.is_supported(ft) then
    return false
  end

  for _, parser in pairs(module_config.disable) do
    if ft == parser then return false end
  end
  return true
end

function M.setup(user_data)
  if not user_data then return end

  for mod, data in pairs(user_data) do
    if config[mod] then
      if type(data.enable) == 'boolean' then
        config[mod].enable = data.enable
      end
      if type(data.disable) == 'table' then
        config[mod].disable = data.disable
      end
      if config[mod].keymaps and type(data.keymaps) == 'table' then
        config[mod].keymaps = data.keymaps
      end
    end
  end
end

function M.get_config()
  return config
end

function M.get_parser_configs()
  return parsers
end

function M.available_parsers()
  return vim.tbl_keys(parsers)
end

function M.available_modules()
  return vim.tbl_keys(config)
end

return M
