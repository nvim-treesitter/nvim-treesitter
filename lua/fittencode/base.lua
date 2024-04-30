local api = vim.api
local fn = vim.fn
local uv = vim.uv or vim.loop

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
---@return integer, integer
function M.get_cursor()
  local cursor = api.nvim_win_get_cursor(0)
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

-- Refs:
-- * `3rd\luv\library\uv.lua`
---* `3rd\luv\library\errors.lua`
-- * uv.error.name
-- * uv.error.message
---@class UvError
---@field name string
---@field message string

---@param err string
---@return UvError
local function parse_err(err)
  if not err then
    return { name = 'parse_err', message = 'Error is nil' }
  end
  local pos = err:find(':', 1, true)
  local name = err:sub(1, pos - 1)
  local message = err:sub(pos + 2)
  return { name = name, message = message }
end

-- Create a directory if it doesn't exist.
-- * If successful, call `on_success` with the directory path.
-- * If an error occurs, call `on_error` with the error message.
---@param dir string
---@param on_success function|nil
---@param on_error function|nil
function M.mkdir(dir, on_success, on_error)
  uv.fs_mkdir(
    dir,
    448, -- decimal 448 = octal 0700
    ---@param err string|nil
    ---@param success boolean|nil
    function(err, success)
      if err then
        local parsed = parse_err(err)
        if parsed.name ~= 'EEXIST' then
          if on_error then
            vim.schedule(function()
              on_error(parsed)
            end)
          end
          return
        end
      end
      if on_success then
        vim.schedule(function()
          on_success(dir)
        end)
      end
    end
  )
end

-- Write data to a file. Assumes the directory already exists.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.write(data, path, on_success, on_error)
  uv.fs_open(
    path,
    'w',
    438, -- decimal 438 = octal 0666
    ---@param e_open string|nil
    function(e_open, fd)
      if e_open then
        if on_error then
          vim.schedule(function()
            on_error(parse_err(e_open))
          end)
        end
        return
      end
      if fd ~= nil then
        ---@param e_write string|nil
        uv.fs_write(fd, data, -1, function(e_write, _)
          if e_write then
            if on_error then
              vim.schedule(function()
                on_error(parse_err(e_write))
              end)
            end
            return
          end
          uv.fs_close(fd, function(_, _) end)
          if on_success then
            vim.schedule(function()
              on_success(data, path)
            end)
          end
        end)
      end
    end
  )
end

-- Write data to a file, creating the directory if it doesn't exist.
-- * If successful, call `on_success` with the data, file path, and directory path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.write_mkdir(data, path, on_success, on_error)
  local head = fn.fnamemodify(path, ':h')
  if head == nil or head == '' then
    if on_error ~= nil then
      vim.schedule(function()
        on_error({ name = 'fn.fnamemodify', message = 'Failed to get the head of the file name' })
      end)
    end
    return
  end
  M.mkdir(head, function(h)
    M.write(data, path, function(d, p)
      if on_success then
        vim.schedule(function()
          on_success(d, p, h)
        end)
      end
    end, on_error)
  end, on_error)
end

-- Write data to a temporary file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param data string
---@param on_success function|nil
---@param on_error function|nil
function M.write_temp_file(data, on_success, on_error)
  local path = fn.tempname()
  if not path then
    if on_error then
      vim.schedule(function()
        on_error({ name = 'fn.tempname', message = 'Failed to generate temporary file name' })
      end)
    end
    return
  end
  path = M.to_native(path)
  M.write(data, path, function(d, p)
    if on_success then
      vim.schedule(function()
        on_success(d, p)
      end)
    end
  end, on_error)
end

-- Read data from a file.
-- * If successful, call `on_success` with the data and file path.
-- * If an error occurs, call `on_error` with the error message.
---@param path string
---@param on_success function|nil
---@param on_error function|nil
function M.read(path, on_success, on_error)
  uv.fs_open(
    path,
    'r',
    438, -- decimal 438 = octal 0666
    ---@param e_open string|nil
    function(e_open, fd)
      if e_open then
        if on_error then
          vim.schedule(function()
            on_error(parse_err(e_open))
          end)
        end
        return
      end
      if fd ~= nil then
        ---@param e_stat string|nil
        uv.fs_fstat(fd, function(e_stat, stat)
          if e_stat then
            if on_error then
              vim.schedule(function()
                on_error(parse_err(e_stat))
              end)
            end
            return
          end
          if stat ~= nil then
            ---@param e_read string|nil
            uv.fs_read(fd, stat.size, -1, function(e_read, data)
              if e_read then
                if on_error then
                  vim.schedule(function()
                    on_error(parse_err(e_read))
                  end)
                end
                return
              end
              uv.fs_close(fd, function(_, _) end)
              if on_success then
                vim.schedule(function()
                  on_success(data, path)
                end)
              end
            end)
          end
        end)
      end
    end
  )
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
