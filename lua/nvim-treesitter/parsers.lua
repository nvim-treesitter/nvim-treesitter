local api = vim.api
local ts = vim.treesitter

local M = {}

function M.has_parser(lang)
  local lang = lang or api.nvim_buf_get_option(0, 'filetype')
  return #api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
end

function M.get_parser(bufnr, lang)
  if M.has_parser() then
    local buf = bufnr or api.nvim_get_current_buf()
    local lang = lang or api.nvim_buf_get_option(buf, 'ft')
    if not M[buf] then
      M[buf] = {}
    end
    if not M[buf][lang] then
      M[buf][lang] = ts.get_parser(buf, lang)
    end
    return M[buf][lang]
  end
end

return M
