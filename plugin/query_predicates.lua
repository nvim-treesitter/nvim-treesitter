local query = vim.treesitter.query

local predicates = {
  ---@param match TSMatch
  ---@param pred string[]
  ---@param any boolean
  ---@return boolean
  ['has-type'] = function(match, pred, any)
    local nodes = match[pred[2]]
    if not nodes or #nodes == 0 then
      return true
    end

    local types = { unpack(pred, 3) }
    for _, node in ipairs(nodes) do
      local res = vim.list_contains(types, node:type())
      if any and res then
        return true
      elseif not any and not res then
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
  return predicates['has-type'](match, pred, false)
end, {
  force = true,
  all = true,
})

---@param match TSMatch
---@param pred string[]
---@return boolean|nil
query.add_predicate('any-has-type?', function(match, _, _, pred)
  return predicates['has-type'](match, pred, true)
end, {
  force = true,
  all = true,
})

-- register custom directives

local mimetype_aliases = {
  ['importmap'] = 'json',
  ['module'] = 'javascript',
  ['application/ecmascript'] = 'javascript',
  ['text/ecmascript'] = 'javascript',
}

---@param match TSMatch
---@param _ string
---@param bufnr integer
---@param pred string[]
---@return boolean|nil
query.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local nodes = match[id]
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
  all = true,
})
