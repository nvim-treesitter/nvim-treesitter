local query = require"vim.treesitter.query"

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
  local n = pred[3] - 1
  if node and node:parent() and node:named_child_count() > n then
    return node:named_child(n) == node
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

-- Just avoid some anoying warnings for this directive
query.add_directive('make-range!', function() end)
