local parsers = require "nvim-treesitter.parsers"
local queries = require "nvim-treesitter.query"
local tsutils = require "nvim-treesitter.ts_utils"
local highlighter = require "vim.treesitter.highlighter"

local function get_first_node_at_line(root, lnum)
  local col = vim.fn.indent(lnum)
  return root:descendant_for_range(lnum - 1, col, lnum - 1, col)
end

local function get_last_node_at_line(root, lnum)
  local col = #vim.fn.getline(lnum) - 1
  return root:descendant_for_range(lnum - 1, col, lnum - 1, col)
end

local function get_matching_prev_sibling(anchor, start, matcher)
  local start_row, start_col = start[1], start[2]
  local node = anchor:descendant_for_range(start_row, start_col, start_row, start_col)
  local pos = 1
  -- TODO: reconsider this 999 limit or do something differently in future.
  --       if anchor has more than 999 children, this would not work.
  while pos < 999 and node and not matcher(node) do
    node = node:prev_sibling()
    pos = pos + 1
  end
  return node, pos
end

local M = {}

local get_indents = tsutils.memoize_by_buf_tick(function(bufnr, root, lang)
  local map = {
    auto = {},
    indent = {},
    indent_end = {},
    dedent = {},
    branch = {},
    ignore = {},
    aligned_indent = {},
  }

  highlighter.active[bufnr].tree:for_each_tree(function(tstree, tree)
    for name, node, metadata in queries.iter_captures(bufnr, "indents", tstree:root(), tree:lang()) do
      map[name][node:id()] = metadata or {}
    end
  end)

  return map
end, {
  -- Memoize by bufnr and lang together.
  key = function(bufnr, root, lang)
    return tostring(bufnr) .. root:id() .. "_" .. lang
  end,
})

---@param lnum number (1-indexed)
function M.get_indent(lnum)
  local parser = parsers.get_parser()
  if not parser or not lnum then
    return -1
  end

  -- get_root_for_position is 0-based.
  local root, _, lang_tree = tsutils.get_root_for_position(lnum - 1, 0, parser)

  -- Not likely, but just in case...
  if not root then
    return 0
  end

  local q = get_indents(vim.api.nvim_get_current_buf(), root, lang_tree:lang())
  local is_empty_line = string.match(vim.fn.getline(lnum), "^%s*$") ~= nil
  local node
  if is_empty_line then
    local prevlnum = vim.fn.prevnonblank(lnum)
    node = get_last_node_at_line(root, prevlnum)
    if q.indent_end[node:id()] then
      node = get_first_node_at_line(root, lnum)
    end
  else
    node = get_first_node_at_line(root, lnum)
  end

  local indent_size = vim.fn.shiftwidth()
  local indent = 0
  if root:start() ~= 0 then
    -- injected tree
    indent = vim.fn.indent(root:start() + 1)
  end

  -- tracks to ensure multiple indent levels are not applied for same line
  local is_processed_by_row = {}

  while node do
    -- do 'autoindent' if not marked as @indent
    if not q.indent[node:id()] and q.auto[node:id()] and node:start() < lnum - 1 and lnum - 1 <= node:end_() then
      return -1
    end

    -- Do not indent if we are inside an @ignore block.
    -- If a node spans from L1,C1 to L2,C2, we know that lines where L1 < line <= L2 would
    -- have their indentations contained by the node.
    if not q.indent[node:id()] and q.ignore[node:id()] and node:start() < lnum - 1 and lnum - 1 <= node:end_() then
      return 0
    end

    local srow, _, erow = node:range()

    local is_processed = false

    if
      not is_processed_by_row[srow]
      and ((q.branch[node:id()] and srow == lnum - 1) or (q.dedent[node:id()] and srow ~= lnum - 1))
    then
      indent = indent - indent_size
      is_processed = true
    end

    -- do not indent for nodes that starts-and-ends on same line and starts on target line (lnum)
    if not is_processed_by_row[srow] and (q.indent[node:id()] and srow ~= erow and ((srow ~= lnum - 1) or q.indent[node:id()].start_at_same_line)) then
      indent = indent + indent_size
      is_processed = true
    end

    if q.aligned_indent[node:id()] and srow ~= erow then
      local metadata = q.aligned_indent[node:id()]
      local opening_delimiter = metadata.delimiter:sub(1, 1)
      local o_delim_node, pos = get_matching_prev_sibling(node, { srow, #vim.fn.getline(srow + 1) - 1 }, function(n)
        return n:type() == opening_delimiter
      end)

      if o_delim_node then
        if pos == 1 then
          -- hanging indent (previous line ended with starting delimiter)
          indent = indent + indent_size * 1
        else
          local _, o_scol = o_delim_node:start()
          local aligned_indent = math.max(indent, 0) + o_scol
          if indent > 0 then
            indent = aligned_indent
          else
            indent = aligned_indent + 1 -- extra space for starting delimiter
          end
          is_processed = true
        end
      end
    end

    is_processed_by_row[srow] = is_processed_by_row[srow] or is_processed

    node = node:parent()
  end

  return indent
end

local indent_funcs = {}

function M.attach(bufnr)
  indent_funcs[bufnr] = vim.bo.indentexpr
  vim.bo.indentexpr = "nvim_treesitter#indent()"
  vim.api.nvim_command("au Filetype " .. vim.bo.filetype .. " setlocal indentexpr=nvim_treesitter#indent()")
end

function M.detach(bufnr)
  vim.bo.indentexpr = indent_funcs[bufnr]
end

return M
