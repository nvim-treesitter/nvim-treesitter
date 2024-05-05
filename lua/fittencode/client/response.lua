local fn = vim.fn

local Log = require('fittencode.log')

local M = {}

---@param response string
---@return string?
function M._on_login_response(response)
  if response == nil or response == '' then
    Log.error('Server response without data')
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON: {}; error: {}', response, result)
    return
  end

  local login_data = result
  if login_data.code ~= 200 then
    if login_data.code == nil then
      Log.error('Server status code: {}; response: {}', login_data.status_code, login_data)
      return
    else
      Log.error('HTTP code: {}; response: {}', login_data.code, login_data)
    end
    return
  end

  return login_data.data.token
end

---@param response string
---@return string?
function M._on_get_ft_token_response(response)
  if response == nil or response == '' then
    Log.error('Server response without data')
    return
  end

  local success, result = pcall(fn.json_decode, response)
  if success == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    return
  end

  local fico_data = result
  if fico_data.data == nil or fico_data.data.fico_token == nil then
    Log.error('Server response without fico_token field; decoded response: {}', fico_data)
    return
  end

  return fico_data.data.fico_token
end

---@param response string?
---@return string?
function M._on_stage_response(response)
  if response == nil or response == '' then
    Log.error('Server response without data')
    return
  end

  local decode_ok, result = pcall(fn.json_decode, response)
  if decode_ok == false then
    Log.error('Server response is not a valid JSON; response: {}, error: {}', response, result)
    return
  end

  local completion_data = result
  if completion_data.generated_text == nil then
    Log.error('Server response without generated_text field; decoded response: {}', completion_data)
    return
  end

  return completion_data.generated_text
end

return M
