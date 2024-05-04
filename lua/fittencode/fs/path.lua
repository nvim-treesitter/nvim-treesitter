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
  local nt, _ = s:gsub(M.kernel_sep(), M.nt_sep())
  return nt
end

---@param s string
---@return string
function M.to_kernel(s)
  local kernel, _ = s:gsub(M.nt_sep(), M.kernel_sep())
  return kernel
end

---@param s string
---@return string
function M.to_native(s)
  return Base.is_windows() and M.to_nt(s) or M.to_kernel(s)
end

return M
