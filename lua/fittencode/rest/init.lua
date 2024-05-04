local M = {}

local builtin_backends = {
  ['curl'] = function()
    return require('fittencode.rest.backend.curl'):new()
  end,
  ['libcurl'] = function()
    return require('fittencode.rest.backend.libcurl'):new()
  end,
  ['node'] = function()
    return require('fittencode.rest.backend.node'):new()
  end,
}

---@class RestOptions
---@field backend string|nil The backend to use for making HTTP requests. Defaults to 'curl'.
---@field timeout number|nil The timeout in seconds for each request. Defaults to 10.

---@type RestOptions
local ctx = nil

---@return FittenClient?
function M.make_client()
  if ctx then
    return builtin_backends[ctx.backend]()
  end
end

---@param opts? RestOptions
function M.setup(opts)
  opts = opts or {
    backend = 'curl',
    timeout = 10,
  }
  ctx = opts
end

return M
