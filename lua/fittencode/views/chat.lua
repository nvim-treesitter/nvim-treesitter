---@class Chat
---@field win? integer
---@field buffer? integer
---@field text? string
---@field show function
---@field append_text function

local M = {}

function M:new()
  local o = {
    text = ''
  }
  self.__index = self
  return setmetatable(o, self)
end

function M:show()
end

function M:append_text(text)
  self.text = self.text .. text
end

return M
