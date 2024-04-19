local api = vim.api

-- TODO(lewis6991): write these out to a file
local messages = {} --- @type {[1]: string, [2]: string?, [3]: string}[]

local sev_to_hl = {
  trace = 'DiagnosticHint',
  debug = 'Normal',
  info = 'MoreMsg',
  warn = 'WarningMsg',
  error = 'ErrorMsg',
}

---@param ctx string?
---@return string
local function mkpfx(ctx)
  return ctx and string.format('[nvim-treesitter/%s]', ctx) or '[nvim-treesitter]'
end

--- @class NTSLogModule
--- @field trace fun(fmt: string, ...: any)
--- @field debug fun(fmt: string, ...: any)
--- @field info fun(fmt: string, ...: any)
--- @field warn fun(fmt: string, ...: any)
--- @field error fun(fmt: string, ...: any)
local M = {}

--- @class Logger
--- @field ctx? string
local Logger = {}

M.Logger = Logger

--- @param ctx? string
--- @return Logger
function M.new(ctx)
  return setmetatable({ ctx = ctx }, { __index = Logger })
end

---@param m string
---@param ... any
function Logger:trace(m, ...)
  messages[#messages + 1] = { 'trace', self.ctx, string.format(m, ...) }
end

---@param m string
---@param ... any
function Logger:debug(m, ...)
  messages[#messages + 1] = { 'debug', self.ctx, string.format(m, ...) }
end

---@param m string
---@param ... any
function Logger:info(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'info', self.ctx, m1 }
  api.nvim_echo({ { mkpfx(self.ctx) .. ': ' .. m1, sev_to_hl.info } }, true, {})
end

---@param m string
---@param ... any
function Logger:warn(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'warn', self.ctx, m1 }
  api.nvim_echo({ { mkpfx(self.ctx) .. ' warning: ' .. m1, sev_to_hl.warn } }, true, {})
end

---@param m string
---@param ... any
---@return string
function Logger:error(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'error', self.ctx, m1 }
  api.nvim_echo({ { mkpfx(self.ctx) .. ' error: ' .. m1, sev_to_hl.error } }, true, {})
  return m1
end

local noctx_logger = M.new()

setmetatable(M, {
  __index = function(t, k)
    --- @diagnostic disable-next-line:no-unknown
    t[k] = function(...)
      return noctx_logger[k](noctx_logger, ...)
    end
    return t[k]
  end,
})

function M.show()
  for _, l in ipairs(messages) do
    local sev, ctx, msg = l[1], l[2], l[3]
    local hl = sev_to_hl[sev]
    local text = ctx and string.format('%s(%s): %s', sev, ctx, msg)
      or string.format('%s: %s', sev, msg)
    api.nvim_echo({ { text, hl } }, false, {})
  end
end

return M
