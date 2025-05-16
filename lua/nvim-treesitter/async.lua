local pcall = copcall or pcall

--- @param ... any
--- @return {[integer]: any, n: integer}
local function pack_len(...)
  return { n = select('#', ...), ... }
end

--- like unpack() but use the length set by F.pack_len if present
--- @param t? { [integer]: any, n?: integer }
--- @param first? integer
--- @return ...any
local function unpack_len(t, first)
  if t then
    return unpack(t, first or 1, t.n or table.maxn(t))
  end
end

--- @class async
local M = {}

--- Weak table to keep track of running tasks
--- @type table<thread,async.Task?>
local threads = setmetatable({}, { __mode = 'k' })

--- @return async.Task?
local function running()
  local task = threads[coroutine.running()]
  if task and not (task:_completed() or task._closing) then
    return task
  end
end

--- Base class for async tasks. Async functions should return a subclass of
--- this. This is designed specifically to be a base class of uv_handle_t
--- @class async.Handle
--- @field close fun(self: async.Handle, callback?: fun())
--- @field is_closing? fun(self: async.Handle): boolean

--- @alias async.CallbackFn fun(...: any): async.Handle?

--- @class async.Task : async.Handle
--- @field package _callbacks table<integer,fun(err?: any, ...: any)>
--- @field package _callback_pos integer
--- @field private _thread thread
---
--- Tasks can call other async functions (task of callback functions)
--- when we are waiting on a child, we store the handle to it here so we can
--- cancel it.
--- @field private _current_child? async.Handle
---
--- Error result of the task is an error occurs.
--- Must use `await` to get the result.
--- @field private _err? any
---
--- Result of the task.
--- Must use `await` to get the result.
--- @field private _result? any[]
local Task = {}
Task.__index = Task

--- @private
--- @param func function
--- @return async.Task
function Task._new(func)
  local thread = coroutine.create(func)

  local self = setmetatable({
    _closing = false,
    _thread = thread,
    _callbacks = {},
    _callback_pos = 1,
  }, Task)

  threads[thread] = self

  return self
end

--- @param callback fun(err?: any, ...: any)
function Task:await(callback)
  if self._closing then
    callback('closing')
  elseif self:_completed() then -- TODO(lewis6991): test
    -- Already finished or closed
    callback(self._err, unpack_len(self._result))
  else
    self._callbacks[self._callback_pos] = callback
    self._callback_pos = self._callback_pos + 1
  end
end

--- @package
function Task:_completed()
  return (self._err or self._result) ~= nil
end

-- Use max 32-bit signed int value to avoid overflow on 32-bit systems.
-- Do not use `math.huge` as it is not interpreted as a positive integer on all
-- platforms.
local MAX_TIMEOUT = 2 ^ 31 - 1

--- Synchronously wait (protected) for a task to finish (blocking)
---
--- If an error is returned, `Task:traceback()` can be used to get the
--- stack trace of the error.
---
--- Example:
--- ```lua
---
---   local ok, err_or_result = task:pwait(10)
---
---   if not ok then
---     error(task:traceback(err_or_result))
---   end
---
---   local _, result = assert(task:pwait(10))
--- ```
---
--- Can be called if a task is closing.
--- @param timeout? integer
--- @return boolean status
--- @return any ... result or error
function Task:pwait(timeout)
  local done = vim.wait(timeout or MAX_TIMEOUT, function()
    -- Note we use self:_completed() instead of self:await() to avoid creating a
    -- callback. This avoids having to cleanup/unregister any callback in the
    -- case of a timeout.
    return self:_completed()
  end)

  if not done then
    return false, 'timeout'
  elseif self._err then
    return false, self._err
  else
    return true, unpack_len(self._result)
  end
end

--- Synchronously wait for a task to finish (blocking)
---
--- Example:
--- ```lua
---   local result = task:wait(10) -- wait for 10ms or else error
---
---   local result = task:wait() -- wait indefinitely
--- ```
--- @param timeout? integer Timeout in milliseconds
--- @return any ... result
function Task:wait(timeout)
  local res = pack_len(self:pwait(timeout))
  local stat = res[1]

  if not stat then
    error(self:traceback(res[2]))
  end

  return unpack_len(res, 2)
end

