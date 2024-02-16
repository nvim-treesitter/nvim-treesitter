local api = vim.api

local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local View = require('fittencode.view')

local M = {}

local COMPLETION_DEBOUNCE_TIME = 80
local STAGE_DEBOUNCE_TIME = 80

---@type uv_timer_t
local completion_timer = nil
---@type uv_timer_t
local stage_completion_timer = nil

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('TriggeredCompletion'),
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
    group = Base.augroup('StageCompletion'),
    pattern = '*',
    callback = function(args)
      Base.debounce(stage_completion_timer, function()
        Engine.stage_completion()
      end, STAGE_DEBOUNCE_TIME)
    end,
    desc = 'Stage completion',
  })

  api.nvim_create_autocmd({ 'BufWinLeave', 'BufHidden' }, {
    group = Base.augroup('ResetCompletion'),
    pattern = '*',
    callback = function(args)
      Engine.reset_completion()
    end,
    desc = 'Reset completion',
  })
end

---@class FittenCommands
---@field login function
---@field logout function

function M.setup_commands()
  ---@type FittenCommands
  local commands = {
    login = Sessions.login,
    logout = Sessions.logout,
  }
  Base.command('Fitten', function(line)
    ---@type string[]
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
      ---@type string
      local prefix = table.remove(args, 1)
      if prefix and line:sub(-1) == ' ' then
        return
      end
      return vim.tbl_filter(
        ---@param key string
        ---@return boolean
        function(key)
          return not prefix or key:find(prefix, 1, true) == 1
        end,
        vim.tbl_keys(commands)
      )
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
