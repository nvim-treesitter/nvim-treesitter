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
  for _, path in pairs(api.nvim_list_runtime_paths()) do
    local last_segment = vim.fn.fnamemodify(path, ":t")
    local penultimate_segment = vim.fn.fnamemodify(path, ":t:t")
    if last_segment == "nvim-treesitter" or (last_segment == "" and penultimate_segment == "nvim-treesitter") then
      return path
    end
  end

  return nil, 'Plugin runtime path not found.'
end

function M.get_cache_dir()
  local home = fn.get(fn.environ(), 'HOME')
  local cache_dir = fn.stdpath('data')

  if cache_dir == 0 then
    cache_dir = home .. '/.cache'
  end

  if luv.fs_access(cache_dir, 'RW') then
    return cache_dir
  elseif luv.fs_access('/tmp', 'RW') then
    return '/tmp'
  end

  return nil, 'Invalid cache rights, $XDG_CACHE_HOME or /tmp should be read/write'
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

return M
