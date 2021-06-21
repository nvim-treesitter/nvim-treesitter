local api = vim.api
local ts = vim.treesitter

local parsers = require'nvim-treesitter.parsers'
local configs = require'nvim-treesitter.configs'

local M = {
}

local hlmap = vim.treesitter.highlighter.hl_map

-- nvim-treesitter Highlight Group Mappings
-- Note: Some highlight groups may not be applied upstream, some may be experimental

hlmap["annotation"] = "TSAnnotation"

hlmap["attribute"] = "TSAttribute"

hlmap["boolean"] = "TSBoolean"

hlmap["character"] = "TSCharacter"

hlmap["comment"] = "TSComment"

hlmap["conditional"] = "TSConditional"

hlmap["constant"] = "TSConstant"
hlmap["constant.builtin"] = "TSConstBuiltin"
hlmap["constant.macro"] = "TSConstMacro"

hlmap["constructor"] = "TSConstructor"

hlmap["error"] = "TSError"
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

hlmap["symbol"] = "TSSymbol"

hlmap["tag"] = "TSTag"
hlmap["tag.delimiter"] = "TSTagDelimiter"

hlmap["text"] = "TSText"
hlmap["text.strong"] = "TSStrong"
hlmap["text.emphasis"] = "TSEmphasis"
hlmap["text.underline"] = "TSUnderline"
hlmap["text.strike"] = "TSStrike"
hlmap["text.title"] = "TSTitle"
hlmap["text.literal"] = "TSLiteral"
hlmap["text.uri"] = "TSURI"
hlmap["text.math"] = "TSMath"
hlmap["text.reference"] = "TSTextReference"
hlmap["text.environment"] = "TSEnvironment"
hlmap["text.environment.name"] = "TSEnvironmentName"

hlmap["text.note"] = "TSNote"
hlmap["text.warning"] = "TSWarning"
hlmap["text.danger"] = "TSDanger"

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

  ts.highlighter.new(parser, {})

  local is_table = type(config.additional_vim_regex_highlighting) == 'table'
  if config.additional_vim_regex_highlighting and (not is_table or config.additional_vim_regex_highlighting[lang]) then
    api.nvim_buf_set_option(bufnr, 'syntax', 'ON')
  end
end

function M.detach(bufnr)
  if ts.highlighter.active[bufnr] then
    ts.highlighter.active[bufnr]:destroy()
  end
  api.nvim_buf_set_option(bufnr, 'syntax', 'ON')
end

return M
