local uv = vim.uv or vim.loop

local Log = require('fittencode.log')

local M = {}

---@class RestParams
---@field cmd string
---@field args table
---@field data any

-- Rest API, send request to server and get response
-- * If success, call on_success with exit_code, output, and data
-- * If error, call on_error with signal, output, and data
-- * If exit, call on_exit with data
---@param params RestParams
---@param on_success function|nil
---@param on_error function|nil
---@param on_exit function|nil
function M.send(params, on_success, on_error, on_exit)
  local cmd = params.cmd
  local args = params.args
  local data = params.data

  local output = ''
  local error = ''
  local handle = nil

  local stdout = assert(uv.new_pipe())
  local stderr = assert(uv.new_pipe())

  handle = uv.spawn(cmd, {
    stdio = { nil, stdout, stderr },
    args = args,
  }, function(exit_code, signal)
    if handle == nil then
      Log.error('RESTAPI uv.spawn handle is nil; cmd: {}; args: {}', cmd, args)
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
        Log.error('RESTAPI uv.spawn signal; cmd: {}; args: {}; signal: {}; error: {}', cmd, args, signal, error)
        if on_error then
          vim.schedule(function()
            on_error(signal, error, data)
          end)
        end
      else
        if on_success then
          Log.debug('RESTAPI uv.spawn exit; code: {}', exit_code)
          vim.schedule(function()
            on_success(exit_code, output, error, data)
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

  -- Process stdout and stderr chunks
  ---@param err any
  ---@param chunk string|nil
  local function on_chunk(err, chunk, is_stderr)
    assert(not err, err)
    local process_chunk = function(c)
      return c:gsub('\r\n', '\n')
    end
    if chunk then
      if is_stderr then
        error = error .. process_chunk(chunk)
      else
        output = output .. process_chunk(chunk)
      end
    end
  end

  uv.read_start(stdout, function(err, chunk)
    on_chunk(err, chunk)
  end)
  uv.read_start(stderr, function(err, chunk)
    on_chunk(err, chunk, true)
  end)
end

return M
