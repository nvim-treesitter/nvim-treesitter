local ActionsEngine = require('fittencode.engines.actions')
local InlineEngine = require('fittencode.engines.inline')

local M = {}

function M.setup()
  ActionsEngine.setup()
  InlineEngine.setup()
end

---@return integer, integer
function M.get_status()
  return InlineEngine.get_status(), ActionsEngine.get_status()
end

return M
