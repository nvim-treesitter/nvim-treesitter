local api = vim.api

local Log = require('fittencode.log')

local M = {}

local NAME = 'FittenCodePrompt/Actions'

function M:new(o)
  o = o or {}
  o.name = NAME
  o.priority = 100
  setmetatable(o, self)
  self.__index = self
  return o
end

function M:is_available(type)
  return type:match('^' .. NAME)
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
  if (not ctx.solved_prefix and not ctx.solved_content) and (not api.nvim_buf_is_valid(ctx.buffer) or ctx.range == nil) then
    return
  end

  local filename = ''
  if ctx.buffer then
    api.nvim_buf_get_name(ctx.buffer)
  end

  local within_the_line = false

  local prefix = ''
  if ctx.solved_prefix then
    prefix = ctx.solved_prefix
  else
    -- FIXME: Improve prompt construction! full content with line:col info?
    ---@diagnostic disable-next-line: param-type-mismatch
    local content = ''
    if ctx.solved_content then
      content = ctx.solved_content
    else
      content = table.concat(api.nvim_buf_get_text(ctx.buffer, ctx.range[1], 0, ctx.range[2], 0, {}), '\n')
    end
    local map_action_prompt = {
      DocumentCode = 'Document the code above',
      EditCode = ctx.prompt,
      ExplainCode = 'Explain the code above',
      FindBugs = 'Find bugs in the code above',
      GenerateUnitTest = 'Generate a unit test for the code above',
    }
    local key = ctx.prompt_ty:sub(#NAME + 2)
    local prompt = ctx.prompt or map_action_prompt[key]
    prefix = '```\n' .. content .. '\n```\n' .. prompt .. ':\n'
  end
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
