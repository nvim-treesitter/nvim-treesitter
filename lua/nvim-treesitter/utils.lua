local luv = vim.loop

local M = {}

-- Wrapper around vim.notify with common options set.
---@param msg string
---@param log_level number|nil
---@param opts table|nil
function M.notify(msg, log_level, opts)
  local default_opts = { title = 'nvim-treesitter' }
  vim.notify(msg, log_level, vim.tbl_extend('force', default_opts, opts or {}))
end

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
function M.generate_join(separator)
  return function(...)
    return table.concat({ ... }, separator)
  end
end

M.join_path = M.generate_join(M.get_path_sep())

M.join_space = M.generate_join(' ')

---@param dir string
---@param create_err string
---@param writeable_err string
---@return string|nil, string|nil
function M.create_or_reuse_writable_dir(dir, create_err, writeable_err)
  create_err = create_err or M.join_space("Could not create dir '", dir, "': ")
  writeable_err = writeable_err or M.join_space("Invalid rights, '", dir, "' should be read/write")
  -- Try creating and using parser_dir if it doesn't exist
  if not luv.fs_stat(dir) then
    local ok, error = pcall(vim.fn.mkdir, dir, 'p', '0755')
    if not ok then
      return nil, M.join_space(create_err, error)
    end

    return dir
  end

  -- parser_dir exists, use it if it's read/write
  if luv.fs_access(dir, 'RW') then
    return dir
  end

  -- parser_dir exists but isn't read/write, give up
  return nil, M.join_space(writeable_err, dir, "'")
end

function M.get_package_path()
  -- Path to this source file, removing the leading '@'
  local source = string.sub(debug.getinfo(1, 'S').source, 2)

  -- Path to the package root
  return vim.fn.fnamemodify(source, ':p:h:h:h')
end

function M.get_cache_dir()
  local cache_dir = vim.fn.stdpath('data')

  if luv.fs_access(cache_dir, 'RW') then
    return cache_dir
  elseif luv.fs_access('/tmp', 'RW') then
    return '/tmp'
  end

  return nil,
    M.join_space('Invalid cache rights,', vim.fn.stdpath('data'), 'or /tmp should be read/write')
end

---@return string|nil
function M.ts_cli_version()
  if vim.fn.executable('tree-sitter') == 1 then
    local handle = io.popen('tree-sitter -V')
    if not handle then
      return
    end
    local result = handle:read('*a')
    handle:close()
    return vim.split(result, '\n')[1]:match('[^tree%psitter ].*')
  end
end

return M
