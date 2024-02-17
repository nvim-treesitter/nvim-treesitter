local uv = vim.uv

local Log = require('fittencode.log')

---@class Task
---@field row integer
---@field col integer
---@field timestamp integer

---@class TaskScheduler
---@field list table<integer, Task>
---@field threshold? integer
---@field timeout_recycling_timer? uv_timer_t
local TaskScheduler = {}

local MS_TO_NS = 1000000
local DEFAULT_TIMEOUT = 6000 * MS_TO_NS
local DEFAULT_RECYCLING = 1000

function TaskScheduler:new()
  local self = setmetatable({}, { __index = TaskScheduler })
  self.list = {}
  self.threshold = nil
  self.timeout_recycling_timer = nil
  return self
end

function TaskScheduler:setup()
  self.list = {}
  self.timeout_recycling_timer = uv.new_timer()
  if self.timeout_recycling_timer then
    self.timeout_recycling_timer:start(DEFAULT_RECYCLING, DEFAULT_RECYCLING, function()
     self:timeout_recycling()
  end)
  else
    Log.error('Failed to create timeout recycling timer')
  end
end

---@param row integer
---@param col integer
function TaskScheduler:create(row, col)
  local timestamp = uv.hrtime()
  table.insert(self.list, #self.list + 1, { row = row, col = col, timestamp = timestamp })
  Log.debug('Task created; row: ' .. row .. '; col: ' .. col)
  return timestamp
end

---@param task_id integer
function TaskScheduler:schedule_clean(task_id)
  self.threshold = task_id
  if not self.timeout_recycling_timer then
    self:timeout_recycling()
  end
end

---@param task_id integer
---@param row integer
---@param col integer
---@return boolean
function TaskScheduler:match_clean(task_id, row, col)
  local match_found = false
  for i = #self.list, 1, -1 do
    local task = self.list[i]
    if task.timestamp == task_id and task.row == row and task.col == col then
      local ms = string.format('%4d', math.floor((uv.hrtime() - task.timestamp) / MS_TO_NS))
      Log.debug('Task matched; time elapsed: [ ' .. ms .. ' ms ]' .. '; row: ' .. row .. '; col: ' .. col)
      match_found = true
      break
    end
  end
  self:schedule_clean(task_id)
  return match_found
end

---@param timestamp integer
---@return boolean
local function is_timeout(timestamp)
  return uv.hrtime() - timestamp > DEFAULT_TIMEOUT
end

function TaskScheduler:timeout_recycling()
  for i, task in ipairs(self.list) do
    if is_timeout(task.timestamp) or (self.threshold and task.timestamp <= self.threshold) then
      table.remove(self.list, i)
    end
  end
  self.threshold = nil
end

return TaskScheduler
