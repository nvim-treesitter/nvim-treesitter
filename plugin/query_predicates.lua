local query = vim.treesitter.query

local predicates = {
  ---@param nodes TSNode[]
  ---@param pred string[]
  ---@param any boolean
  ---@return boolean
  ['has-type'] = function(nodes, pred, any)
    if not nodes or #nodes == 0 then
      return true
    end

    local types = { unpack(pred, 3) }
    for _, node in ipairs(nodes) do
      local match = vim.list_contains(types, node:type())
      if any and match then
        return true
      elseif not any and not match then
        return false
      end
    end
    return not any
  end,
}

-- register custom predicates (overwrite existing; needed for CI)

---@param match TSMatch
---@param pred string[]
---@return boolean|nil
query.add_predicate('has-type?', function(match, _, _, pred)
  local nodes = match[pred[2]]
  if type(nodes) ~= 'table' then
    -- Check for old versions of Nvim that map capture IDs to a single node
    nodes = { nodes }
  end
  return predicates['has-type'](nodes, pred, false)
end, {
  force = true,
  correct = true,
})

---@param match TSMatch
---@param pred string[]
---@return boolean|nil
query.add_predicate('any-has-type?', function(match, _, _, pred)
  local nodes = match[pred[2]]
  if type(nodes) ~= 'table' then
    -- Check for old versions of Nvim that map capture IDs to a single node
    nodes = { nodes }
  end
  return predicates['has-type'](nodes, pred, true)
end, {
  force = true,
  correct = true,
})

-- register custom directives

local mimetype_aliases = {
  ['importmap'] = 'json',
  ['module'] = 'javascript',
  ['application/ecmascript'] = 'javascript',
  ['text/ecmascript'] = 'javascript',
}

---@param match (TSNode|nil)[]
---@param _ string
---@param bufnr integer
---@param pred string[]
---@return boolean|nil
query.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local nodes = match[id]
  if type(nodes) ~= 'table' then
    nodes = { nodes }
  end

  if not nodes or #nodes == 0 then
    return
  end

  assert(#nodes == 1, '#set-lang-from-mimetype! does not support captures on multiple nodes')
  local node = nodes[1]
  local type_attr_value = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] })
  local configured = mimetype_aliases[type_attr_value]
  if configured then
    metadata['injection.language'] = configured
  else
    local parts = vim.split(type_attr_value, '/', {})
    metadata['injection.language'] = parts[#parts]
  end
end, {
  force = true,
  correct = true,
})
