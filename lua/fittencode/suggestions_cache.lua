---@class SuggestionsPos
---@field row? integer
---@field col? integer

---@class SuggestionsCache
---@field lines? string[]
---@field pos? SuggestionsPos
---@field count? integer
local SuggestionsCache = {}

function SuggestionsCache.new()
  local self = setmetatable({}, { __index = SuggestionsCache })
  self.generated_text = {}
  self.lines = {}
  self.pos = {}
  self.count = 0
  return self
end

function SuggestionsCache:flush()
  self:update_lines()
  self:update_pos()
end

---@param lines string[]|nil
function SuggestionsCache:update_lines(lines, generated_text)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
  self.generated_text = generated_text or {}
end

---@param row integer|nil
---@param col integer|nil
function SuggestionsCache:update_pos(row, col)
  self.pos.row = row
  self.pos.col = col
end

---@param row integer
---@param col integer
---@return boolean
function SuggestionsCache:equal_pos(row, col)
  return self.pos.row == row and self.pos.col == col
end

return SuggestionsCache
