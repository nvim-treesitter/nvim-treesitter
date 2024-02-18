local Base = require('fittencode.base')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local View = require('fittencode.view')
local TaskScheduler = require('fittencode.tasks')
local Sessions = require('fittencode.sessions')
local SuggestionCache = require('fittencode.suggestion_cache')

local M = {}

---@class SuggestionCache
local cache = nil

---@class TaskScheduler
local tasks = nil

function M.setup()
  cache = SuggestionCache:new()
  tasks = TaskScheduler:new()
  tasks:setup()
end

-- Callback function for when suggestion is ready
---@param task_id integer
---@param suggestion Suggestion
local function on_suggestion(task_id, suggestion)
  local row, col = Base.get_cursor()
  if not tasks:match_clean(task_id, row, col) then
    Log.debug('Completion request is outdated, discarding; task_id: {}, row: {}, col: {}', task_id, row, col)
    return
  end

  cache:update_pos(row, col)
  cache:update_lines(suggestion)
  View.render_virt_text(suggestion)
end

-- Generate one stage completion
-- If force is true, generate completion even if cursor position is not changed
-- If force is false, generate completion only if cursor position is changed
-- If LSP is active, stop request generate one stage
---@param row integer
---@param col integer
---@param force boolean|nil
function M.generate_one_stage(row, col, force)
  if not Sessions.ready_for_generate() then
    Log.debug('Not ready for generate')
    return
  end

  if not force and cache:equal_pos(row, col) then
    return
  end

  if Lsp.is_active() then
    Log.debug('LSP is active, cancel request generate one stage')
    return
  end

  local task_id = tasks:create(row, col)
  cache:flush()
  Sessions.request_generate_one_stage(task_id, on_suggestion)
end

-- Check if there is any suggestion
function M.has_suggestion()
  return vim.tbl_count(cache.lines or {}) ~= 0
end

-- Generate one stage completion at cursor position
local function generate_one_stage_at_cursor()
  M.reset()

  local row, col = Base.get_cursor()
  M.generate_one_stage(row, col, true)
end

function M.accept_all_suggestion()
  Log.debug('Accept all suggestion')

  if not M.has_suggestion() then
    Log.debug('No suggestion')
    return
  end

  Log.debug('Pretreatment cache.lines: {}', cache.lines)

  View.clear_virt_text()
  View.set_text(cache.lines)

  M.reset()

  Log.debug('Remaining cache.lines: {}', cache.lines)
end

function M.accept_line()
  Log.debug('Accept line')

  if not M.has_suggestion() then
    Log.debug('No suggestion')
    return
  end

  View.clear_virt_text()

  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  Log.debug('Pretreatment cache.lines: {}', cache.lines)

  local line = table.remove(cache.lines, 1)
  local cur = vim.tbl_count(cache.lines)
  local stage = cache.count - 1

  if cur == stage then
    View.set_text({ line })
    Log.debug('Set line; line: {}', line)
    View.set_text({ '', '' })
    Log.debug('Set empty new line')
  else
    if cur == 0 then
      View.set_text({ line })
      Log.debug('Set line; line: {}', line)
    else
      View.set_text({ line, '' })
      Log.debug('Set line and empty new line; line: {}', line)
    end
  end

  Log.debug('Remaining cache.lines: {}', cache.lines)

  if vim.tbl_count(cache.lines) > 0 then
    View.render_virt_text(cache.lines)
    local row, col = Base.get_cursor()
    cache:update_pos(row, col)
  else
    Log.debug('No more suggestion, generate one stage')
    generate_one_stage_at_cursor()
  end

  vim.o.eventignore = eventignore
end

-- Calculate the next word index, split by word boundary
---@param line string
local function next_indices(line)
  local pa = nil
  for i = 1, string.len(line) do
    local char = string.sub(line, i, i)
    local a = Base.is_alpha(char)
    local s = Base.is_space(char)
    if i == 1 and not a and not s then
      return i
    end
    if pa ~= nil and ((not pa and a) or (pa and s) or (not a and not s)) then
      return i - 1
    end
    pa = a
  end
  return string.len(line)
end

function M.accept_word()
  Log.debug('Accept word')

  if not M.has_suggestion() then
    Log.debug('No suggestion')
    return
  end

  View.clear_virt_text()

  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  Log.debug('Pretreatment cache.lines: {}', cache.lines)

  local line = cache.lines[1]

  -- Calculate the next word index
  local next_index = next_indices(line)

  -- Set text
  local word = string.sub(line, 1, next_index)
  line = string.sub(line, string.len(word) + 1)
  if string.len(line) == 0 then
    table.remove(cache.lines, 1)
    if M.has_suggestion() then
      View.set_text({ word, '' })
      Log.debug('Set word and empty new line; word: {}', word)
    else
      View.set_text({ word })
      Log.debug('Set word; word: {}', word)
    end
  else
    cache.lines[1] = line
    View.set_text({ word })
    Log.debug('Set word; word: {}', word)
  end

  Log.debug('Remaining cache.lines: {}', cache.lines)

  if vim.tbl_count(cache.lines) > 0 then
    View.render_virt_text(cache.lines)
    local row, col = Base.get_cursor()
    cache:update_pos(row, col)
  else
    Log.debug('No more suggestion, generate one stage')
    generate_one_stage_at_cursor()
  end

  vim.o.eventignore = eventignore
end

-- Reset suggestion cache and view
function M.reset()
  View.clear_virt_text()
  cache:flush()
end

-- Advance to next suggestion
function M.advance()
  if not M.has_suggestion() then
    return
  end

  View.clear_virt_text()
  if cache:equal_pos(Base.get_cursor()) then
    View.render_virt_text(cache.lines)
  else
    cache:flush()
  end
end

return M
