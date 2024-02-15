local uv = vim.uv

local Log = require('fittencode.log')

local M = {}

local MS_TO_NS = 1000000
local DEFAULT_TIMEOUT = 6000 * MS_TO_NS
local DEFAULT_RECYCLING = 1000

M.tasks_list = {}

local timeout_recycling_timer = nil
local fast_clean_stamp = nil

function M.setup()
  M.tasks_list = {}
  timeout_recycling_timer = uv.new_timer()
  timeout_recycling_timer:start(DEFAULT_RECYCLING, DEFAULT_RECYCLING, M.timeout_recycling)
end

function M.create(row, col)
  local timestamp = uv.hrtime()
  table.insert(M.tasks_list, #M.tasks_list + 1, { row = row, col = col, timestamp = timestamp })
  Log.info('Task created; row: ' .. row .. '; col: ' .. col)
  return timestamp
end

function M.mark_clean(task_id)
  fast_clean_stamp = task_id
end

function M.match(task_id, row, col, clean)
  local match_found = false
  for i = #M.tasks_list, 1, -1 do
    local task = M.tasks_list[i]
    if task.timestamp == task_id and task.row == row and task.col == col then
      local ms = string.format('%4d', math.floor((uv.hrtime() - task.timestamp) / MS_TO_NS))
      Log.info('Task matched; time elapsed: [ ' .. ms .. ' ms ]' .. '; row: ' .. row .. '; col: ' .. col)
      match_found = true
      break
    end
  end
  if clean then
    M.mark_clean(task_id)
  end
  return match_found
end

function M.query(task_id)
  for i = #M.tasks_list, 1, -1 do
    local task = M.tasks_list[i]
    if task.timestamp == task_id then
      return task
    end
  end
end

local function is_timeout(timestamp)
  return uv.hrtime() - timestamp > DEFAULT_TIMEOUT
end

function M.timeout_recycling()
  -- Log.info('Timeout recycling; tasks count: [ ' .. #M.tasks_list .. ' ]')
  for i, task in ipairs(M.tasks_list) do
    if is_timeout(task.timestamp) or (fast_clean_stamp and task.timestamp <= fast_clean_stamp) then
      table.remove(M.tasks_list, i)
    end
  end
  fast_clean_stamp = nil
end

return M
