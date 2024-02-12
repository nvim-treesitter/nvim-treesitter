local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Rest = require('fittencode.rest')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local View = require('fittencode.view')
local Tasks = require('fittencode.tasks')

local M = {}

local URL_LOGIN = 'https://codeuser.fittentech.cn:14443/login'
local URL_GET_FT_TOKEN = 'https://codeuser.fittentech.cn:14443/get_ft_token'
local URL_GENERATE_ONE_STAGE = 'https://codeapi.fittentech.cn:13443/generate_one_stage/'

M.fitten_suggestion = {}

local fitten_suggestion_stage = 0
local event_filter_count = 0

local function record_suggestion(suggestion)
  M.fitten_suggestion = suggestion or {}
  fitten_suggestion_stage = vim.tbl_count(M.fitten_suggestion)
end

local function flush_suggestion()
  record_suggestion()
end

local function get_api_key_store_path()
  local dir = fn.stdpath('data') .. '/fittencode'
  local path = dir .. '/api_key'
  return Base.to_native(dir), Base.to_native(path)
end

local function read_local_api_key_file()
  local _, path = get_api_key_store_path()
  Base.read(path, function(data)
    M.api_key = data:gsub('\n', '')
  end)
end

local function on_curl_signal_callback(signal, output)
  Log.error('curl throw signal {}', signal)
end

local function write_api_key(api_key)
  local dir, path = get_api_key_store_path()
  Base.write_mkdir(api_key, dir, path, function()
    Log.info('Login successful')
    Log.info('API key saved successful, path: {}', path)
  end)
end

local function on_login_api_key_callback(exit_code, output)
  if output == nil or output == '' then
    Log.error('Login failed: Server response without data')
    return
  end

  local fico_data = fn.json_decode(output)
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.error('Login failed: Server response without fico_token field, decoded response: {}', fico_data)
    return
  end

  local api_key = fico_data.data.fico_token
  M.api_key = api_key
  write_api_key(api_key)
end

local function login_with_api_key(user_token)
  if user_token == nil or user_token == '' then
    Log.error('Login failed: Invalid user token')
    return
  end

  local fico_url = URL_GET_FT_TOKEN
  local fico_args = {
    '-s',
    '-H',
    'Authorization: Bearer ' .. user_token,
    fico_url,
  }
  Rest.send({
    cmd = 'curl',
    args = fico_args,
  }, on_login_api_key_callback, on_curl_signal_callback)
end

local function on_login_callback(exit_code, output)
  if output == nil or output == '' then
    Log.error('Login failed: Server response without data')
    return
  end

  local login_data = fn.json_decode(output)
  if login_data.code ~= 200 then
    if login_data.code == nil then
      Log.error('Login failed: Server status code: {}, response: {}', login_data.status_code, login_data)
      return
    else
      Log.error('Login failed: HTTP code: {}, response: {}', login_data.code, login_data)
    end
    return
  end

  local api_key = login_data.data.token
  login_with_api_key(api_key)
end

function M.load_last_session()
  read_local_api_key_file()
end

function M.login(name, password)
  if name == nil or name == '' or password == nil or password == '' then
    Log.error('Invalid username or password')
    return
  end

  local _, path = get_api_key_store_path()
  if Base.exists(path) then
    Log.info('You are already logged in')
    return
  end

  local login_url = URL_LOGIN
  local data = {
    username = name,
    password = password,
  }
  local encoded_data = fn.json_encode(data)
  local login_args = {
    '-s',
    '-X',
    'POST',
    '-H',
    'Content-Type: application/json',
    '-d',
    encoded_data,
    login_url,
  }
  Rest.send({
    cmd = 'curl',
    args = login_args,
  }, on_login_callback, on_curl_signal_callback)
end

function M.logout()
  local _, path = get_api_key_store_path()
  if not Base.exists(path) then
    Log.info('You are already logged out')
    return
  end

  uv.fs_unlink(path, function(err)
    if err then
      Log.error('Failed to delete API key file, path: {}, error: {}', path, err)
      Log.error('Logout failed')
    else
      Log.info('Delete API key file successful, path: {}', path)
      Log.info('Logout successful')
    end
  end)
end

