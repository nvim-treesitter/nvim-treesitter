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
  local check_function = M[string.gsub('check_'..pred[1], "%?$", '')]
  if check_function then
    return check_function(query, match, pred)
  else
    return true
  end
end

function M.check_negated_predicate(query, match, pred)
  local check_function = M[string.gsub('check_'..string.sub(pred[1], #"not-" + 1), "%?$", '')]
  if check_function then
    return not check_function(query, match, pred)
  else
    return true
  end
end

function M.check_first(query, match, pred)
  if #pred ~= 2 then error("first? must have exactly one argument!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    return get_nth_child(node:parent(), 0) == node
  end
end

function M.check_last(query, match, pred)
  if #pred ~= 2 then error("first? must have exactly one argument!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    local num_children = node:parent():named_child_count()
    return get_nth_child(node:parent(), num_children - 1) == node
  end
end

function M.check_nth(query, match, pred)
  if #pred ~= 3 then error("nth? must have exactly two arguments!") end
  local node = get_node(query, match, pred[2])
  if node and node:parent() then
    return get_nth_child(node:parent(), pred[3] - 1) == node
  end
end

return M
