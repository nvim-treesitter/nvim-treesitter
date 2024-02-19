local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')

local M = {}

M.api = {
  login = function(username, password)
    Sessions.request_login(username, password)
  end,
  logout = function()
    Sessions.request_logout()
  end,
  set_log_level = function(level)
    Log.set_level(level)
  end,
}

return M
