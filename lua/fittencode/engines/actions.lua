local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Chat = require('fittencode.views.chat')
local Log = require('fittencode.log')
local NetworkError = require('fittencode.client.network_error')
local Promise = require('fittencode.concurrency.promise')
local PromptProviders = require('fittencode.prompt_providers')
local Sessions = require('fittencode.sessions')
local Status = require('fittencode.status')

local schedule = Base.schedule

local SC = Status.C

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
---@class language? string

---@class GenerateUnitTestOptions : ActionOptions
---@field test_framework string

local function get_action_name(action)
  return Base.tbl_key_by_value(Actions, action)
end

local function get_action_type(action)
  return 'FittenCodePrompt/Actions/' .. get_action_name(action)
end

local function filter_suggestions(suggestions)
  if not suggestions then
    return
  end
  return vim.tbl_filter(function(s) return #s > 0 end, suggestions)
end

local function chain_actions(action, solved_prefix, on_error)
  Sessions.request_generate_one_stage(0, {
    prompt_ty = get_action_type(action),
    solved_prefix = solved_prefix,
  }, function(_, prompt, suggestions)
    Log.debug('Suggestions for Actions: {}', suggestions)
    local lines = filter_suggestions(suggestions)
    if not lines or #lines == 0 then
      schedule(on_error)
    else
      if chat:is_repeated(lines) then
        Log.debug('Repeated suggestions')
        schedule(on_error)
      else
        chat:commit(lines)
        local new_solved_prefix = prompt.prefix .. table.concat(lines, '\n') .. '\n'
        chain_actions(action, new_solved_prefix, on_error)
      end
    end
  end, function(err)
    schedule(on_error, err)
  end)
end

---@param action number
---@param opts? ActionOptions
function ActionsEngine.start_action(action, opts)
  opts = opts or {}

  local action_name = get_action_name(action)
  if not action_name then
    return
  end

  Log.debug('Start Action({})...', action_name)

  Status.update(SC.GENERATING)

  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)
  local sln, eln = api.nvim_buf_get_mark(buffer, '<'), api.nvim_buf_get_mark(buffer, '>')

  Log.debug('sln: {}, eln: {}', sln, eln)

  chat:show()
  vim.fn.win_gotoid(window)

  local on_error = function(err)
    Log.error('Error in Action: {}', err)
    if type(err) == 'table' and getmetatable(err) == NetworkError then
      Status.update(SC.NETWORK_ERROR)
      return
    end
    Log.debug('Action: No more suggestions')
    chat:commit('Q.E.D.\n', true)
    current_eval = current_eval + 1
    Log.debug('Chat text: {}', chat.text)
    if #chat.text > 0 then
      -- FIXME: A better status update is needed
      Status.update(SC.SUGGESTIONS_READY)
    else
      Status.update(SC.NO_MORE_SUGGESTIONS)
    end
  end

  local prompt_opts = {
    window = window,
    buffer = buffer,
    range = { sln[1] - 1, eln[1] - 1 },
    filetype = vim.bo.filetype,
    prompt_ty = get_action_type(action),
    solved_content = opts and opts.content,
    solved_prefix = nil,
    prompt = opts and opts.prompt,
    action_opts = opts,
  }
  local prompt_preview = PromptProviders.get_prompt_one(prompt_opts)
  if #prompt_preview.filename == 0 then
    prompt_preview.filename = 'unnamed'
  end
  local source_info = ' (' .. prompt_preview.filename .. ' ' .. sln[1] .. ':' .. eln[1] .. ')'
  local c_in = '# In`[' .. current_eval .. ']`:= ' .. action_name .. source_info
  chat:commit(c_in)
  chat:commit(prompt_preview.content)

  Promise:new(function(resolve, reject)
    Sessions.request_generate_one_stage(0, prompt_opts, function(_, prompt, suggestions)
      Log.debug('Suggestions for Actions: {}', suggestions)
      local lines = filter_suggestions(suggestions)
      if not lines or #lines == 0 then
        reject()
      else
        local c_out = '# Out`[' .. current_eval .. ']`='
        chat:commit(c_out)
        chat:commit(lines, true)
        local solved_prefix = prompt.prefix .. table.concat(lines, '\n') .. '\n'
        resolve(solved_prefix)
      end
    end, function(err)
      reject(err)
    end)
  end):forward(function(solved_prefix)
    chain_actions(action, solved_prefix, on_error)
  end, function(err)
    schedule(on_error, err)
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

---@param opts GenerateUnitTestOptions
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
