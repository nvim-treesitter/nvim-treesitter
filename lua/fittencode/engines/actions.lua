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
local MAX_DEPTH = 10

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

---@param action integer
local function get_action_name(action)
  return Base.tbl_key_by_value(Actions, action)
end

---@param action integer
local function get_action_type(action)
  return 'FittenCodePrompt/Actions/' .. get_action_name(action)
end

---@param task_id integer
---@param suggestions Suggestions
---@return Suggestions?, integer?
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

---@param action integer
---@param solved_prefix string
---@param on_error function
local function chain_actions(action, solved_prefix, on_error)
  Log.debug('Chain Action({})...', get_action_name(action))
  if depth >= MAX_DEPTH then
    Log.debug('Max depth reached, stopping evaluation')
    schedule(on_error)
    return
  end
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

local function on_error(err)
  lock = false
  if type(err) == 'table' and getmetatable(err) == NetworkError then
    status:update(SC.NETWORK_ERROR)
    -- Log.error('Error in Action: {}', err)
    chat:commit('```\nError: fetch failed.\n```')
  else
    if depth == 0 then
      status:update(SC.NO_MORE_SUGGESTIONS)
      chat:commit('```\nNo more suggestions.\n```')
      Log.debug('Action: No more suggestions')
    else
      status:update(SC.SUGGESTIONS_READY)
    end
  end
  Log.debug('Action elapsed time: {}', elapsed_time)
  Log.debug('Action depth: {}', depth)
  chat:commit('> Q.E.D.' .. '(' .. elapsed_time .. ' ms)' .. '\n', true)
  current_eval = current_eval + 1
end

---@param line? string
---@return number?
local function find_nospace(line)
  if not line then
    return
  end
  for i = 1, #line do
    if line:sub(i, i) ~= ' ' then
      return i
    end
  end
end

---@param buffer number
---@param start_row number
---@param end_row number
---@return string[]
local function get_tslangs(buffer, start_row, end_row)
  local row = start_row
  local col = 0

  for i = start_row, end_row do
    local line = api.nvim_buf_get_lines(buffer, i, i + 1, false)[1]
    local pos = find_nospace(line)
    if pos then
      row = i
      col = pos
      break
    end
  end

  local info = vim.inspect_pos(buffer, row, col)
  local ts = info.treesitter
  local langs = {}
  for _, node in ipairs(ts) do
    if not vim.tbl_contains(langs, node.lang) then
      langs[#langs + 1] = node.lang
    end
  end
  return langs
end

local vmode = { ['v']=true, ['V']=true, ['<C-V>']=true }

---@param action number
---@param opts? ActionOptions
---@return nil
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

  Log.debug('mode: {}', api.nvim_get_mode().mode)
  if vmode[api.nvim_get_mode().mode] then
    --- Save and restore marks for visual mode
    local m1, m2 = api.nvim_buf_get_mark(buffer, '<'), api.nvim_buf_get_mark(buffer, '>')
    api.feedkeys('', 'nx', false)
    sln, eln = api.nvim_buf_get_mark(buffer, '<')[1], api.nvim_buf_get_mark(buffer, '>')[1]
    api.nvim_buf_set_mark(buffer, '<', m1[1], m1[2], {})
    api.nvim_buf_set_mark(buffer, '>', m2[1], m2[2], {})
  else
    sln, eln = api.nvim_buf_get_mark(buffer, '<')[1], api.nvim_buf_get_mark(buffer, '>')[1]
  end
  Log.debug('sln: {}, eln: {}', sln, eln)

  chat:show()
  fn.win_gotoid(window)

  local filetype = api.nvim_get_option_value('filetype', { buf = buffer })
  Log.debug('Action filetype: {}', filetype)
  local langs = get_tslangs(buffer, sln - 1, eln - 1)
  Log.debug('Action langs: {}', langs)
  if filetype == 'markdown' and #langs >= 2 then
    filetype = vim.tbl_filter(function(lang) return lang ~= 'markdown' end, langs)[1]
  end
  Log.debug('Action filetype: {}', filetype)

  local prompt_opts = {
    window = window,
    buffer = buffer,
    range = { sln - 1, eln - 1 },
    filetype = filetype,
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
  local c_out = '# Out`[' .. current_eval .. ']`='
  chat:commit(c_out)

  Promise:new(function(resolve, reject)
    local task_id = tasks:create(0, 0)
    Sessions.request_generate_one_stage(task_id, prompt_opts, function(_, prompt, suggestions)
      -- Log.debug('Suggestions for Actions: {}', suggestions)
      local lines, ms = filter_suggestions(task_id, suggestions)
      elapsed_time = elapsed_time + ms
      if not lines or #lines == 0 then
        reject()
      else
        depth = depth + 1
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
  ActionsEngine.start_action(Actions.DocumentCode, merged)
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
    ActionsEngine.start_action(Actions.EditCode, merged)
  end
end

---@param opts? ActionOptions
function ActionsEngine.explain_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.ExplainCode, merged)
end

---@param opts? ActionOptions
function ActionsEngine.find_bugs(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.FindBugs, merged)
end

---@param opts? GenerateUnitTestOptions
function ActionsEngine.generate_unit_test(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.GenerateUnitTest, merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_features(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.ImplementFeatures, merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_functions(opts)
  local defaults = {
    feature_type = 'functions'
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.implement_features(merged)
end

---@param opts? ImplementFeaturesOptions
function ActionsEngine.implement_classes(opts)
  local defaults = {
    feature_type = 'classes'
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.implement_features(merged)
end

---@param opts? ActionOptions
function ActionsEngine.improve_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.ImproveCode, merged)
end

---@param opts? ActionOptions
function ActionsEngine.refactor_code(opts)
  local defaults = {
  }
  local merged = vim.tbl_deep_extend('force', defaults, opts or {})
  ActionsEngine.start_action(Actions.RefactorCode, merged)
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
    ActionsEngine.start_action(Actions.StartChat, merged)
  end
end

local function setup_actions_menu()
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

---@return integer
function ActionsEngine.get_status()
  return status:get_current()
end

function ActionsEngine.stop_eval()
  stop_eval = true
end

return ActionsEngine
