local api = vim.api
local ts = vim.treesitter

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local configs = require'nvim-treesitter.configs'

local M = {
  highlighters = {}
}

local hlmap = vim.treesitter.highlighter.hl_map

-- Misc
hlmap.error = "TSError"
hlmap["punctuation.delimiter"] = "TSPunctDelimiter"
hlmap["punctuation.bracket"] = "TSPunctBracket"
hlmap["punctuation.special"] = "TSPunctSpecial"

-- Constants
hlmap["constant"] = "TSConstant"
hlmap["constant.builtin"] = "TSConstBuiltin"
hlmap["constant.macro"] = "TSConstMacro"
hlmap["string"] = "TSString"
hlmap["string.regex"] = "TSStringRegex"
hlmap["string.escape"] = "TSStringEscape"
hlmap["character"] = "TSCharacter"
hlmap["number"] = "TSNumber"
hlmap["boolean"] = "TSBoolean"
hlmap["float"] = "TSFloat"
hlmap["annotation"] = "TSAnnotation"
hlmap["attribute"] = "TSAttribute"

-- Functions
hlmap["function"] = "TSFunction"
hlmap["function.builtin"] = "TSFuncBuiltin"
hlmap["function.macro"] = "TSFuncMacro"
hlmap["parameter"] = "TSParameter"
hlmap["parameter.reference"] = "TSParameterReference"
hlmap["method"] = "TSMethod"
hlmap["field"] = "TSField"
hlmap["property"] = "TSProperty"
hlmap["constructor"] = "TSConstructor"

-- Keywords
hlmap["conditional"] = "TSConditional"
hlmap["repeat"] = "TSRepeat"
hlmap["label"] = "TSLabel"
hlmap["keyword"] = "TSKeyword"
hlmap["keyword.function"] = "TSKeywordFunction"
hlmap["keyword.operator"] = "TSKeywordOperator"
hlmap["operator"] = "TSOperator"
hlmap["exception"] = "TSException"

hlmap["type"] = "TSType"
hlmap["type.builtin"] = "TSTypeBuiltin"
hlmap["structure"] = "TSStructure"
hlmap["include"] = "TSInclude"

-- variable
hlmap["variable"] = "TSVariable"
hlmap["variable.builtin"] = "TSVariableBuiltin"

-- Text
hlmap["text"] = "TSText"
hlmap["text.strong"] = "TSStrong"
hlmap["text.emphasis"] = "TSEmphasis"
hlmap["text.underline"] = "TSUnderline"
hlmap["text.title"] = "TSTitle"
hlmap["text.literal"] = "TSLiteral"
hlmap["text.uri"] = "TSURI"

-- Tags
hlmap["tag"] = "TSTag"
hlmap["tag.delimiter"] = "TSTagDelimiter"

hlmap["none"] = "TSNone"

function M.attach(bufnr, lang)
  local lang = lang or parsers.get_buf_lang(bufnr)
  local config = configs.get_module('highlight')

  for k, v in pairs(config.custom_captures) do
    hlmap[k] = v
  end

  local query = queries.get_query(lang, "highlights")
  if not query then return end

  M.highlighters[bufnr] = ts.highlighter.new(query, bufnr, lang)
end

function M.detach(bufnr)
  if M.highlighters[bufnr] then
    M.highlighters[bufnr]:set_query("")
    M.highlighters[bufnr] = nil
  end
  api.nvim_buf_set_option(bufnr, 'syntax', 'on')
end

return M
