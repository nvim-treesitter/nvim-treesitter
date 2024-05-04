-- References
--   https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
--   https://medium.com/swlh/implement-a-simple-promise-in-javascript-20c9705f197a

-- A Promise is in one of these states:
-- - PENDING: initial state, neither fulfilled nor rejected.
-- - FULFILLED: meaning that the operation was completed successfully.
-- - REJECTED: meaning that the operation failed.
local PromiseState = {
  PENDING = 0,
  FULFILLED = 1,
  REJECTED = 2,
}

-- The `Promise` object represents the eventual completion (or failure) of an asynchronous operation and its resulting value.
---@class Promise
---@field state integer
---@field value any
---@field reason any
---@field promise_reactions table
local Promise = {}

-- Promise() constructor, https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/Promise
---@param executor? function
---@return Promise?
function Promise:new(executor)
  if type(executor) ~= "function" then
    return
  end
  local obj = {
    state = PromiseState.PENDING,
    value = nil,
    reason = nil,
    promise_reactions = { {}, {} },
  }
  local function resolve(value)
    if obj.state == PromiseState.PENDING then
      obj.state = PromiseState.FULFILLED
      obj.value = value
      vim.tbl_map(function(callback)
        callback(obj)
      end, obj.promise_reactions[PromiseState.FULFILLED])
    end
  end
  local function reject(reason)
    if obj.state == PromiseState.PENDING then
      obj.state = PromiseState.REJECTED
      obj.reason = reason
      vim.tbl_map(function(callback)
        callback(obj)
      end, obj.promise_reactions[PromiseState.REJECTED])
    end
  end
  executor(resolve, reject)
  self.__index = self
  return setmetatable(obj, self)
end

-- Promise.prototype.then(), https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/then
-- The then() method of Promise instances takes up to two arguments: callback functions for the fulfilled and rejected cases of the Promise.
-- It immediately returns an equivalent Promise object, allowing you to chain calls to other promise methods.
---@param on_fulfilled? function
---@param on_rejected? function
---@return Promise?
function Promise:forward(on_fulfilled, on_rejected)
  return Promise:new(function(resolve, reject)
    if self.state == PromiseState.PENDING then
      table.insert(self.promise_reactions[PromiseState.FULFILLED], function(promise)
        local last_promise = on_fulfilled and on_fulfilled(promise.value)
        if type(last_promise) == "table" and getmetatable(last_promise) == Promise then
          last_promise:forward(resolve, reject)
        else
          resolve(last_promise)
        end
      end)
      table.insert(self.promise_reactions[PromiseState.REJECTED], function(promise)
        local last_promise = on_rejected and on_rejected(promise.reason)
        if type(last_promise) == "table" and getmetatable(last_promise) == Promise then
          last_promise:forward(resolve, reject)
        else
          reject(last_promise)
        end
      end)
    elseif self.state == PromiseState.FULFILLED then
      local last_promise = on_fulfilled and on_fulfilled(self.value)
      if type(last_promise) == "table" and getmetatable(last_promise) == Promise then
        last_promise:forward(resolve, reject)
      else
        resolve(last_promise)
      end
    elseif self.state == PromiseState.REJECTED then
      local last_promise = on_rejected and on_rejected(self.reason)
      if type(last_promise) == "table" and getmetatable(last_promise) == Promise then
        last_promise:forward(resolve, reject)
      else
        reject(last_promise)
      end
    end
  end)
end

return Promise
