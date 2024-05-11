local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Log = require('fittencode.log')
local Promise = require('fittencode.concurrency.promise')
local Sessions = require('fittencode.sessions')

local schedule = Base.schedule

local ActionsEngine = {}

local Actions = {
  StartChat = 0,
  DocumentCode = 1,
  EditCode = 2,
  ExplainCode = 3,
  FindBugs = 4,
  GenerateUnitTest = 5,
  ImplementFeatures = 6,
  ImproveCode = 7,
  RefactorCode = 8,
}

---@class ActionOptions
---@field prompt? string
---@field content? string

local function get_action_name(action)
  return Base.tbl_key_by_value(Actions, action, '????')
end

local function get_action_type(action)
  return 'FittenCodePrompt/Actions/' .. get_action_name(action)
end

local function make_solved_prefix(prefix, suggestions)
  if not suggestions then
    return
  end
  suggestions = vim.tbl_filter(function(s) return #s > 0 end, suggestions)
  if #suggestions ~= 0 then
    return prefix .. table.concat(suggestions, '\n') .. '\n'
  end
end

local function chian_action(action, solved_prefix, on_error)
  Sessions.request_generate_one_stage(0, {
    prompt_ty = get_action_type(action),
    solved_prefix = solved_prefix,
  }, function(_, prompt, suggestions)
    Log.debug('Suggestions for Actions: {}', suggestions)
    local new_solved_prefix = make_solved_prefix(prompt.prefix, suggestions)
    if not new_solved_prefix then
      schedule(on_error)
    else
      chian_action(action, new_solved_prefix, on_error)
    end
  end, function()
    schedule(on_error)
  end)
end

---@param action number
---@param opts? ActionOptions
function ActionsEngine.start_action(action, opts)
  Log.debug('Start Action({})...', get_action_name(action))

  local sln, eln = api.nvim_buf_get_mark(0, '<'), api.nvim_buf_get_mark(0, '>')
  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)

  local on_error = function()
    Log.debug('Action: No more suggestions')
  end

  Log.debug('sln: {}, eln: {}', sln, eln)

  Promise:new(function(resolve, reject)
    Sessions.request_generate_one_stage(0, {
      window = window,
      buffer = buffer,
      range = { sln[1] - 1, eln[1] - 1 },
      prompt_ty = get_action_type(action),
      solved_content = opts and opts.content,
      solved_prefix = nil,
      prompt = opts and opts.prompt,
    }, function(_, prompt, suggestions)
      Log.debug('Suggestions for Actions: {}', suggestions)
      local solved_prefix = make_solved_prefix(prompt.prefix, suggestions)
      if not solved_prefix then
        reject()
      else
        resolve(solved_prefix)
      end
    end, function()
      reject()
    end)
  end):forward(function(solved_prefix)
    chian_action(action, solved_prefix, on_error)
  end, function()
    schedule(on_error)
  end
  )
end

function ActionsEngine.document_code(opts)
  return ActionsEngine.start_action(Actions.DocumentCode, opts)
end

function ActionsEngine.edit_code(opts)
  local input_opts = { prompt = 'Prompt for FittenCode EditCode: ', default = '', }
  vim.ui.input(input_opts, function(prompt)
    Log.debug('Prompt for FittenCode EditCode: ' .. prompt)
    ActionsEngine.start_action(Actions.EditCode, {
      prompt = prompt }
    )
  end)
end

function ActionsEngine.explain_code(opts)
  return ActionsEngine.start_action(Actions.ExplainCode, opts)
end

function ActionsEngine.find_bugs(opts)
  return ActionsEngine.start_action(Actions.FindBugs, opts)
end

function ActionsEngine.generate_unit_test(opts)
  return ActionsEngine.start_action(Actions.GenerateUnitTest, opts)
end

function ActionsEngine.implement_features(opts)
  return ActionsEngine.start_action(Actions.ImplementFeatures, opts)
end

function ActionsEngine.improve_code(opts)
  return ActionsEngine.start_action(Actions.ImproveCode, opts)
end

function ActionsEngine.refactor_code(opts)
  return ActionsEngine.start_action(Actions.RefactorCode, opts)
end

function ActionsEngine.start_chat(opts)
  local input_opts = { prompt = 'Ask... (Fitten Code Fast): ', default = '', }
  vim.ui.input(input_opts, function(content)
    Log.debug('Ask... (Fitten Code Fast): ' .. content)
    ActionsEngine.start_action(Actions.StartChat, {
      content = content }
    )
  end)
end

function ActionsEngine.setup()
end

return ActionsEngine
