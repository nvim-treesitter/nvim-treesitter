local co = coroutine

local M = {}

---Executes a future with a callback when it is done
--- @param func function
--- @param callback function
--- @param ... unknown
function M.run(func, callback, ...)
  local thread = co.create(func)

  local function step(...)
    local ret = { co.resume(thread, ...) }
    --- @type boolean, any
    local stat = ret[1]

    if not stat then
      local err = ret[2]
      error(
        string.format(
          'The coroutine failed with this message: %s\n%s',
          err,
          debug.traceback(thread)
        )
      )
    end

    if co.status(thread) == 'dead' then
      if callback then
        callback(unpack(ret, 2, table.maxn(ret)))
      end
      return
    end

    --- @type integer, function, any[]
    local nargs, fn, args = ret[2], ret[3], { select(4, unpack(ret)) }

    assert(type(nargs) == 'number')
    assert(type(fn) == 'function')

    args[nargs] = step
    fn(unpack(args, 1, nargs))
  end

  step(...)
end

function M.wait(argc, func, ...)
  -- Always run the wrapped functions in xpcall and re-raise the error in the
  -- coroutine. This makes pcall work as normal.
  local function pfunc(...)
    local args = { ... }
    local step = args[argc]

    args[argc] = function(...)
      step(true, ...)
    end

    xpcall(func, function(err)
      step(false, err, debug.traceback())
    end, unpack(args, 1, argc))
  end

  local ret = { co.yield(argc, pfunc, ...) }

  local ok = ret[1]

  if not ok then
    local err, traceback = ret[2], ret[3]
    error(string.format('Wrapped function failed: %s\n%s', err, traceback))
  end

  return unpack(ret, 2, table.maxn(ret))
end
--- Creates an async function with a callback style function.
--- @generic F: function
--- @param func F
--- @param argc integer
--- @return F
function M.wrap(func, argc)
  vim.validate({
    func = { func, 'function' },
    argc = { argc, 'number' },
  })
  --- @param ... unknown
  --- @return unknown
  return function(...)
    return M.wait(argc, func, ...)
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
    local callback = select(nargs + 1, ...)
    M.run(func, callback, unpack({ ... }, 1, nargs))
  end
end

--- @param n integer max number of concurrent jobs
--- @param interrupt_check? function
--- @param thunks function[]
--- @return any
function M.join(n, interrupt_check, thunks)
  local function run(finish)
    if #thunks == 0 then
      return finish()
    end

    local remaining = { select(n + 1, unpack(thunks)) }
    local to_go = #thunks

    local ret = {} --- @type any[]

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
  end

  return M.wait(1, run)
end

---An async function that when called will yield to the Neovim scheduler to be
---able to call the API.
--- @type fun()
M.main = M.wrap(vim.schedule, 1)

return M
