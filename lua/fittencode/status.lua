local uv = vim.uv or vim.loop

local Base = require('fittencode.base')
local Log = require('fittencode.log')

local M = {}

local C = {
  IDLE = 0,
  REQUESTING = 1,
  REQUEST_ERROR = 2,
  NO_MORE_SUGGESTIONS = 3,
  SUGGESTIONS_READY = 4,
}

M.C = C

local current = C.IDLE

local idle_timer = nil
local IDLE_CYCLE = 5000 -- ms

local get_status_message = function(status)
  for k, v in pairs(C) do
    if v == status then
      return k
    end
  end
  return 'UNKNOWN'
end

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
