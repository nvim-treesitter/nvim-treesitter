local api = vim.api
local ts = vim.treesitter

local queries = require'nvim-treesitter.query'

local M = {
  highlighters = {}
}

local hlmap = vim.treesitter.TSHighlighter.hl_map

-- Misc
hlmap.error = "Error"
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = "Delimiter"

-- Constants
hlmap["constant"] = "Constant"
hlmap["constant.builtin"] = "Special"
hlmap["constant.macro"] = "Define"
hlmap["string"] = "String"
hlmap["string.regex"] = "String"
hlmap["string.escape"] = "SpecialChar"
hlmap["character"] = "Character"
hlmap["number"] = "Number"
hlmap["boolean"] = "Boolean"
hlmap["float"] = "Float"

-- Functions
hlmap["function"] = "Function"
hlmap["function.builtin"] = "Special"
hlmap["function.macro"] = "Macro"
hlmap["parameter"] = "Identifier"
hlmap["method"] = "Function"
hlmap["field"] = "Identifier"
hlmap["property"] = "Identifier"
hlmap["constructor"] = "Special"

-- Keywords
hlmap["conditional"] = "Conditional"
hlmap["repeat"] = "Repeat"
hlmap["label"] = "Label"
hlmap["operator"] = "Operator"
hlmap["keyword"] = "Keyword"
hlmap["exception"] = "Exception"

hlmap["type"] = "Type"
hlmap["type.builtin"] = "Type"
hlmap["structure"] = "Structure"
hlmap["include"] = "Include"

function M.attach(bufnr, ft)
  local buf = bufnr or api.nvim_get_current_buf()
  local ft = ft or api.nvim_buf_get_option(buf, 'ft')

  local query = queries.get_query(ft, "highlights")
  if not query then return end

  M.highlighters[buf] = ts.TSHighlighter.new(query, buf, ft)
end

function M.detach(bufnr)
  local buf = bufnr or api.nvim_get_current_buf()
  if M.highlighters[buf] then
    M.highlighters[buf]:set_query("")
    M.highlighters[buf] = nil
  end
  api.nvim_buf_set_option(buf, 'syntax', 'on')
end

return M
