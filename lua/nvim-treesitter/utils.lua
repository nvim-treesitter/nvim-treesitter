-- Utils collection for nvim-treesitter
local api = vim.api
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

function M.has_parser(ft)
  local ft = ft or api.nvim_buf_get_option(0, 'filetype')
  return #api.nvim_get_runtime_file('parser/' .. ft .. '.*', false) > 0
end

function M.get_parser(bufnr, ft)
  if M.has_parser() then
    local buf = bufnr or api.nvim_get_current_buf()
    local ft = ft or api.nvim_buf_get_option(buf, 'ft')
    if not M[buf] then
      M[buf] = {}
    end
    if not M[buf][ft] then
      M[buf][ft] = ts.get_parser(buf, ft)
    end
    return M[buf][ft]
  end
end

return M