--- @private
--- @param msg? string
--- @param _lvl? integer
--- @return string
function Task:_traceback(msg, _lvl)
  _lvl = _lvl or 0

  local thread = ('[%s] '):format(self._thread)

  local child = self._current_child
  if getmetatable(child) == Task then
    --- @cast child async.Task
    msg = child:_traceback(msg, _lvl + 1)
  end

  local tblvl = getmetatable(child) == Task and 2 or nil
  msg = (msg or '') .. debug.traceback(self._thread, '', tblvl):gsub('\n\t', '\n\t' .. thread)

  if _lvl == 0 then
    --- @type string
    msg = msg
      :gsub('\nstack traceback:\n', '\nSTACK TRACEBACK:\n', 1)
      :gsub('\nstack traceback:\n', '\n')
      :gsub('\nSTACK TRACEBACK:\n', '\nstack traceback:\n', 1)
  end

  return msg
end

--- Get the traceback of a task when it is not active.
--- Will also get the traceback of nested tasks.
---
--- @param msg? string
--- @return string
function Task:traceback(msg)
  return self:_traceback(msg)
end

--- If a task completes with an error, raise the error
function Task:raise_on_error()
  self:await(function(err)
    if err then
      error(self:_traceback(err), 0)
    end
  end)
  return self
end