local function generate_suggestion(generated_text)
  local lines = vim.split(fn.substitute(generated_text, '<.endoftext.>', '', 'g'), '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    return
  end

  if string.len(lines[#lines]) == 0 then
    table.remove(lines, #lines)
  end

  local suggestion = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '\n')
    for _, part in ipairs(parts) do
      table.insert(suggestion, part)
    end
  end
  return suggestion
end

local function on_completion_callback(exit_code, response, data)
  if response == nil or response == '' then
    return
  end

  if not Tasks.match(data.task_id, fn.line('.'), fn.col('.')) then
    return
  end

  local completion_data = fn.json_decode(response)
  if completion_data.generated_text == nil then
    return
  end

  local suggestion = generate_suggestion(completion_data.generated_text)
  record_suggestion(suggestion)
  View.render_virt_text(suggestion)
end

local function on_completion_delete_tempfile_callback(data)
  local path = data.path
  uv.fs_unlink(path, function(err)
    if err then
      Log.error('Failed to delete HTTP temporary file, path: {}, error: {}', path, err)
    end
  end)
end

function M.completion_request(task_id)
  if M.api_key == nil or M.api_key == '' then
    return
  end

  flush_suggestion()

  if not Lsp.is_active() then
    M.do_completion_request(task_id)
  end
end

local function make_completion_request_params()
  local filename = api.nvim_buf_get_name(api.nvim_get_current_buf())
  if filename == nil or filename == '' then
    filename = 'NONAME'
  end

  local cursor = api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1
  local col = cursor[2]
  local prefix = table.concat(api.nvim_buf_get_text(0, 0, 0, line, col, {}), '\n')
  local suffix = table.concat(api.nvim_buf_get_text(0, line, col, -1, -1, {}), '\n')
  local prompt = '!FCPREFIX!' .. prefix .. '!FCSUFFIX!' .. suffix .. '!FCMIDDLE!'
  local escaped_prompt = string.gsub(prompt, '"', '\\"')
  local params = {
    inputs = escaped_prompt,
    meta_datas = {
      filename = filename,
    },
  }
  return params
end

function M.do_completion_request(task_id)
  local encoded_params = fn.json_encode(make_completion_request_params())
  Base.write_temp_file(encoded_params, function(path)
    local server_addr = URL_GENERATE_ONE_STAGE
    local completion_args = {
      '-s',
      '-X',
      'POST',
      '-H',
      'Content-Type: application/json',
      '-d',
      '@' .. Base.to_native(path),
      server_addr .. M.api_key .. '?ide=vim&v=0.1.0',
    }
    Rest.send({
      cmd = 'curl',
      args = completion_args,
      data = {
        path = path,
        task_id = task_id,
      },
    }, on_completion_callback, on_curl_signal_callback, on_completion_delete_tempfile_callback)
  end)
end

function M.has_suggestion()
  return vim.tbl_count(M.fitten_suggestion) ~= 0
end

function M.chaining_complete()
  if not M.has_suggestion() then
    return
  end

  event_filter_count = 0
  View.clear_virt_text()
  View.set_text(M.fitten_suggestion)

  M.reset_completion()
end

function M.accept_line()
  if not M.has_suggestion() then
    return
  end

  -- InsertLeave CursorMoved InsertLeave CursorHoldI
  event_filter_count = 4
  View.clear_virt_text()

  local line = table.remove(M.fitten_suggestion, 1)
  local cur = vim.tbl_count(M.fitten_suggestion)
  local stage = fitten_suggestion_stage - 1

  if cur == stage then
    View.set_text({ line })
    View.set_text({ '', '' })
  else
    if cur == 0 then
      View.set_text({ line })
    else
      View.set_text({ line, '' })
    end
  end

  if vim.tbl_count(M.fitten_suggestion) > 0 then
    View.render_virt_text(M.fitten_suggestion)
  else
    M.reset_completion()
  end
end

local function is_alpha(char)
  local byte = char:byte()
  return (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122)
end

local function is_space(char)
  local byte = string.byte(char)
  return byte == 32 or byte == 9
end

local function next_indices(line)
  local pa = nil
  for i = 1, string.len(line) do
    local char = string.sub(line, i, i)
    local a = is_alpha(char)
    local s = is_space(char)
    if i == 1 and not a and not s then
      return i
    end
    if pa ~= nil and ((not pa and a) or (pa and s) or (not a and not s)) then
      return i - 1
    end
    pa = a
  end
  return string.len(line)
end

function M.accept_word()
  if not M.has_suggestion() then
    return
  end

  -- InsertLeave CursorMoved CursorMovedI CursorHoldI
  event_filter_count = 4
  View.clear_virt_text()

  local line = M.fitten_suggestion[1]
  local indices = next_indices(line)
  local word = string.sub(line, 1, indices)
  line = string.sub(line, string.len(word) + 1)

  if string.len(line) == 0 then
    table.remove(M.fitten_suggestion, 1)
    if M.has_suggestion() then
      View.set_text({ word, '' })
    else
      View.set_text({ word })
    end
  else
    M.fitten_suggestion[1] = line
    View.set_text({ word })
  end

  if vim.tbl_count(M.fitten_suggestion) > 0 then
    View.render_virt_text(M.fitten_suggestion)
  else
    M.reset_completion()
  end
end

function M.fetch_sub_efc(event)
  local v = event_filter_count
  event_filter_count = math.max(event_filter_count - 1, 0)
  return v
end

function M.reset_completion()
  event_filter_count = 0
  flush_suggestion()
  View.clear_virt_text()
end

return M
