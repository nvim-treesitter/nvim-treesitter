local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Log = require('fittencode.log')

---@class Key
---@field name string|nil
---@field key string|nil

---@class KeyStorageOptions
---@field path string

-- API Key Storage Service
---@class KeyStorage
---@field keys Key
---@field path string
local KeyStorage = {}

---@param o KeyStorageOptions
function KeyStorage:new(o)
  local obj = {}
  obj.keys = {}
  obj.path = o.path
  self.__index = self
  return setmetatable(obj, self)
end

function KeyStorage:load(on_success, on_error)
  if fn.filereadable(self.path) == 1 then
    local file = io.open(self.path, 'r')
    if file == nil then
      if on_error ~= nil then
        on_error()
      end
      return
    end
    local json_str = file:read('*all')
    file:close()
    self.keys = vim.fn.json_decode(json_str)
    if on_success ~= nil then
      on_success(self.keys.name)
    end
  else
    self.keys = {}
    if on_error ~= nil then
      on_error()
    end
  end
end

function KeyStorage:save()
  local json_str = vim.fn.json_encode(self.keys)
  local home = fn.fnamemodify(self.path, ':h')
  fn.mkdir(home, 'p')
  local file = io.open(self.path, 'w')
  if file == nil then
    Log:error('Failed to save API key file')
    return
  end
  file:write(json_str)
  file:close()
end

function KeyStorage:clear()
  self.keys = {}
  if fn.filereadable(self.path) == 1 then
    fn.delete(self.path)
  end
end

---@param name string
---@return string|nil
function KeyStorage:get_key_by_name(name)
  if name == nil then
    return nil
  end
  if self.keys.name == name then
    return self.keys.key
  end
  return nil
end

---@param name string
---@param key string
function KeyStorage:set_key_by_name(name, key)
  if name == nil or key == nil then
    return
  end
  self.keys = { name = name, key = key }
  self:save()
end

return KeyStorage
