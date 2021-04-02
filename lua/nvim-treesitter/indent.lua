local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local tsutils = require'nvim-treesitter.ts_utils'

local M = {}

-- TODO(kiyan): move this in tsutils and document it
local function get_node_at_line(root, lnum)
  for node in root:iter_children() do
    local srow, _, erow = node:range()
    if srow == lnum then return node end

    if node:child_count() > 0 and srow < lnum and lnum <= erow then
      return get_node_at_line(node, lnum)
    end
  end
end

local function node_fmt(node)
  if not node then return nil end
  return tostring(node)
end

local get_indents = tsutils.memoize_by_buf_tick(function(bufnr, root, lang)
  local get_map = function(capture)
    local matches = queries.get_capture_matches(bufnr, capture, 'indents', root, lang) or {}
    local map = {}
    for _, node in ipairs(matches) do
      map[tostring(node)] = true
    end
    return map
  end

  return {
    indents = get_map('@indent.node'),
    branches = get_map('@branch.node'),
    returns = get_map('@return.node'),
    ignores = get_map('@ignore.node'),
  }
end, {
  -- Memoize by bufnr and lang together.
  key = function(bufnr, _, lang)
    return tostring(bufnr) .. '_' .. lang
  end
})

function M.get_indent(lnum)
  local parser = parsers.get_parser()
  if not parser or not lnum then return -1 end

  local root, _, lang_tree = tsutils.get_root_for_position(lnum, 0, parser)

  -- Not likely, but just in case...
  if not root then return 0 end

  local q = get_indents(vim.api.nvim_get_current_buf(), root, lang_tree:lang())
  local node = get_node_at_line(root, lnum-1)

  local indent = 0
  local indent_size = vim.fn.shiftwidth()

  -- to get correct indentation when we land on an empty line (for instance by typing `o`), we try
  -- to use indentation of previous nonblank line, this solves the issue also for languages that
  -- do not use @branch after blocks (e.g. Python)
  if not node then
    local prevnonblank = vim.fn.prevnonblank(lnum)
    if prevnonblank ~= lnum then
      local prev_node = get_node_at_line(root, prevnonblank-1)
      -- get previous node in any case to avoid erroring
      while not prev_node and prevnonblank-1 > 0 do
        prevnonblank = vim.fn.prevnonblank(prevnonblank-1)
        prev_node = get_node_at_line(root, prevnonblank-1)
      end

      -- nodes can be marked @return to prevent using them
      if prev_node and not q.returns[node_fmt(prev_node)] then
        local row = prev_node:start()
        local end_row = prev_node:end_()

        -- if the previous node is being constructed (like function() `o` in lua), or line is inside the node
        -- we indent one more from the start of node, else we indent default
        -- NOTE: this doesn't work for python which behave strangely
        if prev_node:has_error() or lnum <= end_row then
          return vim.fn.indent(row + 1) + indent_size
        end
        return vim.fn.indent(row + 1)
      end
    end
  end

  -- if the prevnonblank fails (prev_node wraps our line) we need to fall back to taking
  -- the first child of the node that wraps the current line, or the wrapper itself
  if not node then
    local wrapper = root:descendant_for_range(lnum-1, 0, lnum-1, -1)
    node = wrapper:child(0) or wrapper
    if q.indents[node_fmt(wrapper)] ~= nil and wrapper ~= root then
      indent = indent_size
    end
  end

  while node and q.branches[node_fmt(node)] do
    node = node:parent()
  end

  local first = true
  local prev_row = node:start()

  while node do
    -- do not indent if we are inside an @ignore block
    if q.ignores[node_fmt(node)] and node:start() < lnum-1 and node:end_() > lnum-1 then
      return -1
    end

    -- do not indent the starting node, do not add multiple indent levels on single line
    local row = node:start()
    if not first and q.indents[node_fmt(node)] and prev_row ~= row then
      indent = indent + indent_size
      prev_row = row
    end

    node = node:parent()
    first = false
  end

  return indent
end

local indent_funcs = {}

function M.attach(bufnr)
  indent_funcs[bufnr] = vim.bo.indentexpr
  vim.bo.indentexpr = 'nvim_treesitter#indent()'
  vim.api.nvim_command("au Filetype "..vim.bo.filetype.." setlocal indentexpr=nvim_treesitter#indent()")
end

function M.detach(bufnr)
  vim.bo.indentexpr = indent_funcs[bufnr]
end

return M
