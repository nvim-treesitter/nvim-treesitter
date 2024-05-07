---@class SuggestionsCache
---@field private task_id? integer
---@field private lines? string[]
---@field private row? integer
---@field private col? integer
---@field private count? integer
local SuggestionsCache = {}

function SuggestionsCache.new()
  local self = setmetatable({}, { __index = SuggestionsCache })
  self.task_id = nil
  self.lines = {}
  self.row = nil
  self.col = nil
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
function SuggestionsCache:update(task_id, row, col, lines)
  self.task_id = task_id
  self:update_cursor(row, col)
  lines = lines or {}
  self.lines = lines
  self.count = vim.tbl_count(lines)
end

---@param index integer
---@param line? string
function SuggestionsCache:update_line(index, line)
  if line == nil then
    self:remove_line(index)
    return
  end
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

---@param row? integer
---@param col? integer
function SuggestionsCache:update_cursor(row, col)
  self.row = row
  self.col = col
end

---@param row integer
---@param col integer
---@return boolean
function SuggestionsCache:equal_cursor(row, col)
  return self.row == row and self.col == col
end

---@return integer?, integer?
function SuggestionsCache:get_cursor()
  return self.row, self.col
end

return SuggestionsCache
