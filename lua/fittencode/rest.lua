local uv = vim.uv

local Log = require('fittencode.log')

local M = {}

---@class RestCallbackData
---@field on_completion_request_success function|nil
---@field task_id integer|nil
---@field path string|nil

---@class RestParams
---@field cmd string
---@field args table
---@field data RestCallbackData|nil

---@param params RestParams
---@param on_success function|nil
---@param on_error function|nil
---@param on_exit function|nil
function M.send(params, on_success, on_error, on_exit)
  local cmd = params.cmd
  local args = params.args
  local data = params.data

  local output = ''
  local handle = nil

  local stdout = assert(uv.new_pipe())
  local stderr = assert(uv.new_pipe())

  handle = uv.spawn(cmd, {
    stdio = { nil, stdout, stderr },
    args = args,
  }, function(exit_code, signal)
    if handle == nil then
      Log.error('uv.spawn handle is nil; cmd: {}; args: {}', cmd, args)
      return
    end
    handle:close()
    stdout:close()
    stderr:close()
    local check = assert(uv.new_check())
    check:start(function()
      if not stdout:is_closing() or not stderr:is_closing() then
        return
      end
      check:stop()
      if signal ~= 0 then
        Log.error('uv.spawn signal; cmd: {}; args: {}; signal: {}', cmd, args, signal)
        if on_error then
          vim.schedule(function()
            on_error(signal, output, data)
          end)
        end
      else
        if on_success then
          vim.schedule(function()
            on_success(exit_code, output, data)
          end)
        end
      end
      if on_exit then
        vim.schedule(function()
          on_exit(data)
        end)
      end
    end)
  end)

  ---@param err any
  ---@param chunk string|nil
  local function on_chunk(err, chunk)
    assert(not err, err)
    if chunk then
      output = output .. chunk:gsub('\r\n', '\n')
    end
  end

  uv.read_start(stdout, on_chunk)
  uv.read_start(stderr, on_chunk)
end

return M
