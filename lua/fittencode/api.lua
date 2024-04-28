local Engine = require('fittencode.engine')
local Log = require('fittencode.log')
local Sessions = require('fittencode.sessions')
local Status = require('fittencode.status')

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
  ---@return integer
  get_current_status = function()
    return Status.get_current()
  end,
  ---@return boolean
  has_suggestions = function()
    return Engine.has_suggestions()
  end,
  accept_all_suggestions = function()
    Engine.accept_all_suggestions()
  end,
  accept_line = function()
    Engine.accept_line()
  end,
  accept_word = function()
    Engine.accept_word()
  end,
}

return M
