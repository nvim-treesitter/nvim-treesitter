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

query.add_predicate('has-ancestor?', function(match, pattern, bufnr, pred)
  if not valid_args("has-ancestor?", pred, 2, true) then return end

  local node = match[pred[2]]
  local ancestor_type = pred[3]
  if not node then return true end

  node = node:parent()
  while node do
    if node:type() == ancestor_type then
      return true
    end
    node = node:parent()
  end
  return false
end)

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

-- Just avoid some anoying warnings for this predicate
query.add_predicate('set!', function() return true end)
query.add_predicate('make-range!', function() return true end)
