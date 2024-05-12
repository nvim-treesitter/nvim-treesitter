local api = vim.api

local Log = require('fittencode.log')

local M = {}

function M:new(o)
  o = o or {}
  o.name = 'FittenCodePrompt/Telescope'
  o.priority = 100
  setmetatable(o, self)
  self.__index = self
  return o
end

function M:is_available(filetype)
  return filetype == 'TelescopePrompt'
end

function M:get_name()
  return self.name
end

function M:get_priority()
  return self.priority
end

---@class PromptContextTelescope : PromptContext
---@field telescope_policy string
---@field max_results number

---@param ctx PromptContextTelescope
---@return Prompt?
function M:execute(ctx)
  if not api.nvim_buf_is_valid(ctx.buffer) or ctx.row == nil or ctx.col == nil then
    return
  end

  local filename = 'Telescope.md'

  local row = ctx.row
  local col = ctx.col
  ---@diagnostic disable-next-line: param-type-mismatch
  local content = table.concat(api.nvim_buf_get_text(ctx.buffer, 0, 0, row, col, {}), '\n')

  local prefix = ''

  local action_state = require('telescope.actions.state')
  ctx.telescope_policy = ctx.telescope_policy or 'results'
  ctx.max_results = ctx.max_results or 1000

  if ctx.telescope_policy == 'results' then
    local selection = action_state.get_current_picker(ctx.buffer)
    if selection ~= nil and selection.finder ~= nil and selection.finder.results ~= nil then
      local results = selection.finder.results
      local count = 1
      local ordinals = {}
      for _, v in pairs(results) do
        if count >= ctx.max_results then
          break
        end
        if v.ordinal ~= nil then
          ordinals[#ordinals + 1] = v.ordinal
          count = count + 1
        end
      end
      local list = '# List\n```\n' .. table.concat(ordinals, '\n') .. '\n```\n'
      local query = 'Search from the list above\n' .. content
      prefix = list .. query
    end
  elseif ctx.telescope_policy == 'selected' then
    local selection = action_state.get_selected_entry()
    if selection ~= nil then
      prefix = selection.ordinal .. '\n' .. content
    end
  end

  local suffix = ''

  return {
    name = self.name,
    priority = self.priority,
    filename = filename,
    prefix = prefix,
    suffix = suffix,
    within_the_line = false,
  }
end

return M
