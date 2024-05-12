local Base = require('fittencode.base')
local NetworkError = require('fittencode.client.network_error')
local Process = require('fittencode.concurrency.process')
local Promise = require('fittencode.concurrency.promise')
local RestManager = require('fittencode.rest.manager')
local Resopnse = require('fittencode.client.response')
local URL = require('fittencode.client.url')

local schedule = Base.schedule

---@class FittenClient
---@field rest Rest
---@field register function
---@field get_restimpl_name function
---@field login function
---@field generate_one_stage function
local M = {}

function M:new()
  local obj = {
    rest = RestManager.make_rest()
  }
  self.__index = self
  return setmetatable(obj, self)
end

function M:get_restimpl_name()
  return self.rest:get_implementation_name()
end

function M:register()
  Process.open(URL.REGISTER)
end

function M:login(username, password, on_success, on_error)
  local data = {
    username = username,
    password = password,
  }
  Promise:new(function(resolve, reject)
    self.rest:post(URL.LOGIN, data, function(response)
      resolve(response)
    end, function()
      schedule(on_error)
    end)
  end):forward(function(response)
    return Promise:new(function(resolve, reject)
      local token = Resopnse._on_login_response(response)
      if token ~= nil then
        resolve(token)
      else
        schedule(on_error)
      end
    end)
  end):forward(function(token)
    return Promise:new(function(resolve, reject)
      self.rest:authorize(URL.GET_FT_TOKEN, token, function(response)
        resolve(response)
      end, function()
        schedule(on_error)
      end)
    end)
  end):forward(function(response)
    local fico_token = Resopnse._on_get_ft_token_response(response)
    if fico_token == nil then
      schedule(on_error)
    else
      schedule(on_success, fico_token)
    end
  end)
end

function M:generate_one_stage(api_key, params, on_success, on_error)
  local url = URL.GENERATE_ONE_STAGE .. api_key .. '?ide=neovim&v=0.1.0'
  local data = params

  Promise:new(function(resolve, _)
    self.rest:post(url, data, function(response)
      resolve(response)
    end, function()
      schedule(on_error, NetworkError:new())
    end)
  end):forward(function(response)
    local generated_text = Resopnse._on_stage_response(response)
    if generated_text == nil then
      schedule(on_error)
    else
      schedule(on_success, generated_text)
    end
  end)
end

return M
