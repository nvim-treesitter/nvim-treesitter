-- Runs in the Nvim under test (see tests/query/injection_spec.lua).
local assertions = require('tests.query.assertions')

local M = {}

--- Check the injection assertions in `file` against the language tree of Nvim's highlighter.
---@param file string
function M.check(file)
  local buf, lang = assertions.open(file)
  local list = assertions.parse(buf, lang)

  local tree = vim.treesitter.highlighter.active[buf].tree
  local top_level_root = tree:parse(true)[1]:root()

  local errors = {} ---@type string[]
  for _, a in ipairs(list) do
    -- Is there an injected tree of the expected language at the position?
    local found = false
    tree:for_each_tree(function(tstree, ltree)
      if not tstree then
        return
      end
      local root = tstree:root()
      if root ~= top_level_root and vim.treesitter.is_in_node_range(root, a.row, a.col) then
        found = found or ltree:lang() == a.capture
      end
    end)
    if found == a.negated then
      errors[#errors + 1] = string.format(
        'Error in %s:%d:%d: expected "%s"%s to be injected here!',
        file,
        a.row + 1,
        a.col + 1,
        a.capture,
        a.negated and ' not' or ''
      )
    end
  end
  assert(#errors == 0, table.concat(errors, '\n'))
end

return M
