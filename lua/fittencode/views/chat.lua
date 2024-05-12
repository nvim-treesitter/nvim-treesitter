local Base = require('fittencode.base')
local Log = require('fittencode.log')

---@class Chat
---@field win? integer
---@field buffer? integer
---@field text? string
---@field show function
---@field commit function
---@field is_repeated function

local M = {}

function M:new()
  local o = {
    text = {}
  }
  self.__index = self
  return setmetatable(o, self)
end

function M:show()
  if self.win == nil then
    self.buffer = vim.api.nvim_create_buf(false, true)
    vim.cmd('topleft vsplit')
    vim.cmd('vertical resize ' .. 40)
    self.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(self.win, self.buffer)
    vim.api.nvim_buf_set_name(self.buffer, 'FittenCodeChat')

    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = self.buffer })
    vim.api.nvim_set_option_value('modifiable', false, { buf = self.buffer })
    vim.api.nvim_set_option_value('wrap', true, { win = self.win })
    vim.api.nvim_set_option_value('linebreak', true, { win = self.win })
    vim.api.nvim_set_option_value('cursorline', true, { win = self.win })
    vim.api.nvim_set_option_value('spell', false, { win = self.win })
    vim.api.nvim_set_option_value('number', false, { win = self.win })
    vim.api.nvim_set_option_value('relativenumber', false, { win = self.win })
    vim.api.nvim_set_option_value('conceallevel', 3, { win = self.win })

    Base.map('n', 'q', function()
      self:close()
    end, { buffer = self.buffer })

    if #self.text > 0 then
      vim.api.nvim_buf_set_lines(self.buffer, 0, -1, false, self.text)
      vim.api.nvim_win_set_cursor(self.win, { #self.text, 0 })
    end
  end
end

function M:close()
  if self.win == nil then
    return
  end
  vim.api.nvim_win_close(self.win, true)
  self.win = nil
  self.buffer = nil
end

function M:commit(text, linebreak)
  local lines = nil
  if type(text) == 'string' then
    lines = vim.split(text, '\n')
  elseif type(text) == 'table' then
    lines = text
  else
    return
  end
  if linebreak and #self.text > 0 and #lines > 0 then
    if lines[1] ~= '' and not string.match(lines[1], '^```') and self.text[#self.text] ~= '' and not string.match(self.text[#self.text], '^```') then
      table.insert(lines, 1, '')
    end
  end
  if self.buffer then
    vim.api.nvim_set_option_value('modifiable', true, { buf = self.buffer })
    if #self.text == 0 then
      vim.api.nvim_buf_set_lines(self.buffer, 0, -1, false, lines)
    else
      vim.api.nvim_buf_set_lines(self.buffer, -1, -1, false, lines)
    end
    vim.api.nvim_set_option_value('modifiable', false, { buf = self.buffer })
  end
  table.move(lines, 1, #lines, #self.text + 1, self.text)
  vim.api.nvim_win_set_cursor(self.win, { #self.text, 0 })
end

local function _sub_match(s, pattern)
  if s == pattern then
    return true
  end
  local rs = string.reverse(s)
  local rp = string.reverse(pattern)
  local i = 1
  while i <= #rs and i <= #rp do
    if rs:sub(i, i) ~= rp:sub(i, i) then
      break
    end
    i = i + 1
  end
  if i > #rs * 0.8 or i > #rp * 0.8 then
    return true
  end
  return false
end

function M:is_repeated(lines)
  return _sub_match(self.text[#self.text], lines[1])
end

return M
