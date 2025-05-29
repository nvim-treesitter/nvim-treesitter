local M = {}

--- @param filename string
--- @return string
function M.read_file(filename)
  local file = assert(io.open(filename, 'r'))
  local r = file:read('*a')
  file:close()
  return r
end

--- @param filename string
--- @param content string
function M.write_file(filename, content)
  local file = assert(io.open(filename, 'w'))
  file:write(content)
  file:close()
end

return M
