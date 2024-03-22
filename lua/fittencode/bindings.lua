local api = vim.api

local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Log = require('fittencode.log')
local API = require('fittencode.api').api

local M = {}

-- 1. Reduce the emitting of events
-- 2. Wait for the LSP to provide the completion response
local GENERATEONESTAGE_DEBOUNCE_TIME = 80

local ADVANCE_DEBOUNCE_TIME = 80

---@type uv_timer_t
local generate_one_stage_timer = nil

---@type uv_timer_t
local advance_timer = nil

function M.setup_autocmds()
  api.nvim_create_autocmd({ 'CursorHoldI' }, {
    group = Base.augroup('GenerateOneStage'),
    pattern = '*',
    callback = function()
      if not Engine.preflight() then
        return
      end
      local row, col = Base.get_cursor()
      Base.debounce(generate_one_stage_timer, function()
        Engine.generate_one_stage(row, col)
      end, GENERATEONESTAGE_DEBOUNCE_TIME)
    end,
    desc = 'Generate one stage',
  })

  api.nvim_create_autocmd({ 'CursorMovedI' }, {
    group = Base.augroup('Advance'),
    pattern = '*',
    callback = function()
      if not Engine.preflight() then
        return
      end
      Base.debounce(advance_timer, function()
        Engine.advance()
      end, ADVANCE_DEBOUNCE_TIME)
    end,
    desc = 'Advance',
  })

  api.nvim_create_autocmd({ 'BufWinLeave', 'BufHidden', 'InsertLeave', 'CursorMoved' }, {
    group = Base.augroup('Reset'),
    pattern = '*',
    callback = function()
      if not Engine.preflight() then
        return
      end
      Engine.reset(true)
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
    login = API.login,
    logout = API.logout,
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
    API.accept_all_suggestions()
  end)
  Base.map('i', '<C-Down>', function()
    API.accept_line()
  end)
  Base.map('i', '<C-Right>', function()
    API.accept_word()
  end)
end

return M
