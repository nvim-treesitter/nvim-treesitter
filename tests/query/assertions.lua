-- Runs in the Nvim under test (see tests/query/{highlights,injections}.lua).
--
-- Parses assertion comments like the highlight-assertions tool did, i.e., like
-- `parse_position_comments()` in tree-sitter's cli/src/query_testing.rs at commit 67de9435:
-- - An assertion is a comment (any node whose type contains the comment node type of its language,
--   see COMMENT_NODES, not on the first line) with an arrow, followed by a capture name (`@`
--   optional, `!` prefix for negation). Comments in injected languages count as well.
-- - `^` refers to its own column (only the first `^` counts), `<-` to the start of the comment.
-- - Both refer to the closest line above that does not contain an assertion.
-- Positions are 0-based, columns are byte offsets.
local M = {}

--- Comment node types (default: `'comment'`)
local COMMENT_NODES = {
  markdown = 'html_block',
  haskell = 'haddock',
}

---@class TSTestAssertion
---@field row integer
---@field col integer
---@field capture string expected capture name, without `!`
---@field negated boolean

--- Open `file` in the current window and start Treesitter highlighting.
---@param file string
---@return integer buf
---@return string lang
function M.open(file)
  vim.cmd.edit(vim.fn.fnameescape(file))
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local lang = vim.treesitter.language.get_lang(ft) or ft
  vim.treesitter.start(buf, lang)
  -- Otherwise vim.treesitter.get_captures() returns nothing, and negated assertions pass.
  assert(vim.treesitter.highlighter.active[buf], 'Treesitter highlighting is not active')
  return buf, lang
end

---@param node TSNode
---@param fn fun(node: TSNode)
local function walk(node, fn)
  for i = 0, node:child_count() - 1 do
    walk(assert(node:child(i)), fn)
  end
  fn(node)
end

--- Capture name with optional `!` (negation) and `@` prefixes
local NAME = '!?@?[%w_%-%.]+'

--- Find the assertion in a comment.
---@param text string
---@param col integer start column of the comment
---@return integer? col
---@return string? name
local function parse_comment(text, col)
  local has_left_caret = false
  for i = 1, #text do
    local c = text:sub(i, i)
    if c == '-' and has_left_caret then
      return col, text:sub(i + 1):match(NAME)
    elseif c == '^' then
      return col + i - 1, text:sub(i + 1):match(NAME)
    end
    has_left_caret = c == '<'
  end
end

--- Parse the assertions in the comments of a buffer, including injected languages.
---@param buf integer
---@param lang string
---@return TSTestAssertion[]
function M.parse(buf, lang)
  local parser = assert(vim.treesitter.get_parser(buf, lang))
  parser:parse(true)

  local assertions = {} ---@type TSTestAssertion[]
  local seen = {} ---@type table<string, true>
  parser:for_each_tree(function(tstree, ltree)
    local comment_node = COMMENT_NODES[ltree:lang()] or 'comment'
    walk(tstree:root(), function(node)
      if not node:type():find(comment_node, 1, true) then
        return
      end
      local row, col = node:start()
      if row == 0 then
        return
      end
      local acol, name = parse_comment(vim.treesitter.get_node_text(node, buf), col)
      local key = acol and name and ('%d:%d:%s'):format(row, acol, name)
      if key and not seen[key] then
        seen[key] = true
        assertions[#assertions + 1] = {
          row = row,
          col = acol,
          capture = name:gsub('^!?@?', ''),
          negated = vim.startswith(name, '!'),
        }
      end
    end)
  end)

  -- Assertions from different trees are not in document order.
  table.sort(assertions, function(a, b)
    if a.row ~= b.row then
      return a.row < b.row
    end
    return a.col < b.col
  end)
  local comment_rows = vim.tbl_map(function(a)
    return a.row
  end, assertions) ---@type integer[] rows of the comments with assertions

  -- Refer to the line above, skipping lines with assertions.
  local i = 1
  for _, a in ipairs(assertions) do
    while vim.list_contains(vim.list_slice(comment_rows, i), a.row) do
      a.row = a.row - 1
    end
    while i <= #comment_rows and comment_rows[i] < a.row do
      i = i + 1
    end
  end

  table.sort(assertions, function(a, b)
    if a.row ~= b.row then
      return a.row < b.row
    end
    return a.col < b.col
  end)
  return assertions
end

return M
