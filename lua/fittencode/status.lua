local Base = require('fittencode.base')
local Log = require('fittencode.log')

local M = {}

---@alias StatusCodes table<string, integer>

---@type StatusCodes
local C = {
  IDLE = 0,
  REQUESTING = 1,
  REQUEST_ERROR = 2,
  NO_MORE_SUGGESTIONS = 3,
  SUGGESTIONS_READY = 4,
}

M.C = C

local current = C.IDLE

---@type uv_timer_t
local idle_timer = nil

---@type integer
local IDLE_CYCLE = 5000 -- ms

---@param status integer
local get_status_message = function(status)
  return Base.tbl_key_by_value(C, status, 'UNKNOWN')
end

---@param status integer
M.update = function(status)
  if status ~= current then
    current = status
    Log.debug('STATUS updated to {}', get_status_message(status))
  end
  Base.debounce(idle_timer, function()
    if vim.tbl_contains({ C.REQUEST_ERROR, C.NO_MORE_SUGGESTIONS }, current) then
      M.update(C.IDLE)
    end
  end, IDLE_CYCLE)
end

M.get_current = function()
  return current
end

return M
