local query = vim.treesitter.query

local predicates = {
  ---@param match TSQueryMatch
  ---@param pred string[]
  ---@param any boolean
  ---@return boolean
  ['kind-eq'] = function(match, pred, any)
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

---@param match TSQueryMatch
---@param pred string[]
---@return boolean|nil
query.add_predicate('kind-eq?', function(match, _, _, pred)
  return predicates['kind-eq'](match, pred, false)
end, { force = true })

---@param match TSQueryMatch
---@param pred string[]
---@return boolean|nil
query.add_predicate('any-kind-eq?', function(match, _, _, pred)
  return predicates['kind-eq'](match, pred, true)
end, { force = true })
