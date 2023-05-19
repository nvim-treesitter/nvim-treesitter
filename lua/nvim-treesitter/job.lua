-- Interface with Neovim job control and provide a simple job sequencing structure
local uv = vim.loop
local a = require('nvim-treesitter.async')

local M = { JobResult = {}, Opts = {} }

--- @class JobResult
--- @field exit_code integer
--- @field signal integer | string
--- @field stdout string[]
--- @field stderr string[]

--- @class JobOpts
--- @field cwd  string
--- @field timeout  integer
--- @field env  string[]
--- @field on_stderr  fun(_: string)
--- @field on_stdout  fun(_: string)

--- @param cmd string
--- @param options table
local function trace(cmd, options)
  --- TBD
end

--- Wrapper for vim.loop.spawn. Takes a command, options, and callback just like
--- vim.loop.spawn, but ensures that all output from the command has been
--- flushed before calling the callback.
--- @param cmd string
--- @param options uv.aliases.spawn_options
--- @param callback fun(exit_code: integer, signal: integer|string)
local function spawn(cmd, options, callback)
  local handle --- @type uv_process_t?
  local timer --- @type uv_timer_t
  trace(cmd, options)
  handle = uv.spawn(cmd, options, function(exit_code, signal)
    ---@cast handle -nil

    handle:close()
    if timer then
      timer:stop()
      timer:close()
    end

    callback(exit_code, signal)
  end)

  --- @type integer?
  local timeout = options.timeout

  if timeout then
    timer = assert(uv.new_timer())
    timer:start(timeout, 0, function()
      timer:stop()
      timer:close()
      if handle and handle:is_active() then
        -- log.warn('Killing ' .. cmd .. ' due to timeout!')
        handle:kill('sigint')
        handle:close()
        for _, pipe in
          ipairs(options.stdio --[[@as uv_pipe_t[] ]])
        do
          pipe:close()
        end
        callback(-9999, 'sigint')
      end
    end)
  end
end

--- Main exposed function for the jobs module. Takes a task and options and
--- returns an async function that will run the task with the given opts via
--- vim.loop.spawn
--- @param task string|string[]
--- @param opts JobOpts
--- @param callback fun(_: JobResult)
--- @type fun(task: string|string[], opts: JobOpts): JobResult
M.run = a.wrap(function(task, opts, callback)
  local stdout_data = {}
  local stderr_data = {}

  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  if type(task) == 'string' then
    local shell = os.getenv('SHELL') or vim.o.shell
    local minus_c = shell:find('cmd.exe$') and '/c' or '-c'
    task = { shell, minus_c, task }
  end

  spawn(task[1], {
    args = { unpack(task, 2) },
    stdio = { nil, stdout, stderr },
    cwd = opts.cwd,
    timeout = opts.timeout and 1000 * opts.timeout or nil,
    env = opts.env,
    hide = true,
  }, function(exit_code, signal)
    callback({
      exit_code = exit_code,
      signal = signal,
      stdout = stdout_data,
      stderr = stderr_data,
    })
  end)

  for kind, pipe in pairs({ stdout = stdout, stderr = stderr }) do
    if pipe then
      pipe:read_start(function(err, data)
        if kind == 'stderr' and opts.on_stderr and data then
          opts.on_stderr(data)
        end
        if kind == 'stdout' and opts.on_stdout and data then
          opts.on_stdout(data)
        end
        -- if err then
        --   log.error(err)
        -- end
        if data ~= nil then
          local output = kind == 'stdout' and stdout_data or stderr_data
          table.insert(output, vim.trim(data))
        else
          pipe:read_stop()
          pipe:close()
        end
      end)
    end
  end
end, 3)

return M
