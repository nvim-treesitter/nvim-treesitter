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

--- Set injection.language metadata from node text
---
--- If text does not yield an installed parser name, treat as `filetype`
--- and look up corresponding parser.
---
--- Custom aliases can be added via |vim.treesitter.language.register()|.
---@param match (TSNode|nil)[]
---@param _ string
---@param bufnr integer
---@param pred string[]
---@return boolean|nil
query.add_directive('inject-language!', function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local node = match[id]
  if not node then
    return
  end

  -- TODO(clason): replace by refactored `ts.has_parser` API
  local has_parser = function(lang)
    return vim._ts_has_language(lang)
      or #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
  end

  local alias = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] })
  if not alias then
    return
  elseif has_parser(alias) then
    metadata['injection.language'] = alias
  else
    local lang = vim.treesitter.language.get_lang(alias)
    if lang and has_parser(lang) then
      metadata['injection.language'] = lang
    end
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

-- Trim blank lines from end of the region
-- Arguments are the captures to trim.
---@param match (TSNode|nil)[]
---@param _ string
---@param bufnr integer
---@param pred string[]
---@param metadata table
---TODO(clason): upstream
query.add_directive('trim!', function(match, _, bufnr, pred, metadata)
  local node = match[pred[2]]
  if not node then
    return
  end

  local start_row, start_col, end_row, end_col = node:range()

  -- Don't trim if region ends in middle of a line
  if end_col ~= 0 then
    return
  end

  while true do
    -- As we only care when end_col == 0, always inspect one line above end_row.
    local end_line = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)[1]

    if end_line ~= '' then
      break
    end

    end_row = end_row - 1
  end

  -- If this produces an invalid range, we just skip it.
  if start_row < end_row or (start_row == end_row and start_col <= end_col) then
    metadata.range = { start_row, start_col, end_row, end_col }
  end
end, true)
