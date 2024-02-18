local fn = vim.fn
local api = vim.api
local uv = vim.uv

local M = {}

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

---@param chars string
function M.feedkeys(chars)
  local keys = api.nvim_replace_termcodes(chars, true, false, true)
  api.nvim_feedkeys(keys, 'in', true)
end

---@param name string
function M.augroup(name)
  return api.nvim_create_augroup('Fittencode_' .. name, { clear = true })
end

---@param name string
---@param hi table
function M.set_hi(name, hi)
  hi.force = true
  hi.cterm = hi.cterm or {}
  vim.api.nvim_set_hl(0, name, hi)
end

---@return integer, integer
function M.get_cursor()
  local cursor = api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]
  return row, col
end

---@param timer uv_timer_t|nil
---@param callback function
---@param wait integer
---@param on_error function|nil
function M.debounce(timer, callback, wait, on_error)
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

---@param data string
---@param path string
---@param on_success function|nil
function M.write(data, path, on_success)
  uv.fs_open(path, 'w', 438, function(_, fd)
    if fd ~= nil then
      uv.fs_write(fd, data, -1, function(_, _)
        uv.fs_close(fd, function(_, _) end)
        if on_success then
          vim.schedule(function()
            on_success(path)
          end)
        end
      end)
    end
  end)
end

---@param data string
---@param dir string
---@param path string
---@param on_success function|nil
function M.write_mkdir(data, dir, path, on_success)
  uv.fs_mkdir(dir, 448, function(_, _)
    M.write(data, path, on_success)
  end)
end

---@param data string
---@param on_success function|nil
function M.write_temp_file(data, on_success, on_error)
  local path = fn.tempname()
  if not path then
    if on_error then
      on_error()
    end
    return
  end
  path = M.to_native(path)
  M.write(data, path, on_success)
end

---@param path string
---@param on_success function|nil
function M.read(path, on_success)
  uv.fs_open(path, 'r', 438, function(_, fd)
    if fd ~= nil then
      uv.fs_fstat(fd, function(_, stat)
        if stat ~= nil then
          uv.fs_read(fd, stat.size, -1, function(_, data)
            uv.fs_close(fd, function(_, _) end)
            if on_success then
              vim.schedule(function()
                on_success(data)
              end)
            end
          end)
        end
      end)
    end
  end)
end

---@param file string
---@return boolean
function M.exists(file)
  return uv.fs_stat(file) ~= nil
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
