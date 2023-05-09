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

-- Checks whether a parser for {lang} is available
---@param lang string
---@return boolean
-- TODO(clason): inline?
function M.has_parser(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
end

-- Gets the language of a given buffer
---@param bufnr number? or current buffer
---@return string
function M.get_buf_lang(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local ft = vim.api.nvim_buf_get_option(bufnr, 'ft')
  local result = vim.treesitter.language.get_lang(ft)
  if result then
    return result
  else
    ft = vim.split(ft, '.', { plain = true })[1]
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

return M
