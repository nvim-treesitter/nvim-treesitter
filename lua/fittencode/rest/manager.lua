local Config = require('fittencode.config')
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

---@class RestOptions
---@field backend string The backend to use for making HTTP requests.
---@field timeout number The timeout in seconds for each request.

function M.make_rest()
  return builtin_backends[Config.options.rest.backend]()
end

function M.setup()
  if not vim.tbl_contains(vim.tbl_keys(builtin_backends), Config.options.rest.backend) then
    local msg = 'Invalid rest backend: ' .. Config.options.rest.backend
    vim.api.nvim_err_writeln(msg)
  end
end

return M
