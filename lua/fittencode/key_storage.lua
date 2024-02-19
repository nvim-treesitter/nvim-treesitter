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
  ---@type KeyStorage
  local obj = {
    keys = {},
    path = o.path,
  }
  self.__index = self
  return setmetatable(obj, self)
end

-- Load API key file
-- * if load successful, call `on_success` with API key name
-- * if load failed, call `on_error`
---@param on_success function|nil
---@param on_error function|nil
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

-- Save API key file
-- * if save successful, call `on_success`
-- * if save failed, call `on_error`
---@param on_success function|nil
---@param on_error function|nil
function KeyStorage:save(on_success, on_error)
  local encode_keys = fn.json_encode(self.keys)
  Base.write_mkdir(encode_keys, self.path, function()
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

-- Delete API key file and clear keys
-- * if successful, call `on_success`
-- * if failed, call `on_error`
---@param on_success function|nil
---@param on_error function|nil
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

-- Get API key by name
-- * if `name == nil`, return `nil`
-- * if name not found, return `nil`
---@param name string|nil
---@return string|nil
---@nodiscard
function KeyStorage:get_key_by_name(name)
  if self.keys.name == name then
    return self.keys.key
  end
  return nil
end

-- Set API key by name
-- * if `name == nil` or `key == nil`, do nothing
---@param name string|nil
---@param key string
function KeyStorage:set_key_by_name(name, key)
  if name == nil or key == nil then
    return
  end
  self.keys = { name = name, key = key }
  self:save()
end

return KeyStorage
