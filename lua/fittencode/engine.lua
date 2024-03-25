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

---@param task_id integer
---@param suggestions? Suggestions
---@param generated_text? string
---@return boolean
local function on_suggestions(task_id, suggestions, generated_text)
  if not suggestions then
    Log.debug('No suggestions received; task_id: {}, suggestions: {}', task_id, suggestions)
    return false
  end

  local row, col = Base.get_cursor()
  if not tasks:match_clean(task_id, row, col) then
    Log.debug('Completion request is outdated, discarding; task_id: {}, row: {}, col: {}', task_id, row, col)
    return false
  end

  Log.debug('Suggestions received; task_id: {}, suggestions: {}', task_id, suggestions)

  cache:update_task_id(task_id)
  cache:update_pos(row, col)
  cache:update_lines(suggestions, generated_text)

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
  Log.debug('Lazy inline completion')
  local row, col = Base.get_cursor()
  Log.debug('Current position: row: {}, col: {}', row, col)
  Log.debug('Cached position: row: {}, col: {}', cache:get_pos())
  if cache:is_advance_pos(row, col) then
    local cur_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local cache_line = cache:get_line(1)
    local cur_char = string.sub(cur_line, col, col)
    local cache_char = string.sub(cache_line, 1, 1)
    if cur_char == cache_char then
      Lsp.silence()
      cache_line = string.sub(cache_line, 2)
      cache:update_line(1, cache_line)
      cache:update_pos(row, col)
      View.render_virt_text(cache:get_lines())
      return true
    end
  end
  return false
end

---@param row integer
---@param col integer
---@param force boolean|nil
---@param task_id integer|nil
---@param on_suggestions_ready function|nil
---@param on_error function|nil
function M.generate_one_stage(row, col, force, task_id, on_suggestions_ready, on_error)
  if not Sessions.ready_for_generate() then
    Log.debug('Not ready for generate')
    if on_error then
      on_error()
    end
    return
  end

  local cur_row, cur_col = Base.get_cursor()
  if cur_row ~= row or cur_col ~= col then
    Log.debug('Cursor position changed, skip request generate one stage')
    if on_error then
      on_error()
    end
    return
  end

  if not force and cache:equal_pos(row, col) then
    Log.debug('Equal cached position, skip request generate one stage')
    if on_error then
      on_error()
    end
    return
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

  task_id = task_id or tasks:create(row, col)
  cache:flush()
  Sessions.request_generate_one_stage(task_id, function(id, suggestions, generated_text)
    if on_suggestions(id, suggestions, generated_text) then
      if on_suggestions_ready then
        on_suggestions_ready(generated_text)
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

  Log.debug('Remaining cached lines: {}', cache:get_lines())

  M.reset()
end

function M.accept_line()
  Log.debug('Accept line')

  if not M.has_suggestions() then
    Log.debug('No suggestions')
    return
  end

  Lsp.silence()

  View.clear_virt_text()

  -- Out-of-order execution about eventignore and CursorMoved.
  -- https://github.com/vim/vim/issues/8641
  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  Log.debug('Pretreatment cached lines: {}', cache:get_lines())

  local line = cache:remove_line(1)
  local cur = vim.tbl_count(cache:get_lines())
  local stage = cache:get_count() - 1

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

  Log.debug('Remaining cached lines: {}', cache:get_lines())

  if vim.tbl_count(cache:get_lines()) > 0 then
    View.render_virt_text(cache:get_lines())
    local row, col = Base.get_cursor()
    cache:update_pos(row, col)
  else
    Log.debug('No more suggestions, generate one stage')
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

  if not M.has_suggestions() then
    Log.debug('No suggestions')
    return
  end

  Lsp.silence()
  View.clear_virt_text()

  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  Log.debug('Pretreatment cached lines: {}', cache:get_lines())

  local line = cache:get_line(1)
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
      Log.debug('Set word; word: {}', word)
    end
  else
    cache:update_line(1, line)
    View.set_text({ word })
    Log.debug('Set word; word: {}', word)
  end

  Log.debug('Remaining cached lines: {}', cache:get_lines())

  if vim.tbl_count(cache:get_lines()) > 0 then
    View.render_virt_text(cache:get_lines())
    local row, col = Base.get_cursor()
    cache:update_pos(row, col)
  else
    Log.debug('No more suggestions, generate one stage')
    generate_one_stage_at_cursor()
  end

  vim.o.eventignore = eventignore
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

  local row, col = Base.get_cursor()
  if cache:equal_pos(row, col) then
    View.render_virt_text(cache:get_lines())
  else
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

---@param row integer
---@param col integer
---@return integer
function M.create_task(row, col)
  return tasks:create(row, col)
end

---@param suggestions string
---@return lsp.CompletionResponse|nil
function M.convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
  Log.debug('Suggestions: {}', suggestions)
  suggestions = suggestions or cache:get_generated_text() or ''
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
