local Log = require('fittencode.log')

local M = {}

---@class SourceCompletionOptions
---@field enable boolean
---@field engine string
---@field disable_specific_source_completion table

---@class SourceCompletionOptions
local sources_ctx = nil

local builtins = {
  ['cmp'] = function(opts)
    require('fittencode.sources.cmp').setup(opts)
  end,
}

function M.is_available()
  if not sources_ctx.enable then
    return false
  end
  local filetype = vim.bo.filetype
  if vim.tbl_contains(sources_ctx.disable_specific_source_completion.suffixes, filetype) then
    return false
  end
  return true
end

---@param opts? SourceCompletionOptions
function M.setup(opts)
  opts = opts or {}
  sources_ctx = opts
  if not opts.enable then
    return
  end
  local engine = opts.engine
  if builtins[engine] then
    builtins[engine](opts)
  else
    Log.error('Invalid completion engine: {} ', engine)
  end
end

return M
