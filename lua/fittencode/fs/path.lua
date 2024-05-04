local Base = require('fittencode.base')

local M = {}

---@return string
function M.nt_sep()
  return '\\'
end

---@return string
function M.kernel_sep()
  return '/'
end

---@param s string
---@return string
function M.to_nt(s)
  return s:gsub(M.kernel_sep(), M.nt_sep())[1]
end

---@param s string
---@return string
function M.to_kernel(s)
  return s:gsub(M.nt_sep(), M.kernel_sep())[1]
end

---@param s string
---@return string
function M.to_native(s)
  return Base.is_windows() and M.to_nt(s) or M.to_kernel(s)
end

return M
