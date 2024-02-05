local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local Task = require('fittencode.tasks')

local M = {}

local DEFAULT_DEBOUNCE_TIME = 75

local fittencode_commands = {
  { 'login', Sessions.login },
  { 'logout', Sessions.logout },
}

local function fittencode_varg(line)
  local actions = line.fargs
  for _, cmd in ipairs(fittencode_commands) do
    if actions[1] == cmd[1] then
      table.remove(actions, 1)
      return cmd[2](unpack(actions))
    end
  end
  Log.error('Invalid command, fargs is %s', line.fargs)
end

local function fittencode_complete(_, line)
  local args = vim.split(vim.trim(line), '%s+')
  if vim.tbl_count(args) ~= 2 then
    return
  end
  local entries = {}
  for _, cmd in ipairs(fittencode_commands) do
    table.insert(entries, cmd[1])
  end
  return entries
end

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
  Base.command('Fitten', fittencode_varg, { complete = fittencode_complete, bang = true, nargs = '*', desc = 'Fitten Command' })
end

function M.setup_keymaps()
  Base.map('i', '<tab>', Sessions.chaining_complete)
end

return M
