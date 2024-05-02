local api = vim.api

local Base = require('fittencode.base')
local Log = require('fittencode.log')

local M = {}

---@class Source
---@field name string
---@field priority integer
---@field filename string
---@field prefix string
---@field suffix string
---@field within_the_line boolean

---@class SourceContext
---@field window? integer
---@field buffer? integer
---@field filetype? string
---@field row? integer
---@field col? integer

---@class SourceProvider
---@field is_available fun(self, string?): boolean
---@field get_name fun(self): string
---@field get_priority fun(self): integer
---@field execute fun(self, SourceContext): Source?

---@class SourceFilter
---@field count integer
---@field sort? fun(a: Source, b: Source): boolean

---@type SourceProvider[]
local providers = {}

---@param provider SourceProvider
function M.register_source_provider(provider)
  providers[#providers + 1] = provider
  table.sort(providers, function(a, b)
    return a:get_priority() > b:get_priority()
  end)
end

local function register_builtin_source_providers()
  M.register_source_provider(require('fittencode.source_providers.default'):new())
  M.register_source_provider(require('fittencode.source_providers.telescope'):new())
end

function M.setup()
  register_builtin_source_providers()
end

---@param ctx SourceContext
---@param filter? SourceFilter
---@return Source[]?
function M.get_sources(ctx, filter)
  if not ctx.filetype then
    return
  end
  filter = filter or {}
  local sources = {}
  for _, provider in ipairs(providers) do
    if provider:is_available(ctx.filetype) then
      sources[#sources + 1] = provider:execute(ctx)
      if filter.count == 1 then
        break
      end
    end
  end
  if filter.sort then
    table.sort(sources, function(a, b)
      return filter.sort(a, b)
    end)
  end
  return sources
end

---@return Source?
function M.get_current_source()
  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)
  local row, col = Base.get_cursor(window)
  local sources = M.get_sources({
    window = window,
    buffer = buffer,
    filetype = vim.bo.filetype,
    row = row,
    col = col,
  }, { count = 1 })
  return sources and sources[1]
end

return M
