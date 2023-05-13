local M = {}

-- Returns the system-specific path separator.
---@return string
function M.get_path_sep()
  return (vim.fn.has('win32') == 1 and not vim.opt.shellslash:get()) and '\\' or '/'
end

-- Returns a function that joins the given arguments with separator. Arguments
-- can't be nil. Example:
--
--[[
  print(M.generate_join(" ")("foo", "bar"))
--]]
--prints "foo bar"
---@param separator string
---@return fun(...: string): string
local function generate_join(separator)
  return function(...)
    return table.concat({ ... }, separator)
  end
end

M.join_path = generate_join(M.get_path_sep())

function M.get_package_path()
  -- Path to this source file, removing the leading '@'
  local source = string.sub(debug.getinfo(1, 'S').source, 2)

  -- Path to the package root
  return vim.fn.fnamemodify(source, ':p:h:h:h')
end

return M
