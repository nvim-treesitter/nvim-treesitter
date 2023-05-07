local api = vim.api
local parsers = require('nvim-treesitter.parsers')

local M = {}

function M.install_info()
  local max_len = 0
  for _, ft in pairs(parsers.available_parsers()) do
    if #ft > max_len then
      max_len = #ft
    end
  end

  local parser_list = parsers.available_parsers()
  table.sort(parser_list)
  for _, lang in pairs(parser_list) do
    local is_installed = #api.nvim_get_runtime_file('parser/' .. lang .. '.so', false) > 0
    api.nvim_out_write(lang .. string.rep(' ', max_len - #lang + 1))
    if is_installed then
      api.nvim_out_write('[✓] installed\n')
    elseif pcall(vim.treesitter.inspect_lang, lang) then
      api.nvim_out_write('[✗] not installed (but still loaded. Restart Neovim!)\n')
    else
      api.nvim_out_write('[✗] not installed\n')
    end
  end
end

---@return string[]
function M.installed_parsers()
  local installed = {}
  for _, p in pairs(parsers.available_parsers()) do
    if parsers.has_parser(p) then
      table.insert(installed, p)
    end
  end
  return installed
end

return M
