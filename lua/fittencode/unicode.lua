local M = {}

function M.calculate_utf8_index(line)
  local index = {}
  for i = 1, #line do
    table.insert(index, #index + 1, vim.str_utf_start(line, i))
  end
  return index
end

function M.calculate_utf8_index_tbl(lines)
  local index = {}
  for i, line in ipairs(lines) do
    local line_index = M.calculate_utf8_index(line)
    index[i] = line_index
  end
  return index
end

local function find_zero(tbl, start_index)
  for i = start_index, #tbl do
    if tbl[i] == 0 then
      return i
    end
  end
end

function M.find_first_character(s, tbl, start_index)
  if #tbl == 0 then
    return nil
  end

  local v1 = find_zero(tbl, start_index)
  assert(v1 == start_index)
  if v1 == nil then
    -- Invalid UTF-8 sequence
    return nil
  end

  local v2 = find_zero(tbl, v1 + 1)
  if v2 == nil then
    v2 = #tbl
  else
    v2 = v2 - 1
  end

  local char = string.sub(s, v1, v2)
  return char, { v1, v2 }
end

return M
