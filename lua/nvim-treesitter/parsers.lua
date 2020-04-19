local api = vim.api
local ts = vim.treesitter

local M = {}

function M.has_parser(lang)
  local lang = lang or api.nvim_buf_get_option(0, 'filetype')
  return #api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
end

function M.get_parser(bufnr)
  if M.has_parser() then
    local buf = bufnr or api.nvim_get_current_buf()
    if not M[buf] then
      M[buf] = ts.get_parser(buf)
    end
    return M[buf]
  end
end

return M
