local fn = vim.fn
local api = vim.api
local uv = vim.uv

local M = {}

function M.command(name, func, opts)
  opts = opts or {}
  if type(opts) == 'string' then
    opts = { desc = opts }
  end
  api.nvim_create_user_command(name, func, opts)
end

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

function M.hide(namespace, bufnr)
  if namespace ~= nil then
    api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  end
end

local timer = nil

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

function M.debounce(callback, wait)
  if not timer then
    timer = uv.new_timer()
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

function M.write_file(data, path, callback)
  uv.fs_open(path, 'w', 438, function(_, fd)
    if fd ~= nil then
      uv.fs_write(fd, data, -1, function(_, _)
        uv.fs_close(fd, function(_, _) end)
        if callback then
          vim.schedule(function()
            callback(path)
          end)
        end
      end)
    end
  end)
end

function M.write(data, dir, path, callback)
  uv.fs_mkdir(dir, 448, function(_, _)
    M.write_file(data, path, callback)
  end)
end

function M.read(path, callback)
  uv.fs_open(path, 'r', 438, function(_, fd)
    if fd ~= nil then
      uv.fs_fstat(fd, function(_, stat)
        if stat ~= nil then
          uv.fs_read(fd, stat.size, -1, function(_, data)
            uv.fs_close(fd, function(_, _) end)
            vim.schedule(function()
              callback(data)
            end)
          end)
        end
      end)
    end
  end)
end

function M.write_temp_file(data, callback)
  M.write_file(data, fn.tempname(), callback)
end

function M.augroup(name)
  return api.nvim_create_augroup('Fittencode_' .. name, { clear = true })
end

function M.nt_sep()
  return '\\'
end

function M.kernel_sep()
  return '/'
end

function M.is_windows()
  return vim.loop.os_uname().sysname == 'Windows_NT'
end

function M.is_kernel()
  return vim.loop.os_uname().sysname == 'Linux'
end

function M.to_nt(s)
  return s:gsub(M.kernel_sep(), M.nt_sep())
end

function M.to_kernel(s)
  return s:gsub(M.nt_sep(), M.kernel_sep())
end

function M.to_native(s)
  return M.is_windows() and M.to_nt(s) or M.to_kernel(s)
end

return M
