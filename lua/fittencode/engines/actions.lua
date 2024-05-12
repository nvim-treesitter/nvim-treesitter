local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Chat = require('fittencode.views.chat')
local Config = require('fittencode.config')
local Log = require('fittencode.log')
local NetworkError = require('fittencode.client.network_error')
local Promise = require('fittencode.concurrency.promise')
local PromptProviders = require('fittencode.prompt_providers')
local Sessions = require('fittencode.sessions')
local Status = require('fittencode.status')
local TaskScheduler = require('fittencode.tasks')

local schedule = Base.schedule

local SC = Status.C

---@class ActionsEngine
---@field chat Chat
---@field tasks TaskScheduler
---@field status Status
---@field lock boolean
---@field elapsed_time number
---@field depth number
---@field current_eval number
---@field start_chat function
---@field document_code function
---@field edit_code function
---@field explain_code function
---@field find_bugs function
---@field generate_unit_test function
---@field implement_features function
---@field improve_code function
---@field refactor_code function
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

---@class TaskScheduler
local tasks = nil

-- One by one evaluation
local lock = false

local elapsed_time = 0
local depth = 0

local stop_eval = false

---@type Status
local status = nil

---@class ActionOptions
---@field prompt? string
---@field content? string
---@field language? string

---@class GenerateUnitTestOptions : ActionOptions
---@field test_framework string

---@class ImplementFeaturesOptions : ActionOptions
---@field feature_type string

local function get_action_name(action)
  return Base.tbl_key_by_value(Actions, action)
end

local function get_action_type(action)
  return 'FittenCodePrompt/Actions/' .. get_action_name(action)
end

