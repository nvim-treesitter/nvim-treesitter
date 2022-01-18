local parsers = require "nvim-treesitter.parsers"
local queries = require "nvim-treesitter.query"
local tsutils = require "nvim-treesitter.ts_utils"

local M = {}

local get_indents = tsutils.memoize_by_buf_tick(function(bufnr, root, lang)
  local map = {
    auto = {},
    indent = {},
    dedent = {},
    branch = {},
    ignore = {},
  }

  for name, node in queries.iter_captures(bufnr, "indents", root, lang) do
    map[name][node:id()] = true
  end

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
    local col = #vim.fn.getline(prevlnum) - 1
    node = root:descendant_for_range(prevlnum - 1, col, prevlnum - 1, col)
  else
    local col = vim.fn.indent(lnum)
    node = root:descendant_for_range(lnum - 1, col, lnum - 1, col)
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
    if not is_processed_by_row[srow] and (q.indent[node:id()] and srow ~= erow and srow ~= lnum - 1) then
      indent = indent + indent_size
      is_processed = true
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
