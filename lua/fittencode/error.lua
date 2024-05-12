---@class Error
---@field code string
---@field msg string

---@class Error
local M = {}

function M:new(tag)
  local o = {
    tag = tag,
    code = nil,
    msg = nil,
  }
  self.__index = self
  return setmetatable(o, self)
end

return M
