local api = vim.api
local fn = vim.fn
local luv = vim.loop

local M = {}

function M.setup_commands(mod, commands)
  for command_name, def in pairs(commands) do
    local call_fn = string.format("lua require'nvim-treesitter.%s'.commands.%s.run(<f-args>)", mod, command_name)
    local parts = vim.tbl_flatten({
        "command!",
        def.args,
        command_name,
        call_fn,
      })
    api.nvim_command(table.concat(parts, " "))
  end
end

function M.get_package_path()
  -- Path to this source file, removing the leading '@'
  local source = string.sub(debug.getinfo(1, 'S').source, 2)

  -- Path to the package root
  return fn.fnamemodify(source, ":p:h:h:h")
end

function M.get_cache_dir()
  local cache_dir = fn.stdpath('data')

  if luv.fs_access(cache_dir, 'RW') then
    return cache_dir
  elseif luv.fs_access('/tmp', 'RW') then
    return '/tmp'
  end

  return nil, 'Invalid cache rights, '..fn.stdpath('data')..' or /tmp should be read/write'
end

-- Gets a property at path
-- @param tbl the table to access
-- @param path the '.' separated path
-- @returns the value at path or nil
function M.get_at_path(tbl, path)
  local segments = vim.split(path, '.', true)
  local result = tbl

  for _, segment in ipairs(segments) do
    if type(result) == 'table' then
      result = result[segment]
    end
  end

  return result
end

-- Prints a warning message
-- @param text the text message
function M.print_warning(text)
  api.nvim_command(string.format([[echohl WarningMsg | echo "%s" | echohl None]], text))
end

function M.set_jump()
  vim.cmd "normal! m'"
end

function M.index_of(tbl, obj)
  for i, o in ipairs(tbl) do
    if o == obj then
      return i
    end
  end
end

return M
