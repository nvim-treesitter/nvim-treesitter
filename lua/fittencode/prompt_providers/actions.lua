local api = vim.api

local Log = require('fittencode.log')

local M = {}

function M:new(o)
  o = o or {}
  o.name = 'FittenCodeAction'
  o.priority = 100
  setmetatable(o, self)
  self.__index = self
  return o
end

function M:is_available(ft)
  self.ft = ft
  return ft:match('^FittenCodeAction')
end

function M:get_name()
  return self.name
end

function M:get_priority()
  return self.priority
end

---@param ctx PromptContext
---@return Prompt?
function M:execute(ctx)
  if not api.nvim_buf_is_valid(ctx.buffer) or ctx.range == nil then
    return
  end

  local filename = api.nvim_buf_get_name(ctx.buffer)
  filename = filename or ''

  local within_the_line = false
  -- FIXME: Improve prompt construction!
  ---@diagnostic disable-next-line: param-type-mismatch
  local content = table.concat(api.nvim_buf_get_text(ctx.buffer, ctx.range[1], 0, ctx.range[2], 0, {}), '\n')
  local map_action_prompt = {
    DocumentCode = 'Document the code above',
    EditCode = ctx.prompt,
    ExplainCode = 'Explain the code above',
    FindBugs = 'Find all bugs in the code above',
    GenerateUnitTest = 'Generate a unit test for the code above',
  }
  local ftkey = self.ft:sub(#'FittenCodeAction' + 1)
  local prompt = ctx.prompt or map_action_prompt[ftkey]
  local prefix = '```\n' .. content .. '\n```\n' .. prompt .. ':\n'
  local suffix = ''

  Log.debug('Action prompt: {}', prefix)

  return {
    name = self.name,
    priority = self.priority,
    filename = filename,
    prefix = prefix,
    suffix = suffix,
    within_the_line = within_the_line,
  }
end

return M
