local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local View = require('fittencode.view')

local M = {}

local DEFAULT_DEBOUNCE_TIME = 100
local DEFAULT_RESET_DEBOUNCE_TIME = 800

local completion_timer = nil
local reset_completion_timer = nil

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('Completion'),
    pattern = '*',
    callback = function(args)
      local cursor = api.nvim_win_get_cursor(0)
      local line = cursor[1] - 1
      local col = cursor[2]
      Base.debounce(completion_timer, function()
        Sessions.completion_request(line, col)
      end, DEFAULT_DEBOUNCE_TIME)
    end,
    desc = 'Triggered Completion',
  })

  api.nvim_create_autocmd({ 'CursorMovedI', 'CursorMoved', 'InsertLeave' }, {
    group = Base.augroup('StageCompletion'),
    pattern = '*',
    callback = function(args)
      Base.debounce(reset_completion_timer, function()
        Sessions.stage_completion()
      end, DEFAULT_RESET_DEBOUNCE_TIME)
    end,
    desc = 'Stage completion',
  })

  api.nvim_create_autocmd({ 'BufWinLeave', 'BufHidden' }, {
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
    Log.error('Invalid command, fargs: {}', line.fargs)
  end, {
    complete = function(_, line)
      local args = vim.split(vim.trim(line), '%s+')
      if vim.tbl_count(args) > 2 then
        return
      end
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
  Base.map('i', '<Tab>', function()
    if Sessions.has_suggestion() then
      Sessions.chaining_complete()
    else
      View.feed_tab()
    end
  end)
  Base.map('i', '<C-Down>', function()
    if Sessions.has_suggestion() then
      Sessions.accept_line()
    end
  end)
  Base.map('i', '<C-Right>', function()
    if Sessions.has_suggestion() then
      Sessions.accept_word()
    end
  end)
end

return M
