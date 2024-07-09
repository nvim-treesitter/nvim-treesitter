local install = require "nvim-treesitter.install"
local utils = require "nvim-treesitter.utils"
local info = require "nvim-treesitter.info"
local configs = require "nvim-treesitter.configs"
local statusline = require "nvim-treesitter.statusline"

-- Registers all query predicates
require "nvim-treesitter.query_predicates"

local M = {}

---@param opts? TSConfig # Optional config to pass to `configs.setup`. (If omitted or `nil`, `configs.setup` will not be called.)
function M.setup(opts)
  utils.setup_commands("install", install.commands)
  utils.setup_commands("info", info.commands)
  utils.setup_commands("configs", configs.commands)
  configs.init()
  if opts then configs.setup(opts) end
end

M.define_modules = configs.define_modules
M.statusline = statusline.statusline

return M
