local co = coroutine

---Executes a future with a callback when it is done
local function execute(func, callback, ...)
  local thread = co.create(func)

  local function step(...)
    local ret = { co.resume(thread, ...) }
    local stat, nargs, fn_or_ret = unpack(ret)

    if not stat then
      error(
        string.format(
          'The coroutine failed with this message: %s\n%s',
          nargs,
          debug.traceback(thread)
        )
      )
    end

    if co.status(thread) == 'dead' then
      if callback then
        callback(unpack(ret, 3))
      end
      return
    end

    local args = { select(4, unpack(ret)) }
    args[nargs] = step
    fn_or_ret(unpack(args, 1, nargs))
  end

  step(...)
end

local M = {}

--- Creates an async function with a callback style function.
--- @generic F: function
--- @param func F
--- @param argc integer
--- @return F
function M.wrap(func, argc)
  return function(...)
    if not co.running() or select('#', ...) == argc then
      return func(...)
    end
    return co.yield(argc, func, ...)
  end
end

---Use this to create a function which executes in an async context but
---called from a non-async context. Inherently this cannot return anything
---since it is non-blocking
--- @generic F: function
--- @param func async F
--- @param nargs? integer
--- @return F
function M.sync(func, nargs)
  nargs = nargs or 0
  return function(...)
    if co.running() then
      return func(...)
    end
    local callback = select(nargs + 1, ...)
    execute(func, callback, unpack({ ... }, 1, nargs))
  end
end

--- For functions that don't provide a callback as there last argument
--- @generic F: function
--- @param func F
--- @return F
function M.void(func)
  return function(...)
    if co.running() then
      return func(...)
    end
    execute(func, nil, ...)
  end
end

--- @param n integer max number of concurrent jobs
--- @param interrupt_check function()
--- @param thunks function()[]
--- @return any
function M.join(n, interrupt_check, thunks)
  return co.yield(1, function(finish)
    if #thunks == 0 then
      return finish()
    end

    local remaining = { select(n + 1, unpack(thunks)) }
    local to_go = #thunks

    local ret = {}

    local function cb(...)
      ret[#ret + 1] = { ... }
      to_go = to_go - 1
      if to_go == 0 then
        finish(ret)
      elseif not interrupt_check or not interrupt_check() then
        if #remaining > 0 then
          local next_task = table.remove(remaining)
          next_task(cb)
        end
      end
    end

    for i = 1, math.min(n, #thunks) do
      thunks[i](cb)
    end
  end, 1)
end

---Useful for partially applying arguments to an async function
--- @return function
function M.curry(fn, ...)
  local args = { ... }
  local nargs = select('#', ...)
  return function(...)
    local other = { ... }
    for i = 1, select('#', ...) do
      args[nargs + i] = other[i]
    end
    fn(unpack(args))
  end
end

---An async function that when called will yield to the Neovim scheduler to be
---able to call the API.
--- @type fun()
M.main = M.wrap(vim.schedule, 1)

return M
