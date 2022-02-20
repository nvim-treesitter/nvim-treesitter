local query = vim.treesitter.query

-- Just avoid some annoying warnings for this directive
query.add_directive("make-range!", function() end)

query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local text, key, value

  if #pred == 3 then
    -- (#downcase! @capture "key")
    key = pred[3]
    value = metadata[pred[2]][key]
  else
    -- (#downcase! "key")
    key = pred[2]
    value = metadata[key]
  end

  if type(value) == "string" then
    text = value
  else
    local node = match[value]
    text = query.get_node_text(node, bufnr) or ""
  end

  if #pred == 3 then
    metadata[pred[2]][key] = string.lower(text)
  else
    metadata[key] = string.lower(text)
  end
end)

local function is_one_line(range)
  return range[1] == range[3]
end

local function is_range_empty_or_invalid(range)
  if range[3] < range[1] or (is_one_line(range) and range[4] <= range[2]) then
    return true
  end

  return false
end

local function make_subranges_between_children_like(node, predicate)
  local content = { { node:range() } }

  for child in node:iter_children() do
    if predicate(child) then
      local child_range = { child:range() }
      local last_content_range = content[#content]
      local first_part = { last_content_range[1], last_content_range[2], child_range[1], child_range[2] }
      local second_part = { child_range[3], child_range[4], last_content_range[3], last_content_range[4] }
      if is_range_empty_or_invalid(first_part) then
        if not is_range_empty_or_invalid(second_part) then
          content[#content] = second_part
        end
      elseif is_range_empty_or_invalid(second_part) then
        content[#content] = first_part
      else
        content[#content] = first_part
        content[#content + 1] = second_part
      end
    end
  end

  return content
end

query.add_directive("inject_without_children!", function(
  match,
  _, --[[ pattern ]]
  _, --[[ bufnr ]]
  predicate,
  metadata
)
  local node = match[predicate[2]]

  metadata.content = make_subranges_between_children_like(node, function(child)
    return child:named()
  end)
end)

query.add_directive("inject_without_any_children!", function(
  match,
  _, --[[ pattern ]]
  _, --[[ bufnr ]]
  predicate,
  metadata
)
  local node = match[predicate[2]]

  metadata.content = make_subranges_between_children_like(node, function(_)
    return true
  end)
end)
