local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local Task = require('fittencode.tasks')

local M = {}

local DEFAULT_DEBOUNCE_TIME = 75

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('Completion'),
    pattern = '*',
    callback = function(args)
      -- Log.debug('CursorHoldI triggered')
      local task_id = Task.create(fn.line('.'), fn.col('.'))
      Base.debounce(function()
        Sessions.completion_request(task_id)
      end, DEFAULT_DEBOUNCE_TIME)
    end,
    desc = 'Triggered when the cursor is held for a period of time without moving the cursor.',
  })

  api.nvim_create_autocmd({ 'CursorMovedI', 'CursorMoved', 'BufWinLeave', 'BufHidden', 'InsertLeave' }, {
    group = Base.augroup('ResetCompletion'),
    pattern = '*',
    callback = function(args)
      Sessions.reset_completion()
    end,
    desc = 'Reset completion',
  })
end

function M.setup_commands()
  local commands = {
    login = Sessions.login,
    logout = Sessions.logout,
  }
  Base.command('Fitten', function(line)
    local actions = line.fargs
    local cmd = commands[actions[1]]
    if cmd then
      table.remove(actions, 1)
      return cmd(unpack(actions))
    end
    Log.error('Invalid command, fargs is %s', line.fargs)
  end, {
    complete = function(_, line)
      local args = vim.split(vim.trim(line), '%s+')
      table.remove(args, 1)
      local prefix = table.remove(args, 1)
      if prefix and line:sub(-1) == ' ' then
        return
      end
      return vim.tbl_filter(function(key)
        return not prefix or key:find(prefix, 1, true) == 1
      end, vim.tbl_keys(commands))      
    end,
    bang = true,
    nargs = '*',
    desc = 'Fitten Command',
  })
end

function M.setup_keymaps()
  Base.map('i', '<tab>', Sessions.chaining_complete)
end

return M
