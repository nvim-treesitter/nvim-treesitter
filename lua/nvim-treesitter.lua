local api = vim.api
local parsers = require'nvim-treesitter.parsers'

local M = {}

-- This function sets up everythin needed for a given language
-- this is the main interface through the plugin
function M.setup(lang)
  if parsers.has_parser(lang) then
  end
end

return M
