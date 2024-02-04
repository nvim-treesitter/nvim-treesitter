local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Rest = require('fittencode.rest')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local View = require('fittencode.view')

local M = {}

M.fitten_suggestion = {}

local function read_api_key(data)
  M.api_key = data:gsub('\n', '')
end

local function get_api_key_store_path()
  local dir = fn.stdpath('data') .. '/fittencode'
  local path = dir .. '/api_key'
  return root, path
end

local function read_local_api_key_file()
  local _, path = get_api_key_store_path()
  Base.read(path, read_api_key)
end

local function on_curl_signal_callback(signal, output)
  Log.error('Curl throw signal: %s', signal)
end

local function write_api_key(api_key)
  local dir, path = get_api_key_store_path()
  Base.write_mkdir(api_key, dir, path)
end

local function on_login_api_key_callback(exit_code, output)
  local fico_data = fn.json_decode(output)
  if fico_data.status_code == nil or fico_data.status_code ~= 0 then
    -- TODO: Handle errors
    return
  end
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    -- TODO: Handle errors
    return
  end
  local api_key = fico_data.data.fico_token
  M.api_key = api_key
  write_api_key(api_key)
end

local function login_with_api_key(user_token)
  M.user_token = user_token

  local fico_url = 'https://codeuser.fittentech.cn:14443/get_ft_token'
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
  -- TODO: Handle exit_code
  local login_data = fn.json_decode(output)
  if login_data.code == nil or login_data.code ~= 200 then
    return
  end
  local api_key = login_data.data.token
  login_with_api_key(api_key)
end

function M.load_last_session()
  read_local_api_key_file()
end

function M.login(name, password)
  local login_url = 'https://codeuser.fittentech.cn:14443/login'
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
  uv.fs_unlink(path, function(err)
    if err then
      -- TODO: Handle errors
    else
      M.user_token = nil
    end
  end)
end

local function calculate_text(generated_text)
  local virt_text = {}

  local lines = vim.split(fn.substitute(generated_text, '<.endoftext.>', '', 'g'), '\r')
  if vim.tbl_count(lines) == 0 or (vim.tbl_count(lines) == 1 and string.len(lines[1]) == 0) then
    return
  end

  M.fitten_suggestion = {}

  if string.len(lines[#lines]) == 0 then
    table.remove(lines, #lines)
  end

  local virt_text = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '\n')
    for _, part in ipairs(parts) do
      table.insert(virt_text, { { part, 'Comment' } })
      table.insert(M.fitten_suggestion, part)
    end
  end

  return virt_text
end

local function on_completion_callback(exit_code, response)
  local completion_data = fn.json_decode(response)
  if completion_data.generated_text == nil then
    return
  end

  local virt_text = calculate_text(completion_data.generated_text)
  View.render_virt_text(virt_text)
end

local function on_completion_delete_tempfile_callback(path)
  uv.fs_unlink(path, function(err)
    if err then
      -- TODO: Handle errors
    else
      -- TODO:
    end
  end)
end

function M.completion_request()
  if M.api_key == nil or M.api_key == '' then
    return
  end

  if not Lsp.is_active() then
    M.do_completion_request()
  end
end

function M.do_completion_request()
  local filename = api.nvim_buf_get_name(api.nvim_get_current_buf())
  if filename == nil or filename == '' then
    filename = 'NONAME'
  end
  local prefix = table.concat(api.nvim_buf_get_text(0, 0, 0, fn.line('.') - 1, fn.col('.') - 1, {}), '\n')
  local suffix = table.concat(api.nvim_buf_get_text(0, fn.line('.') - 1, fn.col('.') - 1, fn.line('$') - 1, fn.col('$,$') - 1, {}), '\n')
  local prompt = '!FCPREFIX!' .. prefix .. '!FCSUFFIX!' .. suffix .. '!FCMIDDLE!'
  local escaped_prompt = string.gsub(prompt, '"', '\\"')
  local params = {
    inputs = escaped_prompt,
    meta_datas = {
      filename = filename,
    },
  }
  local encoded_params = fn.json_encode(params)
  Base.write_temp_file(encoded_params, function(path)
    local server_addr = 'https://codeapi.fittentech.cn:13443/generate_one_stage/'
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
      data = path,
    }, on_completion_callback, on_curl_signal_callback, on_completion_delete_tempfile_callback)
  end)
end

function M.chaining_complete()
  if vim.tbl_count(M.fitten_suggestion) == 0 then
    return
  end

  View.clear_virt_text()
  View.set_text(M.fitten_suggestion)

  M.fitten_suggestion = {}
  M.completion_request()
end

return M
