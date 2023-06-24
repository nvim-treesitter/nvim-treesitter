local query = vim.treesitter.query

-- register custom predicates (overwrite existing; needed for CI)

---@param match (TSNode|nil)[]
---@param pred string[]
---@return boolean|nil
query.add_predicate('has-type?', function(match, _, _, pred)
  local node = match[pred[2]]
  if not node then
    return true
  end

  local types = { unpack(pred, 3) }
  return vim.list_contains(types, node:type())
end, true)

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
  local node = match[id]
  if not node then
    return
  end

  local type_attr_value = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] })
  local configured = mimetype_aliases[type_attr_value]
  if configured then
    metadata['injection.language'] = configured
  else
    local parts = vim.split(type_attr_value, '/', {})
    metadata['injection.language'] = parts[#parts]
  end
end, true)

query.add_directive('downcase!', function(match, _, bufnr, pred, metadata)
  local text, key, value ---@type string|string[], string, string|integer
  local id = pred[2]

  if #pred == 3 then
    -- (#downcase! @capture "key")
    key = pred[3]
    value = metadata[id][key]
  else
    -- (#downcase! "key")
    key = id
    value = metadata[key]
  end

  if type(value) == 'string' then
    text = value
  else
    local node = match[value]
    text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ''
  end

  if #pred == 3 then
    metadata[id][key] = string.lower(text)
  else
    metadata[key] = string.lower(text)
  end
end, true)
