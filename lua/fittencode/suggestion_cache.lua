---@class SuggestionPos
---@field row? integer
---@field col? integer

---@class SuggestionCache
---@field lines? string[] @suggestion lines
---@field pos? SuggestionPos @suggestion position
---@field count? integer @suggestion count
local SuggestionCache = {}

function SuggestionCache.new()
  local self = setmetatable({}, { __index = SuggestionCache })
  self.lines = {}
  self.pos = {}
  self.count = 0
  return self
end

-- Flush cache
function SuggestionCache:flush()
  self:update_lines()
  self:update_pos()
end

-- Update suggestion lines
---@param lines string[]|nil @suggestion lines
function SuggestionCache:update_lines(lines)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
end

-- Update suggestion position
---@param row integer|nil @suggestion row
---@param col integer|nil @suggestion col
function SuggestionCache:update_pos(row, col)
  self.pos.row = row
  self.pos.col = col
end

-- Check if the position is equal to the cached position
---@param row integer @suggestion row
---@param col integer @suggestion col
---@return boolean
function SuggestionCache:equal_pos(row, col)
  return self.pos.row == row and self.pos.col == col
end

return SuggestionCache
