-- Runs in the Nvim under test (see tests/query/highlights_spec.lua).
local assertions = require('tests.query.assertions')

local M = {}

local COMMENT_NODES = {
  markdown = 'html_block',
  haskell = 'haddock',
}

--- Check the highlight assertions in `file` against the captures of Nvim's highlighter.
---@param file string
function M.check(file)
  local buf, lang = assertions.open(file)
  local list = assertions.parse(buf, lang, COMMENT_NODES[lang])
  assert(#list > 0, 'No assertions detected!')

  local errors = {} ---@type string[]
  for _, a in ipairs(list) do
    local captures = {} ---@type table<string, true>
    for _, c in ipairs(vim.treesitter.get_captures(buf, { a.row, a.col })) do
      if c.capture ~= 'conceal' and c.capture ~= 'spell' then
        captures[c.capture] = true
      end
    end
    if (captures[a.capture] == true) == a.negated then
      errors[#errors + 1] = string.format(
        'Error in %s:%d:%d: expected "%s%s", captures: %s',
        file,
        a.row + 1,
        a.col + 1,
        a.negated and '!' or '',
        a.capture,
        vim.inspect(vim.tbl_keys(captures))
      )
    end
  end
  assert(#errors == 0, table.concat(errors, '\n'))
end

return M
