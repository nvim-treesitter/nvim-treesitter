local ActionsEngine = require('fittencode.engines.actions')
local InlineEngine = require('fittencode.engines.inline')

local M = {}

function M.setup()
  ActionsEngine.setup()
  InlineEngine.setup()
end

return M
