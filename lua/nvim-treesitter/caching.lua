local api = vim.api

local M = {}

--- Creates a cache table for buffers keyed by a type name.
--- Cache entries attach to the buffer and cleanup entries
--- as buffers are detached.
function M.create_buffer_cache()
  local cache = {}

  local items = setmetatable({}, {
    __index = function(tbl, key)
      rawset(tbl, key, {})
      return rawget(tbl, key)
    end,
  })
  local loaded_buffers = {}

  function cache.set(type_name, bufnr, value)
    if not loaded_buffers[bufnr] then
      loaded_buffers[bufnr] = true
      -- Clean up the cache if the buffer is detached
      -- to avoid memory leaks
      api.nvim_buf_attach(bufnr, false, {
        on_detach = function()
          cache.clear_buffer(bufnr)
          loaded_buffers[tostring(bufnr)] = nil
          return true
        end,
        on_reload = function() end, -- this is needed to prevent on_detach being called on buffer reload
      })
    end

    items[tostring(bufnr)][type_name] = value
  end

  function cache.get(type_name, bufnr)
    return items[tostring(bufnr)][type_name]
  end

  function cache.has(type_name, bufnr)
    return cache.get(type_name, bufnr) ~= nil
  end

  function cache.remove(type_name, bufnr)
    items[tostring(bufnr)][type_name] = nil
  end

  function cache.clear_buffer(bufnr)
    items[tostring(bufnr)] = nil
  end

  return cache
end

return M
