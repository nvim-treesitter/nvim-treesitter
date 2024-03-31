local api = vim.api

local Base = require('fittencode.base')
local Engine = require('fittencode.engine')
local Log = require('fittencode.log')
local API = require('fittencode.api').api

local M = {}

local ADVANCE_DEBOUNCE_TIME = 120
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
      Engine.generate_one_stage(row, col)
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

  api.nvim_create_autocmd({ 'TextChangedI' }, {
    group = Base.augroup('TextChanged'),
    pattern = '*',
    callback = function()
      if not Engine.preflight() then
        return
      end
      Engine.on_text_changed()
    end,
    desc = 'TextChanged',
  })

  api.nvim_create_autocmd({ 'BufLeave', 'InsertLeave', 'CursorMoved' }, {
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
    Log.debug('Invalid command; fargs: {}', line.fargs)
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
  Base.map('i', '<Tab>', API.accept_all_suggestions)
  Base.map('i', '<C-Down>', API.accept_line)
  Base.map('i', '<C-Right>', API.accept_word)
end

return M
