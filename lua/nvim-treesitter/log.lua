local api = vim.api

local M = {}

-- TODO(lewis6991): write these out to a file
local messages = {} --- @type {[1]: string, [2]: string}[]

local sev_to_hl = {
  trace = 'DiagnosticHint',
  debug = 'Normal',
  info = 'MoreMsg',
  warn = 'WarningMsg',
  error = 'ErrorMsg',
}

---@param m string
---@param ... any
function M.trace(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'trace', m1 }
end

---@param m string
---@param ... any
function M.debug(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'debug', m1 }
end

---@param m string
---@param ... any
function M.info(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'info', m1 }
  local hl = sev_to_hl.info
  api.nvim_echo({ { '[nvim-treesitter]: ' .. m1, hl } }, true, {})
end

---@param m string
---@param ... any
function M.warn(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'warn', m1 }
  local hl = sev_to_hl.warn
  api.nvim_echo({ { '[nvim-treesitter] warning: ' .. m1, hl } }, true, {})
end

---@param m string
---@param ... any
function M.error(m, ...)
  local m1 = string.format(m, ...)
  messages[#messages + 1] = { 'error', m1 }
  error('[nvim-treesitter] error: ' .. m1)
end

function M.show()
  for _, l in ipairs(messages) do
    local hl = sev_to_hl[l[1]]
    api.nvim_echo({ { l[1] .. ': ' .. l[2], hl } }, false, {})
  end
end

return M
