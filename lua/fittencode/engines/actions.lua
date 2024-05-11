local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Chat = require('fittencode.views.chat')
local Log = require('fittencode.log')
local Promise = require('fittencode.concurrency.promise')
local PromptProviders = require('fittencode.prompt_providers')
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

local current_eval = 1

---@type Chat
local chat = nil

---@class ActionOptions
---@field prompt? string
---@field content? string

local function get_action_name(action)
  return Base.tbl_key_by_value(Actions, action)
end

local function get_action_type(action)
  return 'FittenCodePrompt/Actions/' .. get_action_name(action)
end

local function process_suggestions(suggestions)
  if not suggestions then
    return
  end
  suggestions = vim.tbl_filter(function(s) return #s > 0 end, suggestions)
  if #suggestions ~= 0 then
    return table.concat(suggestions, '\n') .. '\n'
  end
end

local function chain_actions(action, solved_prefix, on_error)
  Sessions.request_generate_one_stage(0, {
    prompt_ty = get_action_type(action),
    solved_prefix = solved_prefix,
  }, function(_, prompt, suggestions)
    Log.debug('Suggestions for Actions: {}', suggestions)
    local lines = process_suggestions(suggestions)
    if not lines then
      schedule(on_error)
    else
      chat:append_text(lines)
      local new_solved_prefix = prompt.prefix .. lines
      chain_actions(action, new_solved_prefix, on_error)
    end
  end, function()
    schedule(on_error)
  end)
end

---@param action number
---@param opts? ActionOptions
function ActionsEngine.start_action(action, opts)
  local action_name = get_action_name(action)
  if not action_name then
    return
  end

  Log.debug('Start Action({})...', action_name)

  chat:show()

  local sln, eln = api.nvim_buf_get_mark(0, '<'), api.nvim_buf_get_mark(0, '>')
  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)

  local on_error = function()
    Log.debug('Action: No more suggestions')
    chat:append_text('\nQ.E.D.\n')
    Log.debug('chat text: {}', chat.text)
    current_eval = current_eval + 1
  end

  Log.debug('sln: {}, eln: {}', sln, eln)

  local prompt_opts = {
    window = window,
    buffer = buffer,
    range = { sln[1] - 1, eln[1] - 1 },
    filetype = vim.bo.filetype,
    prompt_ty = get_action_type(action),
    solved_content = opts and opts.content,
    solved_prefix = nil,
    prompt = opts and opts.prompt,
  }
  local prompt_preview = PromptProviders.get_prompt_one(prompt_opts)
  local c_in = 'In[' .. current_eval .. ']:= ' .. action_name .. '\n'
  chat:append_text(c_in .. prompt_preview.content .. '\n\n')

  Promise:new(function(resolve, reject)
    Sessions.request_generate_one_stage(0, prompt_opts, function(_, prompt, suggestions)
      Log.debug('Suggestions for Actions: {}', suggestions)
      local lines = process_suggestions(suggestions)
      if not lines then
        reject()
      else
        local c_out = 'Out[' .. current_eval .. ']=\n'
        chat:append_text(c_out .. lines)
        local solved_prefix = prompt.prefix .. lines
        resolve(solved_prefix)
      end
    end, function()
      reject()
    end)
  end):forward(function(solved_prefix)
    chain_actions(action, solved_prefix, on_error)
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
  chat = Chat:new()
end

return ActionsEngine