local function filter_suggestions(task_id, suggestions)
  if not suggestions then
    return
  end
  local matched, ms = tasks:match_clean(task_id, 0, 0)
  if not matched then
    Log.debug('Action request is outdated, discarding task: {}', task_id)
    return
  end
  return vim.tbl_filter(function(s) return #s > 0 end, suggestions), ms
end

local function chain_actions(action, solved_prefix, on_error)
  Log.debug('Chain Action({})...', get_action_name(action))
  if stop_eval then
    stop_eval = false
    schedule(on_error)
    Log.debug('Stop evaluation')
    return
  end
  local task_id = tasks:create(0, 0)
  Sessions.request_generate_one_stage(task_id, {
    prompt_ty = get_action_type(action),
    solved_prefix = solved_prefix,
  }, function(_, prompt, suggestions)
    -- Log.debug('Suggestions for Actions: {}', suggestions)
    local lines, ms = filter_suggestions(task_id, suggestions)
    if not lines or #lines == 0 then
      schedule(on_error)
    else
      if chat:is_repeated(lines) then
        Log.debug('Repeated suggestions')
        schedule(on_error)
      else
        elapsed_time = elapsed_time + ms
        depth = depth + 1
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
    Log.error('Invalid action: {}', action)
    return
  end

  Log.debug('Start Action({})...', action_name)

  if lock then
    Log.debug('Action is locked, skipping')
    return
  end

  lock = true
  elapsed_time = 0
  depth = 0

  status:update(SC.GENERATING)

  local window = api.nvim_get_current_win()
  local buffer = api.nvim_win_get_buf(window)
  local sln, eln = api.nvim_buf_get_mark(buffer, '<')[1], api.nvim_buf_get_mark(buffer, '>')[1]

  Log.debug('sln: {}, eln: {}', sln, eln)

  local vmode = { 'v', 'V', '<C-V>' }
  Log.debug('mode: {}', api.nvim_get_mode().mode)
  if vim.tbl_contains(vmode, api.nvim_get_mode().mode) then
    sln = vim.fn.getpos("'<")[2]
    eln = vim.fn.getpos("'>")[2]
    Log.debug('v mode sln: {}, eln: {}', sln, eln)
  end

  chat:show()
  vim.fn.win_gotoid(window)

  local on_error = function(err)
    lock = false
    if type(err) == 'table' and getmetatable(err) == NetworkError then
      Log.error('Error in Action: {}', err)
      status:update(SC.NETWORK_ERROR)
      return
    end
    Log.debug('Action: No more suggestions')
    Log.debug('Action elapsed time: {}', elapsed_time)
    Log.debug('Action depth: {}', depth)
    chat:commit('> Q.E.D.' .. '(' .. elapsed_time .. ' ms)' .. '\n', true)
    current_eval = current_eval + 1
    -- Log.debug('Full chat text: {}', chat.text)
    if #chat.text > 0 then
      -- FIXME: A better status update is needed
      status:update(SC.SUGGESTIONS_READY)
    else
      status:update(SC.NO_MORE_SUGGESTIONS)
    end
  end

  local prompt_opts = {
    window = window,
    buffer = buffer,
    range = { sln - 1, eln - 1 },
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
  local source_info = ' (' .. prompt_preview.filename .. ' ' .. sln .. ':' .. eln .. ')'
  local c_in = '# In`[' .. current_eval .. ']`:= ' .. action_name .. source_info
  chat:commit(c_in)
  chat:commit(prompt_preview.content)

  Promise:new(function(resolve, reject)
    local task_id = tasks:create(0, 0)
    Sessions.request_generate_one_stage(task_id, prompt_opts, function(_, prompt, suggestions)
      -- Log.debug('Suggestions for Actions: {}', suggestions)
      local lines, ms = filter_suggestions(task_id, suggestions)
      if not lines or #lines == 0 then
        reject()
      else
        depth = depth + 1
        elapsed_time = elapsed_time + ms
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

---@param opts? ActionOptions
function ActionsEngine.document_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.DocumentCode, merged)
end

---@param opts? ActionOptions
function ActionsEngine.edit_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  if merged.prompt == nil or #merged.prompt == 0 then
    local input_opts = { prompt = 'Prompt for FittenCode EditCode: ', default = '', }
    vim.ui.input(input_opts, function(prompt)
      Log.debug('Prompt for FittenCode EditCode: ' .. prompt)
      ActionsEngine.start_action(Actions.EditCode, {
        prompt = prompt,
        content = merged.content
      })
    end)
  else
    return ActionsEngine.start_action(Actions.EditCode, merged)
  end
end

---@param opts? ActionOptions
function ActionsEngine.explain_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.ExplainCode, merged)
end

---@param opts? ActionOptions
function ActionsEngine.find_bugs(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.FindBugs, merged)
end

---@param opts? GenerateUnitTestOptions
function ActionsEngine.generate_unit_test(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.GenerateUnitTest, merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_features(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.ImplementFeatures, merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_functions(opts)
  local defaults = {
    feature_type = 'functions'
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.implement_features(merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_classes(opts)
  local defaults = {
    feature_type = 'classes'
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.implement_features(merged)
end

---@param opts? ActionOptions
function ActionsEngine.improve_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.ImproveCode, merged)
end

---@param opts? ActionOptions
function ActionsEngine.refactor_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  return ActionsEngine.start_action(Actions.RefactorCode, merged)
end

-- API: ActionOptions.content
---@param opts? ActionOptions
function ActionsEngine.start_chat(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  if merged.content == nil or #merged.content == 0 then
    local input_opts = { prompt = 'Ask... (Fitten Code Fast): ', default = '', }
    vim.ui.input(input_opts, function(content)
      Log.debug('Ask... (Fitten Code Fast): ' .. content)
      ActionsEngine.start_action(Actions.StartChat, {
        content = content }
      )
    end)
  else
    return ActionsEngine.start_action(Actions.StartChat, merged)
  end
end

local function setup_actions_menu()
  -- vim.cmd([[
  --   anoremenu PopUp.-1- <Nop>
  -- ]])
  if Config.options.action.document_code.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Document\ Code  <Cmd>Fitten document_code<CR>
    ]])
  end
  if Config.options.action.edit_code.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Edit\ Code  <Cmd>Fitten edit_code<CR>
    ]])
  end
  if Config.options.action.explain_code.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Explain\ Code  <Cmd>Fitten explain_code<CR>
    ]])
  end
  if Config.options.action.find_bugs.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Find\ Bugs  <Cmd>Fitten find_bugs<CR>
    ]])
  end
  if Config.options.action.generate_unit_test.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Generate\ UnitTest  <Cmd>Fitten generate_unit_test<CR>
    ]])
  end
  if Config.options.action.start_chat.show_in_editor_context_menu then
    vim.cmd([[
      vnoremenu PopUp.Fitten\ Code\ -\ Start\ Chat  <Cmd>Fitten start_chat<CR>
    ]])
  end
  -- vim.cmd([[
  --   vnoremenu PopUp.DocumentCode  <Cmd>Fitten document_code<CR>
  --   vnoremenu PopUp.EditCode  <Cmd>Fitten edit_code<CR>
  --   vnoremenu PopUp.ExplainCode  <Cmd>Fitten explain_code<CR>
  --   vnoremenu PopUp.FindBugs  <Cmd>Fitten find_bugs<CR>
  --   vnoremenu PopUp.GenerateUnitTest  <Cmd>Fitten generate_unit_test<CR>
  --   vnoremenu PopUp.ImplementFeatures  <Cmd>Fitten implement_features<CR>
  --   vnoremenu PopUp.ImproveCode  <Cmd>Fitten improve_code<CR>
  --   vnoremenu PopUp.RefactorCode  <Cmd>Fitten refactor_code<CR>
  --   vnoremenu PopUp.StartChat  <Cmd>Fitten start_chat<CR>
  -- ]])
end

function ActionsEngine.setup()
  chat = Chat:new()
  tasks = TaskScheduler:new()
  tasks:setup()
  status = Status:new({
    tag = 'ActionsEngine',
    ready_idle = true,
  })
  setup_actions_menu()
end

function ActionsEngine.get_status()
  return status:get_current()
end

function ActionsEngine.stop_eval()
  stop_eval = true
end

return ActionsEngine
