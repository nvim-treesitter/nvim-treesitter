local Log = require('fittencode.log')

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

local fallback_backend = 'curl'

---@class RestOptions
---@field backend string|nil The backend to use for making HTTP requests. Defaults to 'curl'.
---@field timeout number|nil The timeout in seconds for each request. Defaults to 10.

---@type RestOptions
local ctx = {}

---@return FittenClient
function M.make_client()
  assert(ctx.backend, 'Run setup() to initialize the rest service')
  return builtin_backends[ctx.backend]()
end

---@param opts? RestOptions
function M.setup(opts)
  opts = opts or {
    backend = 'curl',
    timeout = 10,
  }
  if not vim.tbl_contains(vim.tbl_keys(builtin_backends), opts.backend) then
    Log.error('Invalid backend: {}, fallback to {}', opts.backend, fallback_backend)
    opts.backend = fallback_backend
  end
  ctx = opts
end

return M
