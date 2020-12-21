local api = vim.api
local ts = vim.treesitter

local queries = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'
local configs = require'nvim-treesitter.configs'

local M = {
  highlighters = {}
}

local hlmap = vim.treesitter.highlighter.hl_map

-- nvim-treesitter Highlight Group Mappings
-- Note: Some highlight groups may not be applied upstream, some may be experimental

hlmap["annotation"] = "TSAnnotation"

hlmap["attribute"] = "TSAttribute"

hlmap["boolean"] = "TSBoolean"

hlmap["character"] = "TSCharacter"

hlmap["conditional"] = "TSConditional"

hlmap["constant"] = "TSConstant"
hlmap["constant.builtin"] = "TSConstBuiltin"
hlmap["constant.macro"] = "TSConstMacro"

hlmap["constructor"] = "TSConstructor"

hlmap.error = "TSError"
hlmap["exception"] = "TSException"

hlmap["field"] = "TSField"

hlmap["float"] = "TSFloat"

hlmap["function"] = "TSFunction"
hlmap["function.builtin"] = "TSFuncBuiltin"
hlmap["function.macro"] = "TSFuncMacro"

hlmap["include"] = "TSInclude"

hlmap["keyword"] = "TSKeyword"
hlmap["keyword.function"] = "TSKeywordFunction"
hlmap["keyword.operator"] = "TSKeywordOperator"

hlmap["label"] = "TSLabel"

hlmap["method"] = "TSMethod"

hlmap["namespace"] = "TSNamespace"

hlmap["none"] = "TSNone"
hlmap["number"] = "TSNumber"

hlmap["operator"] = "TSOperator"

hlmap["parameter"] = "TSParameter"
hlmap["parameter.reference"] = "TSParameterReference"

hlmap["property"] = "TSProperty"

hlmap["punctuation.delimiter"] = "TSPunctDelimiter"
hlmap["punctuation.bracket"] = "TSPunctBracket"
hlmap["punctuation.special"] = "TSPunctSpecial"

hlmap["repeat"] = "TSRepeat"

hlmap["string"] = "TSString"
hlmap["string.regex"] = "TSStringRegex"
hlmap["string.escape"] = "TSStringEscape"

hlmap["tag"] = "TSTag"
hlmap["tag.delimiter"] = "TSTagDelimiter"

hlmap["text"] = "TSText"
hlmap["text.strong"] = "TSStrong"
hlmap["text.emphasis"] = "TSEmphasis"
hlmap["text.underline"] = "TSUnderline"
hlmap["text.title"] = "TSTitle"
hlmap["text.literal"] = "TSLiteral"
hlmap["text.uri"] = "TSURI"

hlmap["type"] = "TSType"
hlmap["type.builtin"] = "TSTypeBuiltin"

hlmap["variable"] = "TSVariable"
hlmap["variable.builtin"] = "TSVariableBuiltin"

function M.attach(bufnr, lang)
  local parser = parsers.get_parser(bufnr, lang)
  local config = configs.get_module('highlight')

  for k, v in pairs(config.custom_captures) do
    hlmap[k] = v
  end

  local query = queries.get_query(lang, "highlights")
  if not query then return end

  M.highlighters[bufnr] = ts.highlighter.new(parser, query)
end

function M.detach(bufnr)
  if M.highlighters[bufnr] then
    M.highlighters[bufnr]:set_query("")
    M.highlighters[bufnr] = nil
  end
  api.nvim_buf_set_option(bufnr, 'syntax', 'on')
end

return M
