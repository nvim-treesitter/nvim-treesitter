local utils = require'nvim-treesitter.utils'

local M = {}

local function get_nth_child(node, n)
  if node:named_child_count() > n then
    return node:named_child(n)
  end
end

local function get_node(query, match, pred_item)
  return utils.get_at_path(match, query.captures[pred_item]..'.node')
end

function M.check_predicate(query, match, pred)
  local check_function = M[pred[1]]
  if check_function then
    return check_function(query, match, pred)
  else
    return true
  end
end

function M.check_negated_predicate(query, match, pred)
  local check_function = M[string.sub(pred[1], #"not-" + 1)]
  if check_function then
    return not check_function(query, match, pred)
  else
    return true
  end
end

M['first?'] = function (query, match, pred)
  if #pred ~= 2 then error("first? must have exactly one argument!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    return get_nth_child(node:parent(), 0) == node
  end
end

M['last?'] = function (query, match, pred)
  if #pred ~= 2 then error("first? must have exactly one argument!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    local num_children = node:parent():named_child_count()
    return get_nth_child(node:parent(), num_children - 1) == node
  end
end

 M['nth?'] = function(query, match, pred)
  if #pred ~= 3 then error("nth? must have exactly two arguments!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    return get_nth_child(node:parent(), pred[3] - 1) == node
  end
end

M['has_ancestor?'] = function(query, match, pred)
  if #pred ~= 3 then error("has-ancestor? must have exactly two arguments!") end
  local node = get_node(query, match, pred[2])
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
end

return M
