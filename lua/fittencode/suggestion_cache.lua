---@class SuggestionPos
---@field row? integer
---@field col? integer

---@class SuggestionCache
---@field lines? string[]
---@field pos? SuggestionPos
---@field count? integer
local SuggestionCache = {}

function SuggestionCache.new(view)
  local self = setmetatable({}, { __index = SuggestionCache })
  self.lines = {}
  self.pos = {}
  self.count = 0
  return self
end

function SuggestionCache:flush()
  self:update_lines()
  self:update_pos()
end

function SuggestionCache:update_lines(lines)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
end

function SuggestionCache:update_pos(row, col)
  self.pos.row = row
  self.pos.col = col
end

function SuggestionCache:equal_pos(row, col)
  return self.pos.row == row and self.pos.col == col
end

return SuggestionCache
