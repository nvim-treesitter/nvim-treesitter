local query = require"vim.treesitter.query"
local ts_utils = require"nvim-treesitter/ts_utils"

local function error(str)
  vim.api.nvim_err_writeln(str)
end

local function valid_args(name, pred, count, strict_count)
  local arg_count = #pred - 1

  if strict_count then
    if arg_count ~= count then
      error(string.format("%s must have exactly %d arguments", name, count))
      return false
    end
  elseif arg_count < count then
    error(string.format("%s must have at least %d arguments", name, count))
    return false
  end

  return true
end

query.add_predicate("nth?", function(match, pattern, bufnr, pred)
  if not valid_args("nth?", pred, 2, true) then return end

  local node = match[pred[2]]
  local n = pred[3]
  if node and node:parent() and node:parent():named_child_count() > n then
    return node:parent():named_child(n) == node
  end

  return false
end)

local function has_ancestor(match, pattern, bufnr, pred)
  if not valid_args(pred[1], pred, 2) then return end

  local node = match[pred[2]]
  local ancestor_types = {unpack(pred, 3)}
  if not node then return true end

  local just_direct_parent = pred[1]:find('has-parent', 1, true)

  node = node:parent()
  while node do
    if vim.tbl_contains(ancestor_types, node:type()) then
      return true
    end
    if just_direct_parent then
      node = nil
    else
      node = node:parent()
    end
  end
  return false
end

query.add_predicate('has-ancestor?', has_ancestor)

query.add_predicate('has-parent?', has_ancestor)

query.add_predicate('is?', function(match, pattern, bufnr, pred)
  if not valid_args("is?", pred, 2) then return end

  -- Avoid circular dependencies
  local locals = require"nvim-treesitter.locals"
  local node = match[pred[2]]
  local types = {unpack(pred, 3)}

  if not node then return true end

  local _, _, kind = locals.find_definition(node, bufnr)

  return vim.tbl_contains(types, kind)
end)

query.add_predicate('has-type?', function(match, pattern, bufnr, pred)
  if not valid_args(pred[1], pred, 2) then return end

  local node = match[pred[2]]
  local types = {unpack(pred, 3)}

  if not node then return true end

  return vim.tbl_contains(types, node:type())
end)

local function get_content_nodes(ids, match, data)
  if #ids > 0 then
    local nodes_or_ranges = {}

    for _, id in ipairs(ids) do
      table.insert(nodes_or_ranges, match[id])
    end

    return nodes_or_ranges
  end

  return data.content
end

-- Injects a language at each provided capture node.
-- All given nodes are parsed in the same context.
-- Note, unlike `combined`, this is per match, not per pattern.
-- TODO: Give this a test run and maybe move it up stream.
-- ```scheme
-- ((binary_expression
--   left: (template_string) @_first
--   right: (template_string) @_second)
--  (#inject-at! @_first @_second))
-- ```
--
-- ```javascript
-- const myString = `some embedded js` + `more embedded js`
--                  ^                ^   ^                ^
-- ```
query.add_directive('combine!', function(match, _, _, pred, data)
  data.content = data.content or {}

  for _, match_id in ipairs({unpack(pred, 2)}) do
    local node = match[match_id]

    if node then
      table.insert(data.content, {node:range()})
    end
  end
end)

-- Injects a language at all sibling nodes of a specific of the target node.
-- If a type is not provided then the type of the target node will be used.
-- ```
-- (recipe_line
--   ((shell_code)+ @_code
--    (#inject-each! @_code)))
-- ```
query.add_directive('combine-each!', function(match, _, _, pred, data)
  local target_node = match[pred[2]]

  if not target_node then return end

  local sibling_type = pred[3] or target_node:type()
  local parent_node = target_node:parent()

  if not parent_node then return end

  data.content = data.content or {}

  for i = 0, parent_node:named_child_count() - 1, 1 do
    local child_node = parent:named_child(i)

    if child_node and child_node:type() == sibling_type then
      table.insert(data.content, {child_node:range()})
    end
  end
end)

-- Offsets each content range or node by the provided offsets.
-- This is the same as the `offset!` directive in core neovim, except
-- this will operate on each content node that configured through a previous directive.
-- TODO: Upstream this if/when these are composable and stable.
query.add_directive('offset-each!', function(match, _, _, pred, data)
  local match_ids = {}
  local nodes_or_ranges = get_content_nodes({unpack(pred, 6)}, match, data)
  local new_ranges = {}

  for _, node_or_range in ipairs(nodes_or_ranges) do
    local start_row, start_col, end_row, end_col = ts_utils.get_node_range(node_or_range)

    local start_row_offset = pred[2] or 0
    local start_col_offset = pred[3] or 0
    local end_row_offset = pred[4] or 0
    local end_col_offset = pred[5] or 0

    start_row = start_row + start_row_offset
    start_col = start_col + start_col_offset
    end_row = end_row + end_row_offset
    end_col = end_col + end_col_offset

    -- If this produces an invalid range, we just skip it.
    if start_row < end_row or (start_row == end_row and start_col <= end_col) then
      table.insert(new_ranges, {start_row, start_col, end_row, end_col})
    end
  end

  data.content = new_ranges
end)

-- Strips content from the start and end of each line of the content.
-- If captures are provided, it will use those captures for the node ranges,
-- or else `contents` list will be used (injections).
-- The result is a list of ranges attach to the metadata table as `contents`.
--
-- Start patterns are automatically prefixed with `^` and end patterns with `$`.
-- Here is an example using language injection. Take the following code.
--
-- ///
-- /// some code you want to highlight
-- ///
--
-- (comment
--   (#set! "language" "coollang")
--   (#strip! "///\s*" ""))
query.add_directive('strip!', function(match, _, bufnr, pred, data)
  local start_pattern = pred[2] ~= "" and ('^' .. pred[2]) or nil
  local end_pattern = pred[3] ~= "" and (pred[2] .. '$') or nil
  local captures = {unpack(pred, 4)}
  local nodes_or_ranges = {}

  if #captures > 0 then
    for _, id in ipairs(captures) do
      table.insert(nodes_or_ranges, match[id])
    end
  elseif type(data.content) == 'table' then
    nodes_or_ranges = data.content
  end

  local results = {}

  for _, node_or_range in ipairs(nodes_or_ranges) do
    local range = {ts_utils.get_node_range(node_or_range)}
    local lines = ts_utils.get_node_text(range, bufnr)

    for i, line in ipairs(lines) do
      local row = i + range[1]
      local _, start_close = start_pattern and string.find(line, start_pattern)
      local end_open, end_close = end_pattern and string.find(line, end_pattern)
      local open = 0
      local close = #line

      if i == 1 then
        open = range[2]
        close = open + #line
      elseif i == #lines then
        close = #line
      end

      if start_close then
        open = start_close
      end

      if end_open then
        close = end_open
      end

      table.insert({ row, open, row, close })
    end
  end

  data.content = results
end)

-- Just avoid some annoying warnings for this directive
query.add_directive('make-range!', function() end)

