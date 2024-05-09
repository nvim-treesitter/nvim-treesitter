local api = vim.api

local Base = require('fittencode.base')
local Log = require('fittencode.log')

local M = {}

---@class Prompt
---@field name string
---@field priority integer
---@field filename string
---@field prefix string
---@field suffix string
---@field within_the_line boolean

---@class PromptContext
---@field window? integer
---@field buffer? integer
---@field filetype? string
---@field row? integer
---@field col? integer
---@field range? table
---@field prompt? string
---@field solved_prefix? string
---@field solved_content? string

---@class PromptProvider
---@field is_available fun(self, string?): boolean
---@field get_name fun(self): string
---@field get_priority fun(self): integer
---@field execute fun(self, PromptContext): Prompt?

---@class PromptFilter
---@field count integer
---@field sort? fun(a: Prompt, b: Prompt): boolean

---@type PromptProvider[]
local providers = {}

---@param provider PromptProvider
function M.register_prompt_provider(provider)
  providers[#providers + 1] = provider
  table.sort(providers, function(a, b)
    return a:get_priority() > b:get_priority()
  end)
end

local function register_builtin_prompt_providers()
  M.register_prompt_provider(require('fittencode.prompt_providers.default'):new())
  M.register_prompt_provider(require('fittencode.prompt_providers.telescope'):new())
  M.register_prompt_provider(require('fittencode.prompt_providers.actions'):new())
end

function M.setup()
  register_builtin_prompt_providers()
end

---@param ctx PromptContext
---@param filter? PromptFilter
---@return Prompt[]?
function M.get_prompts(ctx, filter)
  if not ctx or not ctx.filetype then
    Log.error('Invalid prompt context')
    return
  end
  filter = filter or {}
  local prompts = {}
  for _, provider in ipairs(providers) do
    if provider:is_available(ctx.filetype) then
      prompts[#prompts + 1] = provider:execute(ctx)
      if filter.count == 1 then
        break
      end
    end
  end
  if filter.sort then
    table.sort(prompts, function(a, b)
      return filter.sort(a, b)
    end)
  end
  return prompts
end

function M.get_prompt_one(opts)
  return M.get_prompts(opts, { count = 1 })[1]
end

---@return PromptContext
function M.get_current_prompt_ctx()
  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)
  local row, col = Base.get_cursor(window)
  return {
    window = window,
    buffer = buffer,
    filetype = vim.bo.filetype,
    row = row,
    col = col,
    range = nil
  }
end

return M
