local uv = vim.uv

local M = {}

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
      print('handle is nil')
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
        -- TODO: Handle error
        if on_error then
          vim.schedule(function()
            on_error(signal, output)
          end)
        end
      else
        if on_success then
          vim.schedule(function()
            on_success(exit_code, output)
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

  local function on_output(err, data)
    assert(not err, err)
    if data then
      output = output .. data:gsub('\r\n', '\n')
    end
  end

  uv.read_start(stdout, on_output)
  uv.read_start(stderr, on_output)
end

return M
