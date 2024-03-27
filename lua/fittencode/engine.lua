local api = vim.api

local Base = require('fittencode.base')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local View = require('fittencode.view')
local TaskScheduler = require('fittencode.tasks')
local Sessions = require('fittencode.sessions')
local SuggestionsCache = require('fittencode.suggestions_cache')
local Config = require('fittencode.config')

local M = {}

---@class SuggestionsCache
local cache = nil

---@class TaskScheduler
local tasks = nil

local inline_mode = true

function M.setup()
  cache = SuggestionsCache:new()
  tasks = TaskScheduler:new()
  tasks:setup()
  inline_mode = Config.options.completion_mode == 'inline'
end

---@param suggestions string[]
local function condense_nl(suggestions)
  local row = Base.get_cursor()
  local prev_line = nil
  local cur_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if row > 1 then
    prev_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  end
  if (not prev_line or #prev_line == 0) and (#cur_line == 0) then
    while suggestions[1] and #suggestions[1] == 0 do
      table.remove(suggestions, 1)
    end
  end
end

---@param task_id integer
---@param suggestions? Suggestions
---@return boolean
local function on_suggestions(task_id, suggestions)
  local row, col = Base.get_cursor()
  if not tasks:match_clean(task_id, row, col) then
    Log.debug('Completion request is outdated, discarding; task_id: {}, row: {}, col: {}', task_id, row, col)
    return false
  end

  if not suggestions or #suggestions == 0 then
    Log.debug('No more suggestions')
    return false
  end

  Log.debug('Suggestions received; task_id: {}, suggestions: {}', task_id, suggestions)

  condense_nl(suggestions)

  Log.debug('Condensed suggestions: {}', suggestions)

  if #suggestions == 0 then
    return false
  end

  cache:update(task_id, row, col, suggestions)

  if inline_mode then
    if Lsp.is_active() then
      Log.debug('LSP is active, discarding completion suggestions')
      cache:flush()
      return false
    else
      -- TODO: Silence LSP temporarily to avoid completion conflicts
      -- Lsp.silence()
      View.render_virt_text(suggestions)
    end
  end

  return true
end

local function lazy_inline_completion()
  local is_advance = function(row, col)
    local cached_row, cached_col = cache:get_cursor()
    return cached_row == row and cached_col + 1 == col
  end
  local row, col = Base.get_cursor()
  if is_advance(row, col) then
    local cur_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local cache_line = cache:get_line(1)
    if not cache_line then
      return false
    end
    local cur_char = string.sub(cur_line, col, col)
    local cache_char = string.sub(cache_line, 1, 1)
    if cur_char == cache_char then
      Lsp.silence()
      cache_line = string.sub(cache_line, 2)
      cache:update_line(1, cache_line)
      cache:update_cursor(row, col)
      View.render_virt_text(cache:get_lines())
      return true
    end
  end
  return false
end

---@param row integer
---@param col integer
---@param force? boolean
---@param on_suggestions_ready? function
---@param on_error? function
function M.generate_one_stage(row, col, force, on_suggestions_ready, on_error)
  Log.debug('Start generate one stage...')

  if not Sessions.ready_for_generate() then
    Log.debug('Not ready for generate')
    if on_error then
      on_error()
    end
    return
  end

  local cur_row, cur_col = Base.get_cursor()
  if cur_row ~= row or cur_col ~= col then
    Log.debug('Cursor changed; requested cursor row: {}, col: {}; current cursor row: {}, col: {}', row, col, cur_row, cur_col)
    if on_error then
      on_error()
    end
    return
  end

  if not force and cache:equal_cursor(row, col) then
    Log.debug('Cached cursor is equal to requested cursor; cached cursor row: {}, col: {}', cache:get_cursor())
    if on_error then
      on_error()
    end
    return
  else
    Log.debug('Cached cursor is outdated, requested cursor row: {}, col: {}; cached cursor row: {}, col: {}', row, col, cache:get_cursor())
  end

  if inline_mode then
    if Lsp.is_active() then
      Log.debug('LSP is active, cancel request generate one stage')
      if on_error then
        on_error()
      end
      return
    end
  end

  local task_id = tasks:create(row, col)
  cache:flush()
  Sessions.request_generate_one_stage(task_id, function(id, suggestions)
    if on_suggestions(id, suggestions) then
      if on_suggestions_ready then
        on_suggestions_ready(suggestions)
      end
    else
      if on_error then
        on_error()
      end
    end
  end, function()
    if on_error then
      on_error()
    end
  end)
end

---@return boolean
function M.has_suggestions()
  return vim.tbl_count(cache:get_lines() or {}) ~= 0
end

---@return SuggestionsCache
function M.get_suggestions()
  return cache
end

local function generate_one_stage_at_cursor()
  M.reset()

  local row, col = Base.get_cursor()
  M.generate_one_stage(row, col, true)
end

function M.accept_all_suggestions()
  Log.debug('Accept all suggestions')

  if not M.has_suggestions() then
    Log.debug('No suggestions')
    return
  end

  Lsp.silence()

  Log.debug('Pretreatment cached lines: {}', cache:get_lines())

  View.clear_virt_text()
  View.set_text(cache:get_lines())

  M.reset()

  Log.debug('Remaining cached lines: {}', cache:get_lines())
end

---@param fx? function
---@return any
local function ignoreevent_wrap(fx)
  -- Out-of-order execution about eventignore and CursorMoved.
  -- https://github.com/vim/vim/issues/8641
  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  local ret = nil
  if fx then
    ret = fx()
  end

  vim.o.eventignore = eventignore
  return ret
end

function M.accept_line()
  Log.debug('Accept line')

  if not M.has_suggestions() then
    Log.debug('No suggestions')
    return
  end

  Lsp.silence()
  View.clear_virt_text()

  ignoreevent_wrap(function()
    Log.debug('Pretreatment cached lines: {}', cache:get_lines())

    local line = cache:remove_line(1)
    local cur = vim.tbl_count(cache:get_lines())
    local stage = cache:get_count() - 1

    if cur == stage then
      View.set_text({ line })
      Log.debug('Set line: {}', line)
      View.set_text({ '', '' })
      Log.debug('Set empty new line')
    else
      if cur == 0 then
        View.set_text({ line })
        Log.debug('Set line: {}', line)
      else
        View.set_text({ line, '' })
        Log.debug('Set line and empty new line; line: {}', line)
      end
    end

    Log.debug('Remaining cached lines: {}', cache:get_lines())

    if vim.tbl_count(cache:get_lines()) > 0 then
      View.render_virt_text(cache:get_lines())
      local row, col = Base.get_cursor()
      cache:update_cursor(row, col)
    else
      Log.debug('No more suggestions, generate new one stage')
      generate_one_stage_at_cursor()
    end
  end)
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

  if not M.has_suggestions() then
    Log.debug('No suggestions')
    return
  end

  Lsp.silence()
  View.clear_virt_text()

  ignoreevent_wrap(function()
    Log.debug('Pretreatment cached lines: {}', cache:get_lines())

    local line = cache:get_line(1)
    if not line then
      Log.debug('No line cached')
      return
    end
    local next_index = next_indices(line)
    local word = string.sub(line, 1, next_index)
    line = string.sub(line, string.len(word) + 1)
    if string.len(line) == 0 then
      cache:remove_line(1)
      if M.has_suggestions() then
        View.set_text({ word, '' })
        Log.debug('Set word and empty new line; word: {}', word)
      else
        View.set_text({ word })
        Log.debug('Set word: {}', word)
      end
    else
      cache:update_line(1, line)
      View.set_text({ word })
      Log.debug('Set word: {}', word)
    end

    Log.debug('Remaining cached lines: {}', cache:get_lines())

    if vim.tbl_count(cache:get_lines()) > 0 then
      View.render_virt_text(cache:get_lines())
      local row, col = Base.get_cursor()
      cache:update_cursor(row, col)
    else
      Log.debug('No more suggestions, generate new one stage')
      generate_one_stage_at_cursor()
    end
  end)
end

function M.reset(reset_lsp)
  if inline_mode then
    View.clear_virt_text()
  end
  cache:flush()
  if inline_mode and reset_lsp then
    Lsp.silence(false)
  end
end

function M.advance()
  if not M.has_suggestions() then
    return
  end

  if not inline_mode then
    return
  end

  if not cache:equal_cursor(Base.get_cursor()) then
    View.clear_virt_text()
    cache:flush()
  end
end

---@return boolean
function M.preflight()
  if not Config.options.inline_completion.enable then
    return false
  end
  local filetype = vim.bo.filetype
  if vim.tbl_contains(Config.options.disable_specific_inline_completion.suffixes, filetype) then
    return false
  end
  return true
end

---@alias lsp.CompletionResponse lsp.CompletionList|lsp.CompletionItem[]

---@param suggestions string
---@return lsp.CompletionResponse|nil
function M.convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
  cursor_before_line = cursor_before_line or ''
  local LABEL_LIMIT = 30
  local label = cursor_before_line .. suggestions
  if #label > LABEL_LIMIT then
    label = string.sub(label, 1, LABEL_LIMIT)
  end
  label = label:gsub('\n', '<\\n>')
  local items = {}
  table.insert(items, {
    label = label,
    word = label,
    textEdit = {
      range = {
        start = { line = line, character = character },
        ['end'] = { line = line, character = character },
      },
      newText = suggestions,
    },
    documentation = {
      kind = 'markdown',
      value = '```' .. vim.bo.ft .. '\n' .. cursor_before_line .. suggestions .. '\n```',
    },
    insertTextMode = 1,
  })
  return { items = items, isIncomplete = false }
end

function M.on_text_changed()
  if inline_mode then
    lazy_inline_completion()
  end
end

return M
