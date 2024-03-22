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

-- Callback function for when suggestions is ready
---@param task_id integer
---@param suggestions Suggestions
local function on_suggestions(task_id, suggestions, generated_text)
  local row, col = Base.get_cursor()
  if not tasks:match_clean(task_id, row, col) then
    Log.debug('Completion request is outdated, discarding; task_id: {}, row: {}, col: {}', task_id, row, col)
    return
  end

  Log.debug('Suggestions received; task_id: {}, suggestions: {}', task_id, suggestions)

  cache:update_task_id(task_id)
  cache:update_pos(row, col)
  cache:update_lines(suggestions, generated_text)

  if inline_mode then
    View.render_virt_text(suggestions)
  end
end

-- Generate one stage completion
---@param row integer
---@param col integer
---@param force boolean|nil
---@param task_id integer|nil
---@param on_suggestions_ready function|nil
function M.generate_one_stage(row, col, force, task_id, on_suggestions_ready)
  if not Sessions.ready_for_generate() then
    Log.debug('Not ready for generate')
    return
  end

  if not force and cache:equal_pos(row, col) then
    Log.debug('Equal position, skip request generate one stage')
    return
  end

  if inline_mode then
    if Lsp.is_active() then
      Log.debug('LSP is active, cancel request generate one stage')
      return
    else
      -- TODO: Silence LSP temporarily to avoid completion conflicts
      -- Lsp.silence()
      Log.debug('Silence LSP temporarily to avoid completion conflicts')
    end
  end

  task_id = task_id or tasks:create(row, col)
  cache:flush()
  Sessions.request_generate_one_stage(task_id, function(id, suggestions, generated_text)
    on_suggestions(id, suggestions, generated_text)
    if on_suggestions_ready then
      on_suggestions_ready(generated_text)
    end
  end)
end

---@return boolean
function M.has_suggestions()
  return vim.tbl_count(cache.lines or {}) ~= 0
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

  Log.debug('Pretreatment cache.lines: {}', cache.lines)

  View.clear_virt_text()
  View.set_text(cache.lines)

  Log.debug('Remaining cache.lines: {}', cache.lines)

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

  Log.debug('Pretreatment cache.lines: {}', cache.lines)

  local line = cache.lines[1]

  -- Calculate the next word index
  local next_index = next_indices(line)

  -- Set text
  local word = string.sub(line, 1, next_index)
  line = string.sub(line, string.len(word) + 1)
  if string.len(line) == 0 then
    table.remove(cache.lines, 1)
    if M.has_suggestions() then
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
    Log.debug('No more suggestions, generate one stage')
    generate_one_stage_at_cursor()
  end

  vim.o.eventignore = eventignore
end

-- Reset suggestions cache and view
function M.reset(reset_lsp)
  if inline_mode then
    View.clear_virt_text()
  end
  cache:flush()
  if inline_mode and reset_lsp then
    Lsp.silence(false)
  end
end

-- Advance to next suggestions
function M.advance()
  if not M.has_suggestions() then
    return
  end

  View.clear_virt_text()
  if cache:equal_pos(Base.get_cursor()) then
    View.render_virt_text(cache.lines)
  else
    cache:flush()
  end
end

-- Preflight checking
-- Check if the environment is ready for completion
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

local function is_spaces(line)
  return line:find('^%s*$') ~= nil
end

local function is_last_char_space(line)
  return string.sub(line, -1) == ' '
end

---@param row integer
---@param col integer
---@return integer
function M.create_task(row, col)
  return tasks:create(row, col)
end

-- Convert suggestions to LSP items
-- `nvim-cmp`: lua\cmp\core.lua
---@param suggestions string
---@return lsp.CompletionResponse|nil
function M.convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
  Log.debug('Suggestions: {}', suggestions)
  suggestions = suggestions or cache.generated_text or ''
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

return M
