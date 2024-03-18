---@class SuggestionsPos
---@field row? integer
---@field col? integer

---@class SuggestionsCache
---@field lines? string[] @suggestions lines
---@field pos? SuggestionsPos @suggestions start position
---@field count? integer @suggestions count
local SuggestionsCache = {}

function SuggestionsCache.new()
  local self = setmetatable({}, { __index = SuggestionsCache })
  self.replaced_lines = {}
  self.lines = {}
  self.pos = {}
  self.count = 0
  return self
end

-- Flush cache
function SuggestionsCache:flush()
  self:update_lines()
  self:update_pos()
end

-- Update suggestions lines
---@param lines string[]|nil @suggestions lines
function SuggestionsCache:update_lines(lines, replaced_lines)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
  self.replaced_lines = replaced_lines or {}
end

-- Update suggestions start position
---@param row integer|nil @suggestions row
---@param col integer|nil @suggestions col
function SuggestionsCache:update_pos(row, col)
  self.pos.row = row
  self.pos.col = col
end

-- Check if the position is equal to the cached position
---@param row integer @suggestions row
---@param col integer @suggestions col
---@return boolean
function SuggestionsCache:equal_pos(row, col)
  return self.pos.row == row and self.pos.col == col
end

return SuggestionsCache
