local Base = require('fittencode.base')
local Log = require('fittencode.log')

---@class Status
---@field C StatusCodes
---@field filters table<integer, boolean>
---@field ready_idle boolean
---@field tag string
---@field current integer
---@field idle_timer uv_timer_t
---@field IDLE_CYCLE integer
---@field update function
---@field get_current function
local M = {}

---@alias StatusCodes table<string, integer>

---@type StatusCodes
local C = {
  IDLE = 0,
  GENERATING = 1,
  NETWORK_ERROR = 2,
  NO_MORE_SUGGESTIONS = 3,
  SUGGESTIONS_READY = 4,
}

M.C = C

function M:new(opts)
  local obj = {
    ready_idle = opts.ready_idle or false,
    tag = opts.tag or 'Status',
    current = C.IDLE,
    ---@type uv_timer_t
    idle_timer = nil,
    IDLE_CYCLE = 5000, -- ms
    filters = { C.NETWORK_ERROR, C.NO_MORE_SUGGESTIONS }
  }
  if obj.ready_idle then
    table.insert(obj.filters, #obj.filters + 1, C.SUGGESTIONS_READY)
  end
  self.__index = self
  return setmetatable(obj, self)
end

---@param status integer
local function get_status_name(status)
  return Base.tbl_key_by_value(C, status)
end

---@param status integer
function M:update(status)
  local name = get_status_name(status)
  if not name then
    Log.error('Invalid status code: {}', status)
    return
  end
  if status ~= self.current then
    self.current = status
    -- Force `lualine` to update statusline
    -- vim.cmd('redrawstatus')
    Log.debug('{} status updated to {}', self.tag, name)
  end
  Base.debounce(self.idle_timer, function()
    if vim.tbl_contains(self.filters, self.current) then
      self:update(C.IDLE)
    end
  end, self.IDLE_CYCLE)
end

function M:get_current()
  return self.current
end

return M
