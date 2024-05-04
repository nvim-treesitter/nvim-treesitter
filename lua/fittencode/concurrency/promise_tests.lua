local Promise = require('promise')

local count = 1

local function run_case(func)
  print('Test case', count)
  func()
  print('Test case', count, 'done')
  count = count + 1
end

local function print_state(promise)
  local strings = {
    'Pending',
    'Fulfilled',
    'Rejected'
  }
  print(strings[promise.state + 1])
end

run_case(function()
  -- Expected output: 1 2 3
  local promise = Promise:new(function(resolve, reject)
    print(1)
    resolve(2)
  end):forward(function(value)
    print(value)
    return Promise:new(function(resolve, reject)
      print(3)
      resolve(4)
    end)
  end)
  -- Expected output: 4
  print(promise.value)
end)

run_case(function()
  -- Expected output: 1 2 nil
  local promise = Promise:new(function(resolve, reject)
    print(1)
    resolve(2)
  end):forward(function(value)
    print(value)
  end):forward(function(value)
    print(value)
  end)
  -- Expected output: Fulfilled
  print_state(promise)
end)
