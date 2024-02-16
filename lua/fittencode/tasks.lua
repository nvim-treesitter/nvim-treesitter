local uv = vim.uv

local Log = require('fittencode.log')

local M = {}

local MS_TO_NS = 1000000
local DEFAULT_TIMEOUT = 6000 * MS_TO_NS
local DEFAULT_RECYCLING = 1000

---@class Task
---@field row integer
---@field col integer
---@field timestamp integer

---@type table<integer, Task>
M.tasks_list = {}

local timeout_recycling_timer = nil
local fast_clean_stamp = nil

function M.setup()
  M.tasks_list = {}
  timeout_recycling_timer = uv.new_timer()
  if timeout_recycling_timer then
    timeout_recycling_timer:start(DEFAULT_RECYCLING, DEFAULT_RECYCLING, M.timeout_recycling)
  else
    Log.error('Failed to create timeout recycling timer')
  end
end

---@param row integer
---@param col integer
function M.create(row, col)
  local timestamp = uv.hrtime()
  table.insert(M.tasks_list, #M.tasks_list + 1, { row = row, col = col, timestamp = timestamp })
  Log.debug('Task created; row: ' .. row .. '; col: ' .. col)
  return timestamp
end

---@param task_id integer
local function schedule_clean(task_id)
  fast_clean_stamp = task_id
  if not timeout_recycling_timer then
    M.timeout_recycling()
  end
end

---@param task_id integer
---@param row integer
---@param col integer
---@return boolean
function M.match_clean(task_id, row, col)
  local match_found = false
  for i = #M.tasks_list, 1, -1 do
    local task = M.tasks_list[i]
    if task.timestamp == task_id and task.row == row and task.col == col then
      local ms = string.format('%4d', math.floor((uv.hrtime() - task.timestamp) / MS_TO_NS))
      Log.debug('Task matched; time elapsed: [ ' .. ms .. ' ms ]' .. '; row: ' .. row .. '; col: ' .. col)
      match_found = true
      break
    end
  end
  schedule_clean(task_id)
  return match_found
end

---@param timestamp integer
---@return boolean
local function is_timeout(timestamp)
  return uv.hrtime() - timestamp > DEFAULT_TIMEOUT
end

function M.timeout_recycling()
  -- Log.debug('Timeout recycling; tasks count: [ ' .. #M.tasks_list .. ' ]')
  for i, task in ipairs(M.tasks_list) do
    if is_timeout(task.timestamp) or (fast_clean_stamp and task.timestamp <= fast_clean_stamp) then
      table.remove(M.tasks_list, i)
    end
  end
  fast_clean_stamp = nil
end

return M
