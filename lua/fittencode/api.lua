local ActionsEngine = require('fittencode.engines.actions')
local InlineEngine = require('fittencode.engines.inline')
local Log = require('fittencode.log')
local Sessions = require('fittencode.sessions')
local Status = require('fittencode.status')

local M = {}

M.api = {
  ---@param username string
  ---@param password string
  login = function(username, password)
    Sessions.login(username, password)
  end,
  logout = function()
    Sessions.logout()
  end,
  register = function()
    Sessions.register()
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
    return InlineEngine.has_suggestions()
  end,
  accept_all_suggestions = function()
    InlineEngine.accept_all_suggestions()
  end,
  accept_line = function()
    InlineEngine.accept_line()
  end,
  accept_word = function()
    InlineEngine.accept_word()
  end,
  document_code = function(opts)
    return ActionsEngine.document_code(opts)
  end,
  edit_code = function(opts)
    return ActionsEngine.edit_code(opts)
  end,
  explain_code = function(opts)
    return ActionsEngine.explain_code(opts)
  end,
  find_bugs = function(opts)
    return ActionsEngine.find_bugs(opts)
  end,
  generate_unit_test = function(opts)
    return ActionsEngine.generate_unit_test(opts)
  end,
  implement_features = function(opts)
    return ActionsEngine.implement_features(opts)
  end,
  start_chat = function(opts)
    return ActionsEngine.start_chat(opts)
  end,
}

return M
