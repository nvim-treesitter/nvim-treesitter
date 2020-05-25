local api = vim.api
local parsers = require'nvim-treesitter.parsers'

local M = {}

function M.get_fold_indic(lnum)
  if not parsers.has_parser() or not lnum then return '0' end

  local function smallest_multiline_containing(node, level)
    for index = 0,(node:named_child_count() -1) do
      local child = node:named_child(index)
      local start, _, stop, _ = child:range()

      if start ~= stop and start <= (lnum -1) and stop >= (lnum -1) then
        return smallest_multiline_containing(child, level + 1)
      end
    end

    return node, level
  end

  local parser = parsers.get_parser()

  local multiline_here, level = smallest_multiline_containing(parser:parse():root(), 0)

  return tostring(level)
end

return M
