local api = vim.api
local fn = vim.fn
local luv = vim.loop
local ts = vim.treesitter

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
    if string.match(path, '.*/nvim%-treesitter') then
      return path
    end
  end

  return nil, 'Plugin runtime path not found.'
end

function M.get_cache_dir()
  local home = fn.get(fn.environ(), 'HOME')
  local xdg_cache = fn.get(fn.environ(), 'XDG_CACHE_HOME')

  if xdg_cache == 0 then
    xdg_cache = home .. '/.cache'
  end

  if luv.fs_access(xdg_cache, 'RW') then
    return xdg_cache
  elseif luv.fs_access('/tmp', 'RW') then
    return '/tmp'
  end

  return nil, 'Invalid cache rights, $XDG_CACHE_HOME or /tmp should be read/write'
end

return M
