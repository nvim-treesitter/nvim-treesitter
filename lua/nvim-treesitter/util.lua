local uv = vim.loop

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

--- Recursively delete a directory
--- @param name string
function M.delete(name)
  --- @diagnostic disable-next-line:param-type-mismatch
  local stat = uv.fs_lstat(name)
  if not stat then
    return
  end

  if stat.type == 'directory' then
    for f in vim.fs.dir(name) do
      M.delete(vim.fs.joinpath(name, f))
    end
    uv.fs_rmdir(name)
    return
  end

  uv.fs_unlink(name)
end

return M