--- @private
--- @param err? any
--- @param result? {[integer]: any, n: integer}
function Task:_finish(err, result)
  self._current_child = nil
  self._err = err
  self._result = result
  threads[self._thread] = nil

  local errs = {} --- @type string[]
  for _, cb in pairs(self._callbacks) do
    --- @type boolean, string
    local ok, cb_err = pcall(cb, err, unpack_len(result))
    if not ok then
      errs[#errs + 1] = cb_err
    end
  end

  if #errs > 0 then
    error(table.concat(errs, '\n'), 0)
  end
end

--- @return boolean
function Task:is_closing()
  return self._closing
end

--- Close the task and all its children.
--- If callback is provided it will run asynchronously,
--- else it will run synchronously.
---
--- @param callback? fun()
function Task:close(callback)
  if self:_completed() then
    if callback then
      callback()
    end
    return
  end

  if self._closing then
    return
  end

  self._closing = true

  if callback then -- async
    if self._current_child then
      self._current_child:close(function()
        self:_finish('closed')
        callback()
      end)
    else
      self:_finish('closed')
      callback()
    end
  else -- sync
    if self._current_child then
      self._current_child:close(function()
        self:_finish('closed')
      end)
    else
      self:_finish('closed')
    end
    vim.wait(0, function()
      return self:_completed()
    end)
  end
end

--- @param obj any
--- @return boolean
local function is_async_handle(obj)
  local ty = type(obj)
  return (ty == 'table' or ty == 'userdata') and vim.is_callable(obj.close)
end

--- @param ... any
function Task:_resume(...)
  --- @type [boolean, string|async.CallbackFn]
  local ret = pack_len(coroutine.resume(self._thread, ...))
  local stat = ret[1]

  if not stat then
    -- Coroutine had error
    self:_finish(ret[2])
  elseif coroutine.status(self._thread) == 'dead' then
    -- Coroutine finished
    local result = pack_len(unpack_len(ret, 2))
    self:_finish(nil, result)
  else
    local fn = ret[2]
    --- @cast fn -string

    -- TODO(lewis6991): refine error handler to be more specific
    local ok, r
    ok, r = pcall(fn, function(...)
      if is_async_handle(r) then
        --- @cast r async.Handle
        -- We must close children before we resume to ensure
        -- all resources are collected.
        local args = pack_len(...)
        r:close(function()
          self:_resume(unpack_len(args))
        end)
      else
        self:_resume(...)
      end
    end)

    if not ok then
      self:_finish(r)
    elseif is_async_handle(r) then
      self._current_child = r
    end
  end
end

--- @return 'running'|'suspended'|'normal'|'dead'?
function Task:status()
  return coroutine.status(self._thread)
end

--- Run a function in an async context, asynchronously.
---
--- Examples:
--- ```lua
--- -- The two below blocks are equivalent:
---
--- -- Run a uv function and wait for it
--- local stat = async.arun(function()
---     return async.await(2, vim.uv.fs_stat, 'foo.txt')
--- end):wait()
---
--- -- Since uv functions have sync versions. You can just do:
--- local stat = vim.fs_stat('foo.txt')
--- ```
--- @param func function
--- @param ... any
--- @return async.Task
function M.arun(func, ...)
  local task = Task._new(func)
  task:_resume(...)
  return task
end

--- @class async.TaskFun
--- @field package _fun fun(...: any): any
--- @operator call(...): any
local TaskFun = {}
TaskFun.__index = TaskFun

function TaskFun:__call(...)
  return M.arun(self._fun, ...)
end

--- Create an async function
--- @param fun function
--- @return async.TaskFun
function M.async(fun)
  return setmetatable({ _fun = fun }, TaskFun)
end

--- Returns the status of a task’s thread.
---
--- @param task? async.Task
--- @return 'running'|'suspended'|'normal'|'dead'?
function M.status(task)
  task = task or running()
  if task then
    assert(getmetatable(task) == Task, 'Expected Task')
    return task:status()
  end
end

--- @async
--- @generic R1, R2, R3, R4
--- @param fun fun(callback: fun(r1: R1, r2: R2, r3: R3, r4: R4)): any?
--- @return R1, R2, R3, R4
local function yield(fun)
  assert(type(fun) == 'function', 'Expected function')
  return coroutine.yield(fun)
end

--- @async
--- @param task async.Task
--- @return any ...
local function await_task(task)
  --- @param callback fun(err?: string, ...: any)
  --- @return function
  local res = pack_len(yield(function(callback)
    task:await(callback)
    return task
  end))

  local err = res[1]

  if err then
    -- TODO(lewis6991): what is the correct level to pass?
    error(err, 0)
  end

  return unpack_len(res, 2)
end

--- Asynchronous blocking wait
--- @param argc integer
--- @param fun async.CallbackFn
--- @param ... any func arguments
--- @return any ...
local function await_cbfun(argc, fun, ...)
  local args = pack_len(...)

  --- @param callback fun(...:any)
  --- @return any?
  return yield(function(callback)
    args[argc] = callback
    args.n = math.max(args.n, argc)
    return fun(unpack_len(args))
  end)
end

--- @param taskfun async.TaskFun
--- @param ... any
--- @return any ...
local function await_taskfun(taskfun, ...)
  return taskfun._fun(...)
end

--- Asynchronous blocking wait
---
--- Example:
--- ```lua
--- local task = async.arun(function()
---    return 1, 'a'
--- end)
---
--- local task_fun = async.async(function(arg)
---    return 2, 'b', arg
--- end)
---
--- async.arun(function()
---   do -- await a callback function
---     async.await(1, vim.schedule)
---   end
---
---   do -- await a task (new async context)
---     local n, s = async.await(task)
---     assert(n == 1 and s == 'a')
---   end
---
---   do -- await a started task function (new async context)
---     local n, s, arg = async.await(task_fun('A'))
---     assert(n == 2)
---     assert(s == 'b')
---     assert(args == 'A')
---   end
---
---   do -- await a task function (re-using the current async context)
---     local n, s, arg = async.await(task_fun, 'B')
---     assert(n == 2)
---     assert(s == 'b')
---     assert(args == 'B')
---   end
--- end)
--- ```
--- @async
--- @overload fun(argc: integer, func: async.CallbackFn, ...:any): any ...
--- @overload fun(task: async.Task): any ...
--- @overload fun(taskfun: async.TaskFun): any ...
function M.await(...)
  assert(running(), 'Not in async context')

  local arg1 = select(1, ...)

  if type(arg1) == 'number' then
    return await_cbfun(...)
  elseif getmetatable(arg1) == Task then
    return await_task(...)
  elseif getmetatable(arg1) == TaskFun then
    return await_taskfun(...)
  end

  error('Invalid arguments, expected Task or (argc, func) got: ' .. type(arg1), 2)
end

--- Creates an async function with a callback style function.
---
--- Example:
---
--- ```lua
--- --- Note the callback argument is not present in the return function
--- --- @type fun(timeout: integer)
--- local sleep = async.awrap(2, function(timeout, callback)
---   local timer = vim.uv.new_timer()
---   timer:start(timeout * 1000, 0, callback)
---   -- uv_timer_t provides a close method so timer will be
---   -- cleaned up when this function finishes
---   return timer
--- end)
---
--- async.arun(function()
---   print('hello')
---   sleep(2)
---   print('world')
--- end)
--- ```
---
--- local atimer = async.awrap(
--- @param argc integer
--- @param func async.CallbackFn
--- @return async function
function M.awrap(argc, func)
  assert(type(argc) == 'number')
  assert(type(func) == 'function')
  --- @async
  return function(...)
    return M.await(argc, func, ...)
  end
end

if vim.schedule then
  --- An async function that when called will yield to the Neovim scheduler to be
  --- able to call the API.
  M.schedule = M.awrap(1, vim.schedule)
end

--- Create a function that runs a function when it is garbage collected.
--- @generic F
--- @param f F
--- @param gc fun()
--- @return F
local function gc_fun(f, gc)
  local proxy = newproxy(true)
  local proxy_mt = getmetatable(proxy)
  proxy_mt.__gc = gc
  proxy_mt.__call = function(_, ...)
    return f(...)
  end

  return proxy
end

--- @param task_cbs table<async.Task,function>
local function gc_cbs(task_cbs)
  for task, tcb in pairs(task_cbs) do
    for j, cb in pairs(task._callbacks) do
      if cb == tcb then
        task._callbacks[j] = nil
        break
      end
    end
  end
end

--- @async
--- Example:
--- ```lua
--- local task1 = async.arun(function()
---   return 1, 'a'
--- end)
---
--- local task2 = async.arun(function()
---   return 1, 'a'
--- end)
---
--- local task3 = async.arun(function()
---   error('task3 error')
--- end)
---
--- async.arun(function()
---   for i, err, r1, r2 in async.iter({task1, task2, task3})
---     print(i, err, r1, r2)
---   end
--- end)
--- ```
---
--- Prints:
--- ```
--- 1 nil 1 'a'
--- 2 nil 2 'b'
--- 3 'task3 error' nil nil
--- ```
---
--- @param tasks async.Task[]
--- @return fun(): (integer?, any?, ...)
function M.iter(tasks)
  assert(running(), 'Not in async context')

  local results = {} --- @type [integer, any, ...][]

  -- Iter blocks in an async context so only one waiter is needed
  local waiter = nil
  local task_cbs = {} --- @type table<async.Task,function>
  local remaining = #tasks

  --- If can_gc_cbs is true, then the iterator function has been garbage
  --- collected and means any awaiters can also be garbage collected. The
  --- only time we can't do this is if with the special case when iter() is
  --- called anonymously (`local i = async.iter(tasks)()`), so we should not
  --- garbage collect the callbacks until at least one awaiter is called.
  local can_gc_cbs = false

  for i, task in ipairs(tasks) do
    local function cb(err, ...)
      if can_gc_cbs == true then
        gc_cbs(task_cbs)
      end

      local callback = waiter

      -- Clear waiter before calling it
      waiter = nil

      remaining = remaining - 1
      if callback then
        -- Iterator is waiting, yield to it
        callback(i, err, ...)
      else
        -- Task finished before Iterator was called. Store results.
        table.insert(results, pack_len(i, err, ...))
      end
    end

    task_cbs[task] = cb
    task:await(cb)
  end

  return gc_fun(
    M.awrap(1, function(callback)
      if next(results) then
        local res = table.remove(results, 1)
        callback(unpack_len(res))
      elseif remaining == 0 then
        callback() -- finish
      else
        assert(not waiter, 'internal error: waiter already set')
        waiter = callback
      end
    end),
    function()
      -- Don't gc callbacks just yet. Wait until at least one of them is called.
      can_gc_cbs = true
    end
  )
end

do -- join()
  --- @param results table<integer,table>
  --- @param i integer
  --- @param ... any
  --- @return boolean
  local function collect(results, i, ...)
    if i then
      results[i] = pack_len(...)
    end
    return i ~= nil
  end

  --- @param iter fun(): ...
  --- @return table<integer,table>
  local function drain_iter(iter)
    local results = {} --- @type table<integer,table>
    while collect(results, iter()) do
    end
    return results
  end

  --- @async
  --- Wait for all tasks to finish and return their results.
  ---
  --- Example:
  --- ```lua
  --- local task1 = async.arun(function()
  ---   return 1, 'a'
  --- end)
  ---
  --- local task2 = async.arun(function()
  ---   return 1, 'a'
  --- end)
  ---
  --- local task3 = async.arun(function()
  ---   error('task3 error')
  --- end)
  ---
  --- async.arun(function()
  ---   local results = async.join({task1, task2, task3})
  ---   print(vim.inspect(results))
  --- end)
  --- ```
  ---
  --- Prints:
  --- ```
  --- {
  ---   [1] = { nil, 1, 'a' },
  ---   [2] = { nil, 2, 'b' },
  ---   [3] = { 'task2 error' },
  --- }
  --- ```
  --- @param tasks async.Task[]
  --- @return table<integer,[any?,...?]>
  function M.join(tasks)
    assert(running(), 'Not in async context')
    return drain_iter(M.iter(tasks))
  end

  --- @async
  --- @param tasks async.Task[]
  --- @return integer?, any?, ...?
  function M.joinany(tasks)
    return M.iter(tasks)()
  end
end

return M
