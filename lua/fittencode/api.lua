local ActionsEngine = require('fittencode.engines.actions')
local InlineEngine = require('fittencode.engines.inline')
local Engines = require('fittencode.engines')
local Log = require('fittencode.log')
local Sessions = require('fittencode.sessions')

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
    return Engines.get_status()
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
  ---@param opts? ActionOptions
  document_code = function(opts)
    return ActionsEngine.document_code(opts)
  end,
  ---@param opts? ActionOptions
  edit_code = function(opts)
    return ActionsEngine.edit_code(opts)
  end,
  ---@param opts? ActionOptions
  explain_code = function(opts)
    return ActionsEngine.explain_code(opts)
  end,
  ---@param opts? ActionOptions
  find_bugs = function(opts)
    return ActionsEngine.find_bugs(opts)
  end,
  ---@param opts? ActionOptions
  generate_unit_test = function(opts)
    return ActionsEngine.generate_unit_test(opts)
  end,
  ---@param opts? ActionOptions
  implement_features = function(opts)
    return ActionsEngine.implement_features(opts)
  end,
  ---@param opts? ActionOptions
  implement_functions = function(opts)
    return ActionsEngine.implement_functions(opts)
  end,
  ---@param opts? ActionOptions
  implement_classes = function(opts)
    return ActionsEngine.implement_classes(opts)
  end,
  ---@param opts? ActionOptions
  improve_code = function(opts)
    return ActionsEngine.improve_code(opts)
  end,
  ---@param opts? ActionOptions
  refactor_code = function(opts)
    return ActionsEngine.refactor_code(opts)
  end,
  ---@param opts? ActionOptions
  start_chat = function(opts)
    return ActionsEngine.start_chat(opts)
  end,
  stop_eval = function()
    return ActionsEngine.stop_eval()
  end,
}

return M
