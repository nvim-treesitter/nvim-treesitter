local api = vim.api
local fn = vim.fn

local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local View = require('fittencode.view')

local M = {}

local COMPLETION_DEBOUNCE_TIME = 80
local REST_DEBOUNCE_TIME = 80

local group = Base.augroup('Completion')
local completion_timer = nil
local reset_completion_timer = nil

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = group,
    pattern = '*',
    callback = function(args)
      local row, col = Base.get_cursor()
      Base.debounce(completion_timer, function()
        Engine.completion_request(row, col)
      end, COMPLETION_DEBOUNCE_TIME)
    end,
    desc = 'Triggered Completion',
  })

  api.nvim_create_autocmd({ 'CursorMovedI', 'CursorMoved', 'InsertLeave' }, {
    group = group,
    pattern = '*',
    callback = function(args)
      Base.debounce(reset_completion_timer, function()
        Engine.stage_completion()
      end, REST_DEBOUNCE_TIME)
    end,
    desc = 'Stage completion',
  })

  api.nvim_create_autocmd({ 'BufWinLeave', 'BufHidden' }, {
    group = group,
    pattern = '*',
    callback = function(args)
      Engine.reset_completion()
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
    Log.error('Invalid command; fargs: {}', line.fargs)
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
    if Engine.has_suggestion() then
      Engine.chaining_complete()
    else
      View.feed_tab()
    end
  end)
  Base.map('i', '<C-Down>', function()
    if Engine.has_suggestion() then
      Engine.accept_line()
    end
  end)
  Base.map('i', '<C-Right>', function()
    if Engine.has_suggestion() then
      Engine.accept_word()
    end
  end)
end

return M
