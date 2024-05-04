local fn = vim.fn

local Base = require('fittencode.base')
local Config = require('fittencode.config')
local KeyStorage = require('fittencode.key_storage')
local Log = require('fittencode.log')
local Path = require('fittencode.fs.path')
local PromptProviders = require('fittencode.prompt_providers')
local Rest = require('fittencode.rest')

local schedule = Base.schedule

local M = {}

local KEY_STORE_PATH = Path.to_native(fn.stdpath('data') .. '/fittencode' .. '/api_key.json')

---@type KeyStorage
local key_storage = KeyStorage:new({
  path = KEY_STORE_PATH,
})

-- Current user name, used for mapping to API key
---@type string?
local username = nil

---@param name string
---@param password string
function M.request_login(name, password)
  if name == nil or name == '' or password == nil or password == '' then
    Log.e('Invalid username or password')
    return
  end

  username = name

  local api_key = key_storage:get_key_by_name(username)
  if api_key ~= nil then
    Log.i('You are already logged in')
    return
  end

  local client = Rest:make_client()
  client:login(username, password, function(key)
    key_storage:set_key_by_name(username, key)
    Log.i('Login successful')
  end, function(err)
    Log.e('Failed to login with error: {}', err)
  end)
end

function M.request_logout()
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.i('You are already logged out')
    return
  end
  key_storage:clear()
  username = nil
  Log.i('Logout successful')
end

function M.load_last_session()
  Log.info('Loading last session')
  key_storage:load(function(name)
    username = name
    Log.info('Last session for user {} loaded successful', name)
  end, function()
    Log.info('Last session not found or invalid')
  end)
end

---@alias Suggestions string[] Formated suggesion

---@param generated_text string
---@return Suggestions?
local function generate_suggestions(generated_text)
  local generated_text = fn.substitute(generated_text, '<.endoftext.>', '', 'g') or ''
  local lines = vim.split(generated_text, '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    return
  end

  if string.len(lines[#lines]) == 0 then
    table.remove(lines, #lines)
  end

  ---@type Suggestions
  local suggestions = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '\n')
    for _, part in ipairs(parts) do
      table.insert(suggestions, part)
    end
  end
  return suggestions
end

---@return table|nil
local function make_generate_one_stage_params()
  local result = PromptProviders.get_current_prompt()
  if result == nil then
    return
  end
  if result.within_the_line and (not Config.internal.virtual_text.inline or Config.options.inline_completion.disable_completion_within_the_line) then
    return
  end
  local prompt = '!FCPREFIX!' .. result.prefix .. '!FCSUFFIX!' .. result.suffix .. '!FCMIDDLE!'
  local escaped_prompt = string.gsub(prompt, '"', '\\"')
  local params = {
    inputs = escaped_prompt,
    meta_datas = {
      filename = result.filename,
    },
  }
  return params
end

function M.ready_for_generate()
  return key_storage:get_key_by_name(username) ~= nil
end

---@param task_id integer
---@param on_success function|nil
---@param on_error function|nil
function M.request_generate_one_stage(task_id, on_success, on_error)
  Log.debug('Request generate one stage...')
  local api_key = key_storage:get_key_by_name(username)
  if api_key == nil then
    Log.debug('Key is not found')
    schedule(on_error)
    return
  end
  local params = make_generate_one_stage_params()
  if params == nil then
    schedule(on_error)
    return
  end

  local client = Rest:make_client()
  if client == nil then
    schedule(on_error)
    return
  end
  Log.debug('Client name is: {}', client:get_implementation_name())
  client:generate_one_stage(api_key, params, function(generated_text)
    local suggestions = generate_suggestions(generated_text)
    schedule(on_success, task_id, suggestions)
  end, on_error)
end

return M
