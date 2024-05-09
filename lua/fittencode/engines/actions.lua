local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Log = require('fittencode.log')
local Promise = require('fittencode.concurrency.promise')
local Sessions = require('fittencode.sessions')

local ActionsEngine = {}

local Actions = {
  DocumentCode = 0,
  EditCode = 1,
  ExplainCode = 2,
  FindBugs = 3,
  GenerateUnitTest = 4,
  StartChat = 5
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

local function linear_suggestions(suggestions)
  suggestions = vim.tbl_filter(function(s) return #s > 0 end, suggestions)
  if #suggestions ~= 0 then
    return table.concat(suggestions, '\n') .. '\n'
  end
end

local function chian_action(promise, resolve_promise)
end

---@param action number
---@param opts? ActionOptions
function ActionsEngine.start_action(action, opts)
  if action == Actions.StartChat then
    Log.error('No support for StartChat action yet')
    return
  end
  local sln, eln = api.nvim_buf_get_mark(0, '<'), api.nvim_buf_get_mark(0, '>')
  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)

  Promise:new(function(resolve, reject)
    Sessions.request_generate_one_stage(0, {
      window = window,
      buffer = buffer,
      range = { sln[1] - 1, eln[1] - 1 },
      prompt_ty = get_action_type(action),
      solved_content = nil,
      solved_prefix = nil,
      prompt = opts and opts.prompt,
    }, function(_, prompt, suggestions)
      Log.debug('Suggestions for Actions: {}', suggestions)
      suggestions = linear_suggestions(suggestions)
      if not suggestions then
        reject()
      else
        resolve(prompt.prefix .. suggestions)
      end
    end, function()
      -- nothings to do here
    end)
  end):forward(function(solved_prefix)
    return Promise:new(function(resolve, reject)
      Sessions.request_generate_one_stage(0, {
        prompt_ty = get_action_type(action),
        solved_prefix = solved_prefix
      }, function(_, prompt, suggestions)
        Log.debug('Suggestions for Actions 2: {}', suggestions)
      end, function()
        -- nothings to do here
      end)
    end)
  end
  )
end

function ActionsEngine.document_code(opts)
  return ActionsEngine.start_action(Actions.DocumentCode, opts)
end

function ActionsEngine.edit_code(opts)
  local input_opts = { prompt = 'Prompt for FittenCode: ', default = '', }
  vim.ui.input(input_opts, function(prompt)
    Log.debug('Prompt for FittenCode: ' .. prompt)
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

function ActionsEngine.start_chat(opts)
  return ActionsEngine.start_action(Actions.StartChat, opts)
end

function ActionsEngine.setup()
end

return ActionsEngine
