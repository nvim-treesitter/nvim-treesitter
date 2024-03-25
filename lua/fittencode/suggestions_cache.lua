---@class SuggestionsPos
---@field row? integer
---@field col? integer

---@class SuggestionsCache
---@field private task_id? integer
---@field private generated_text? string[]
---@field private lines? string[]
---@field private pos? SuggestionsPos
---@field private count? integer
local SuggestionsCache = {}

function SuggestionsCache.new()
  local self = setmetatable({}, { __index = SuggestionsCache })
  self.task_id = nil
  self.generated_text = {}
  self.lines = {}
  self.pos = {}
  self.count = 0
  return self
end

function SuggestionsCache:flush()
  self:update()
end

---@param task_id? integer
---@param row? integer
---@param col? integer
---@param lines? string[]
---@param generated_text? string[]
function SuggestionsCache:update(task_id, row, col, lines, generated_text)
  self.task_id = task_id
  self:update_pos(row, col)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
  self.generated_text = generated_text or {}
end

---@param index integer
---@param line string
function SuggestionsCache:update_line(index, line)
  self.lines[index] = line
end

---@return string[]
function SuggestionsCache:get_lines()
  return self.lines
end

---@return string?
function SuggestionsCache:get_line(index)
  return self.lines[index]
end

---@return string?
function SuggestionsCache:remove_line(index)
  return table.remove(self.lines, index)
end

---@return integer
function SuggestionsCache:get_count()
  return self.count
end

---@return string[]?
function SuggestionsCache:get_generated_text()
  return self.generated_text
end

---@param row? integer
---@param col? integer
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

---@return integer?, integer?
function SuggestionsCache:get_pos()
  return self.pos.row, self.pos.col
end

return SuggestionsCache
