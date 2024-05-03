local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Log = require('fittencode.log')

---@class CmpSource
---@field trigger_characters string[]
local source = {}

---@return string[]
local function get_trigger_characters()
  local chars = {}
  for i = 32, 126 do
    chars[#chars + 1] = string.char(i)
  end
  chars[#chars + 1] = ' '
  chars[#chars + 1] = '\n'
  chars[#chars + 1] = '\r'
  chars[#chars + 1] = '\r\n'
  chars[#chars + 1] = '\t'
  return chars
end

---@param o? CmpSource
---@return CmpSource
function source:new(o)
  o = o or {}
  o.trigger_characters = get_trigger_characters()
  setmetatable(o, self)
  self.__index = self
  return o
end

---Return whether this source is available in the current context or not (optional).
---@return boolean
function source:is_available()
  return Engine.is_source_enabled()
end

---@return string
function source:get_position_encoding_kind()
  return 'utf-8'
end

---@return string[]
function source:get_trigger_characters()
  return self.trigger_characters
end

---@alias lsp.CompletionResponse lsp.CompletionList|lsp.CompletionItem[]

-- Use `get_word` so that the word is the same as in `core.confirm`
-- https://github.com/hrsh7th/nvim-cmp/pull/1860
---@param suggestions string
---@return lsp.CompletionResponse?
local function convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
  cursor_before_line = cursor_before_line or ''
  local LABEL_LIMIT = 80
  local label = cursor_before_line .. suggestions
  if #label > LABEL_LIMIT then
    label = string.sub(label, 1, LABEL_LIMIT)
  end
  label = label:gsub('\n', '<\\n>')
  local items = {}
  table.insert(items, {
    label = label,
    word = label,
    textEdit = {
      range = {
        start = { line = line, character = character },
        ['end'] = { line = line, character = character },
      },
      newText = suggestions,
    },
    documentation = {
      kind = 'markdown',
      value = '```' .. vim.bo.ft .. '\n' .. cursor_before_line .. suggestions .. '\n```',
    },
    insertTextMode = 1,
    cmp = {
      kind_text = 'FittenCode',
    },
  })
  return { items = items, isIncomplete = false }
end

-- Invoke completion (required).
-- The `callback` function must always be called.
---@param request cmp.SourceCompletionApiParams
---@param callback fun(response:lsp.CompletionResponse|nil)
function source:complete(request, callback)
  local row, col = Base.get_cursor()
  Engine.generate_one_stage(row, col, true, 0, function(suggestions)
    if not suggestions then
      callback()
      return
    end
    suggestions = table.concat(suggestions, '\n')
    local cursor_before_line = request.context.cursor_before_line:sub(request.offset)
    local line = request.context.cursor.line
    local character = request.context.cursor.character
    local info = {
      triggerCharacter = request.completion_context.triggerCharacter,
      cursor_before_line = cursor_before_line,
      line = line,
      character = character,
      reason = request.option.reason,
    }
    Log.debug('Source(cmp) request: {}', info)
    local response = convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
    Log.debug('LSP CompletionResponse: {}', response)
    callback(response)
  end, function()
    callback()
  end)
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
  Engine.reset()
  -- Log.debug('Execute completion item: {}', completion_item)
  callback(completion_item)
end

return source
