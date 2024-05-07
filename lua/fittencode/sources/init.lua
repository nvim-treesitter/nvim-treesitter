local Config = require('fittencode.config')
local Log = require('fittencode.log')

local M = {}

---@class SourceCompletionOptions
---@field enable boolean
---@field engine string
---@field disable_specific_source_completion table

local builtins = {
  ['cmp'] = function()
    require('fittencode.sources.cmp').setup()
  end,
}

function M.is_available()
  if not Config.options.source_completion.enable then
    return false
  end
  local filetype = vim.bo.filetype
  if vim.tbl_contains(Config.options.source_completion.disable_specific_source_completion.suffixes, filetype) then
    return false
  end
  return true
end

local function make_engine(engine)
  if builtins[engine] then
    builtins[engine]()
  else
    Log.error('Invalid completion engine: {} ', engine)
  end
end

function M.setup()
  if not Config.options.source_completion.enable then
    return
  end
  make_engine(Config.options.source_completion.engine)
end

return M
