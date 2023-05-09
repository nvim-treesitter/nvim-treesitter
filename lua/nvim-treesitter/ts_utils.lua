local M = {}

-- Returns a function that returns the given value if it is a function,
-- otherwise returns a function that returns the given value.
---@param a any
---@return fun(...):any
local function to_func(a)
  return type(a) == 'function' and a or function()
    return a
  end
end

-- Memoizes a function based on the buffer tick of the provided bufnr.
-- The cache entry is cleared when the buffer is detached to avoid memory leaks.
-- The options argument is a table with two optional values:
--  - bufnr: extracts a bufnr from the given arguments.
--  - key: extracts the cache key from the given arguments.
---@param fn function the fn to memoize, taking the buffer as first argument
---@param options? {bufnr: integer?, key: string|fun(...): string?} the memoization options
---@return function: a memoized function
function M.memoize_by_buf_tick(fn, options)
  options = options or {}

  ---@type table<string, {result: any, last_tick: integer}>
  local cache = setmetatable({}, { __mode = "kv" })
  -- TODO(clason): can this be simplified?
  local bufnr_fn = to_func(options.bufnr or function(a)
    return a
  end)
  local key_fn = to_func(options.key or function(a)
    return a
  end)

  return function(...)
    local bufnr = bufnr_fn(...)
    local key = key_fn(...)
    local tick = vim.api.nvim_buf_get_changedtick(bufnr)

    if cache[key] then
      if cache[key].last_tick == tick then
        return cache[key].result
      end
    else
      local function detach_handler()
        cache[key] = nil
      end

      -- Clean up logic only!
      vim.api.nvim_buf_attach(bufnr, false, {
        on_detach = detach_handler,
        on_reload = detach_handler,
      })
    end

    cache[key] = {
      result = fn(...),
      last_tick = tick,
    }

    return cache[key].result
  end
end

return M
