local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Log = require('fittencode.log')

local source = {}

function source:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function source:get_position_encoding_kind()
  return 'utf-8'
end

-- function source:get_keyword_pattern()
--   return '.*'
-- end

function source:get_trigger_characters()
  return { ' ', '.', '#', '-' }
end

---Invoke completion (required).
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response:lsp.CompletionResponse|nil)
function source:complete(params, callback)
  if not Engine.preflight() then
    callback()
    return
  end
  local row, col = Base.get_cursor()
  Engine.generate_one_stage(row, col, true, function(suggestions)
    local cursor_before_line = params.context.cursor_before_line
    Log.debug('Cursor before line: {}', cursor_before_line)
    local line = params.context.cursor.line
    local character = params.context.cursor.character
    Log.debug('Context cursor line: {}, character: {}', line, character)
    local lsp_items = Engine.convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
    Log.debug('LSP items: {}', lsp_items)
    callback(lsp_items)
  end)
end

return source
