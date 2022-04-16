-- Last Change: 2022 Apr 16

if vim.g.loaded_nvim_treesitter then
  return
end
vim.g.loaded_nvim_treesitter = true

-- setup modules
require("nvim-treesitter").setup()

local api = vim.api

-- define autocommands
local augroup = api.nvim_create_augroup("NvimTreesitter", {})

api.nvim_create_autocmd("Filetype", {
  pattern = "query",
  group = augroup,
  callback = function()
    api.nvim_clear_autocmds {
      group = augroup,
      event = "BufWritePost",
    }
    api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = 0,
      callback = function(opts)
        require("nvim-treesitter.query").invalidate_query_file(opts.file)
      end,
      desc = "Invalidate query file",
    })
  end,
  desc = "Reload query",
})

-- define highlights
local highlights = {
  TSNone = { default = true },
  TSPunctDelimiter = { link = "Delimiter", default = true },
  TSPunctBracket = { link = "Delimiter", default = true },
  TSPunctSpecial = { link = "Delimiter", default = true },

  TSConstant = { link = "Constant", default = true },
  TSConstBuiltin = { link = "Special", default = true },
  TSConstMacro = { link = "Define", default = true },
  TSString = { link = "String", default = true },
  TSStringRegex = { link = "String", default = true },
  TSStringEscape = { link = "SpecialChar", default = true },
  TSStringSpecial = { link = "SpecialChar", default = true },
  TSCharacter = { link = "Character", default = true },
  TSCharacterSpecial = { link = "SpecialChar", default = true },
  TSNumber = { link = "Number", default = true },
  TSBoolean = { link = "Boolean", default = true },
  TSFloat = { link = "Float", default = true },

  TSFunction = { link = "Function", default = true },
  TSFuncBuiltin = { link = "Special", default = true },
  TSFuncMacro = { link = "Macro", default = true },
  TSParameter = { link = "Identifier", default = true },
  TSParameterReference = { link = "TSParameter", default = true },
  TSMethod = { link = "Function", default = true },
  TSField = { link = "Identifier", default = true },
  TSProperty = { link = "Identifier", default = true },
  TSConstructor = { link = "Special", default = true },
  TSAnnotation = { link = "PreProc", default = true },
  TSAttribute = { link = "PreProc", default = true },
  TSNamespace = { link = "Include", default = true },
  TSSymbol = { link = "Identifier", default = true },

  TSConditional = { link = "Conditional", default = true },
  TSRepeat = { link = "Repeat", default = true },
  TSLabel = { link = "Label", default = true },
  TSOperator = { link = "Operator", default = true },
  TSKeyword = { link = "Keyword", default = true },
  TSKeywordFunction = { link = "Keyword", default = true },
  TSKeywordOperator = { link = "TSOperator", default = true },
  TSKeywordReturn = { link = "TSKeyword", default = true },
  TSException = { link = "Exception", default = true },
  TSDebug = { link = "Debug", default = true },
  TSDefine = { link = "Define", default = true },
  TSPreProc = { link = "PreProc", default = true },
  TSStorageClass = { link = "StorageClass", default = true },

  TSTodo = { link = "Todo", default = true },

  TSType = { link = "Type", default = true },
  TSTypeBuiltin = { link = "Type", default = true },
  TSTypeQualifier = { link = "Type", default = true },
  TSTypeDefinition = { link = "Typedef", default = true },

  TSInclude = { link = "Include", default = true },

  TSVariableBuiltin = { link = "Special", default = true },

  TSText = { link = "TSNone", default = true },
  TSStrong = { bold = true, default = true },
  TSEmphasis = { italic = true, default = true },
  TSUnderline = { underline = true },
  TSStrike = { strikethrough = true },

  TSMath = { link = "Special", default = true },
  TSTextReference = { link = "Constant", default = true },
  TSEnvironment = { link = "Macro", default = true },
  TSEnvironmentName = { link = "Type", default = true },
  TSTitle = { link = "Title", default = true },
  TSLiteral = { link = "String", default = true },
  TSURI = { link = "Underlined", default = true },

  TSComment = { link = "Comment", default = true },
  TSNote = { link = "SpecialComment", default = true },
  TSWarning = { link = "Todo", default = true },
  TSDanger = { link = "WarningMsg", default = true },

  TSTag = { link = "Label", default = true },
  TSTagDelimiter = { link = "Delimiter", default = true },
  TSTagAttribute = { link = "TSProperty", default = true },
}

for k, v in pairs(highlights) do
  api.nvim_set_hl(0, k, v)
end
