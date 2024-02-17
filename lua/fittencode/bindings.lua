local api = vim.api

local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Sessions = require('fittencode.sessions')
local Log = require('fittencode.log')
local View = require('fittencode.view')

local M = {}

local GENERATEONESTAGE_DEBOUNCE_TIME = 80
local ADVANCE_DEBOUNCE_TIME = 80

---@type uv_timer_t
local generate_one_stage_timer = nil
---@type uv_timer_t
local advance_completion_timer = nil

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('GenerateOneStage'),
    pattern = '*',
    callback = function()
      local row, col = Base.get_cursor()
      Base.debounce(generate_one_stage_timer, function()
        Engine.generate_one_stage(row, col)
      end, GENERATEONESTAGE_DEBOUNCE_TIME)
    end,
    desc = 'Generate one stage',
  })

  api.nvim_create_autocmd({ 'CursorMovedI', 'CursorMoved', 'InsertLeave' }, {
    group = Base.augroup('Advance'),
    pattern = '*',
    callback = function()
      Base.debounce(advance_completion_timer, function()
        Engine.advance()
      end, ADVANCE_DEBOUNCE_TIME)
    end,
    desc = 'Advance',
  })

  api.nvim_create_autocmd({ 'BufWinLeave', 'BufHidden' }, {
    group = Base.augroup('Reset'),
    pattern = '*',
    callback = function()
      Engine.reset()
    end,
    desc = 'Reset',
  })
end

---@class FittenCommands
---@field login function
---@field logout function

function M.setup_commands()
  ---@type FittenCommands
  local commands = {
    login = Sessions.request_login,
    logout = Sessions.request_logout,
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
      Engine.accept_all_suggestion()
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
