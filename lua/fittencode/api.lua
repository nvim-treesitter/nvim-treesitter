local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local View = require('fittencode.view')
local Engine = require('fittencode.engine')

local M = {}

M.api = {
  ---@param username string
  ---@param password string
  login = function(username, password)
    Sessions.request_login(username, password)
  end,
  logout = function()
    Sessions.request_logout()
  end,
  ---@param level integer @one of the `vim.log.levels` values
  set_log_level = function(level)
    Log.set_level(level)
  end,
  accept_all_suggestions = function()
    if Engine.has_suggestions() then
      Engine.accept_all_suggestions()
    else
      View.tab()
    end
  end,
  accept_line = function()
    Engine.accept_line()
  end,
  accept_word = function()
    Engine.accept_word()
  end,
}

return M
