local Error = require('fittencode.error')

---@class NetworkError : Error
---@field url string

---@class NetworkError
local M = Error:new('NetworkError')

return M
