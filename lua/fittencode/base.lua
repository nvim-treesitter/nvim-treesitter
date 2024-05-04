local api = vim.api
local fn = vim.fn
local uv = vim.uv or vim.loop

local M = {}

---@param fx? function
function M.schedule(fx, ...)
  if fx then
    local args = { ... }
    vim.schedule(function()
      fx(unpack(args))
    end)
  end
end

---@param name string
---@param func function
---@param opts table|nil
function M.command(name, func, opts)
  opts = opts or {}
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  api.nvim_create_user_command(name, func, opts)
end

---@param mode string
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  if opts.silent == nil then
    opts.silent = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

---@param name string
function M.augroup(name)
  return api.nvim_create_augroup('FittenCode/' .. name, { clear = true })
end

---@param name string
---@param hi table
function M.set_hi(name, hi)
  if vim.fn.has('nvim-0.10') == 1 then
    -- https://github.com/neovim/neovim/pull/25229
    -- https://github.com/luozhiya/fittencode.nvim/issues/20
    -- hi.force = true
  end
  hi.cterm = hi.cterm or {}
  api.nvim_set_hl(0, name, hi)
end

-- Get current cursor position.
-- * Returns a tuple of row and column.
-- * Row and column are 0-based.
---@param window number|nil
---@return integer, integer
function M.get_cursor(window)
  window = window or api.nvim_get_current_win()
  local cursor = api.nvim_win_get_cursor(window)
  local row = cursor[1] - 1
  local col = cursor[2]
  return row, col
end

-- Debounce a function call.
-- * If a timer is already running, reset it.
-- * If a timer is not running, start a new timer with the given `wait` time.
-- * When the timer expires, call the `callback` function.
-- * If an error occurs, call `on_error` with the error message.
---@param timer uv_timer_t|nil
---@param callback function
---@param wait integer
---@param on_error function|nil
function M.debounce(timer, callback, wait, on_error)
  if type(wait) ~= 'number' or wait < 0 then
    return
  elseif wait == 0 then
    callback()
    return
  end
  local function destroy_timer()
    if timer then
      if timer:has_ref() then
        timer:stop()
        if not timer:is_closing() then
          timer:close()
        end
      end
      timer = nil
    end
  end
  if not timer then
    timer = uv.new_timer()
    if timer == nil then
      if on_error then
        on_error()
      end
      return
    end
    timer:start(
      wait,
      0,
      vim.schedule_wrap(function()
        destroy_timer()
        callback()
      end)
    )
  else
    timer:again()
  end
end

---@return string
function M.nt_sep()
  return '\\'
end

---@return string
function M.kernel_sep()
  return '/'
end

---@return boolean
function M.is_windows()
  return uv.os_uname().sysname == 'Windows_NT'
end

---@return boolean
function M.is_kernel()
  return uv.os_uname().sysname == 'Linux'
end

---@param s string
---@return string
function M.to_nt(s)
  local nt, _ = s:gsub(M.kernel_sep(), M.nt_sep())
  return nt
end

---@param s string
---@return string
function M.to_kernel(s)
  local kernel, _ = s:gsub(M.nt_sep(), M.kernel_sep())
  return kernel
end

---@param s string
---@return string
function M.to_native(s)
  return M.is_windows() and M.to_nt(s) or M.to_kernel(s)
end

---@param char string
---@return boolean
function M.is_alpha(char)
  ---@type integer
  local byte = char:byte()
  return (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122)
end

---@param char string
---@return boolean
function M.is_space(char)
  local byte = string.byte(char)
  return byte == 32 or byte == 9
end

---@class NeovimVersion
---@field nvim string
---@field buildtype string
---@field luajit string

-- Original `version` output:
--   NVIM v0.10.0-dev-2315+g32b49448b
--   Build type: RelWithDebInfo
--   LuaJIT 2.1.1707061634
-- Strucutred as:
--   {
--     nvim = 'v0.10.0-dev-2315+g32b49448b',
--     buildtype = 'RelWithDebInfo',
--     luajit = '2.1.1707061634',
--   }
---@return NeovimVersion|nil
function M.get_version()
  local version = fn.execute('version')
  if not version then
    return nil
  end

  local function find_part(offset, part)
    local start = version:find(part, offset)
    if start == nil then
      return nil
    end
    start = start + #part
    local end_ = version:find('\n', start)
    if end_ == nil then
      end_ = #version
    end
    return start, end_, version:sub(start, end_ - 1)
  end

  local _, end_, nvim = find_part(0, 'NVIM ')
  local _, end_, buildtype = find_part(end_, 'Build type: ')
  local _, _, luajit = find_part(end_, 'LuaJIT ')

  return {
    nvim = nvim,
    buildtype = buildtype,
    luajit = luajit,
  }
end

return M
