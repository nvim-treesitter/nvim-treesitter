-- Runs in the Nvim under test (see tests/query/{highlights,injections}.lua).
--
-- Parses assertion comments like `parse_position_comments()` in tree-sitter's
-- crates/cli/src/query_testing.rs (at commit c049ecb8):
-- - An assertion is a comment (any node whose type contains the comment node type of its language,
--   see COMMENT_NODES, not on the first line) with an arrow, followed by an optional `!` (negation)
--   and a capture name (`@` optional). Comments in injected languages count as well.
-- - `^` refers to its own column, `^^^` to the columns it spans, `<-` to the start of the comment.
-- - Both refer to the closest line above that does not contain an assertion and is long enough to
--   contain the column (so empty lines are skipped).
-- Positions are 0-based, columns are byte offsets (tree-sitter uses graphemes).
local M = {}

--- Comment node types (default: `'comment'`)
local COMMENT_NODES = {
  markdown = 'html_block',
  haskell = 'haddock',
}

---@class TSTestAssertion
---@field row integer
---@field col integer first column
---@field len integer number of columns
---@field capture string expected capture name
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

--- Find the assertion in a comment.
---@param text string
---@param col integer start column of the comment
---@return integer? col
---@return integer? len
---@return boolean? negated
---@return string? name
local function parse_comment(text, col)
  local has_left_caret = false
  for i = 1, #text do
    local c = text:sub(i, i)
    local arrow_end, len ---@type integer?, integer?
    if c == '-' and has_left_caret then
      arrow_end, len = i, 1
    elseif c == '^' then
      col, len = col + i - 1, #text:match('^%^+', i)
      arrow_end = i + len - 1
    end
    if arrow_end then
      local rest = text:sub(arrow_end + 1)
      local negated = rest:find('^%s*!') ~= nil
      rest = rest:gsub('^%s*!', '', 1)
      return col, len, negated, rest:match('[%w_%-%.]+')
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
      if not node:type():lower():find(comment_node, 1, true) then
        return
      end
      local row, col = node:start()
      if row == 0 then
        return
      end
      local acol, len, negated, name = parse_comment(vim.treesitter.get_node_text(node, buf), col)
      local key = name and ('%d:%d:%d:%s:%s'):format(row, acol, len, negated, name)
      if key and not seen[key] then
        seen[key] = true
        assertions[#assertions + 1] = {
          row = row,
          col = assert(acol),
          len = assert(len),
          capture = name,
          negated = negated == true,
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

  -- Refer to the line above, skipping lines with assertions or too short for the column.
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
  local i = 1
  for _, a in ipairs(assertions) do
    local row = a.row
    while
      vim.list_contains(vim.list_slice(comment_rows, i), a.row)
      -- like tree-sitter, which counts the line terminator
      or #lines[a.row + 1] + 1 <= a.col
    do
      assert(a.row > 0, ('no line for the assertion "%s" in line %d'):format(a.capture, row + 1))
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
