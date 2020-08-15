local query = require"vim.treesitter.query"

local function error(str)
  vim.api.nvim_err_writeln(str)
end

query.add_predicate("nth?", function(match, pattern, bufnr, pred)
  if #pred ~= 3 then
    error("nth? must hav exactly two arguments")
    return
  end

  local node = match[pred[2]]
  local n = pred[3] - 1
  if node and node:parent() and node:named_child_count() > n then
    return node:named_child(n) == node
  end

  return false
end)

query.add_predicate('has-ancestor?', function(match, pattern, bufnr, pred)
  if #pred ~= 3 then error("has-ancestor? must have exactly two arguments!") return end

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
  if #pred < 3 then error("is? must have at least two arguments!") return end

  -- Avoid circular dependencies
  local locals = require"nvim-treesitter.locals"
  local node = match[pred[2]]
  local types = {unpack(pred, 3)}

  if not node then return true end

  local _, _, kind = locals.find_definition(node, bufnr)

  return vim.tbl_contains(types, kind)
end)
