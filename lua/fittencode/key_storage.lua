local fn = vim.fn
local uv = vim.uv

local Base = require('fittencode.base')
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
  Log.debug('Prepare reading API key file; path: {}', self.path)
  if not Base.exists(self.path) then
    Log.error('API key file not found; path: {}', self.path)
    if on_error then
      on_error()
    end
    return
  end
  Base.read(self.path, function(data)
    self.keys = vim.fn.json_decode(data)
    Log.debug('API key file loaded successful; path: {}', self.path)
    if on_success ~= nil then
      on_success(self.keys.name)
    end
  end, function(err)
    Log.error('Failed to load API key file; path: {}; error: {}', self.path, err)
    if on_error then
      on_error()
    end
  end)
end

function KeyStorage:save(on_success, on_error)
  local encode_keys = fn.json_encode(self.keys)
  local home = fn.fnamemodify(self.path, ':h')
  if home == nil or home == '' then
    Log.error('Failed to save API key file; path: {}', self.path)
    if on_error ~= nil then
      on_error()
    end
    return
  end
  Base.write_mkdir(encode_keys, home, self.path, function()
    Log.info('API key file saved successful; path: {}', self.path)
    if on_success ~= nil then
      on_success()
    end
  end, function(err)
    Log.error('Failed to save API key file; path: {}; error: {}', self.path, err)
    if on_error then
      on_error()
    end
  end)
end

function KeyStorage:clear(on_success, on_error)
  self.keys = {}
  uv.fs_unlink(self.path, function(err)
    if err then
      Log.error('Failed to delete API key file; path: {}; error: {}', self.path, err)
      if on_error then
        on_error()
      end
    else
      Log.info('Delete API key file successful; path: {}', self.path)
      if on_success then
        on_success()
      end
    end
  end)
end

---@param name string|nil
---@return string|nil
function KeyStorage:get_key_by_name(name)
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
