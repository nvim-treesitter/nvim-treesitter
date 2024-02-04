local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Sessions = require('fittencode.sessions')

local M = {}

local fittencode_commands = {
  { 'login', Sessions.login },
  { 'logout', Sessions.logout },
}

local function fittencode_varg(args)
  local actions = vim.split(args.args, ' ')
  for _, c in ipairs(fittencode_commands) do
    if actions[1] == c[1] then
      return c[2](actions[2], actions[3])
    end
  end
  -- TODO: Handle errors
end

local function fittencode_complete()
  local names = {}
  for _, c in ipairs(fittencode_commands) do
    table.insert(names, c[1])
  end
  return names
end

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('Completion'),
    pattern = '*',
    callback = function(args)
      Base.debounce(function()
        Sessions.completion_request()
      end, 800)
    end,
    desc = 'Triggered when the cursor is held for a period of time without moving the cursor.',
  })

  api.nvim_create_autocmd({ 'CursorMovedI', 'CursorMoved', 'BufWinLeave', 'BufHidden', 'InsertLeave' }, {
    group = Base.augroup('Clear'),
    pattern = '*',
    callback = function(args)
      Sessions.clear()
    end,
    desc = 'Clear virtual text.',
  })
end

function M.setup_commands()
  Base.command('Fittencode', fittencode_varg, { complete = fittencode_complete, bang = true, nargs = '*', desc = 'Fittencode Command' })
end

function M.setup_keymaps()
  Base.map('i', '<tab>', Sessions.chaining_complete)
end

return M
