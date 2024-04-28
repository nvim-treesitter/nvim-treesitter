local api = vim.api

local Base = require('fittencode.base')
local Config = require('fittencode.config')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local Sessions = require('fittencode.sessions')
local Status = require('fittencode.status')
local SuggestionsCache = require('fittencode.suggestions_cache')
local TaskScheduler = require('fittencode.tasks')
local View = require('fittencode.view')

local SC = Status.C

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
  if not suggestions or #suggestions == 0 then
    return
  end
  local row, col = Base.get_cursor()
  local prev_line = nil
  local cur_line = api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  if row > 1 then
    prev_line = api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  end

  local nls = {}
  local remove_all = false
  local keep_first = false

  if #cur_line == 0 then
    if not prev_line or #prev_line == 0 then
      remove_all = true
    end
  else
    if col == #cur_line then
      keep_first = true
    end
  end

  if not remove_all and not keep_first then
    return suggestions
  end

  Log.debug('remove_all: {}, keep_first: {}', remove_all, keep_first)

  local is_processed = false
  for i, suggestion in ipairs(suggestions) do
    if #suggestion == 0 and not is_processed then
      if remove_all then
        -- ignore
      elseif keep_first and i ~= 1 then
        -- ignore
      else
        table.insert(nls, suggestion)
      end
    else
      is_processed = true
      table.insert(nls, suggestion)
    end
  end

  return nls
end

---@param suggestions string[]
local function normalize_indent(suggestions)
  if not suggestions or #suggestions == 0 then
    return
  end
  if not vim.bo.expandtab then
    return
  end
  local nor = {}
  for i, suggestion in ipairs(suggestions) do
    -- replace `\t` with space
    suggestion = suggestion:gsub('\t', string.rep(' ', vim.bo.tabstop))
    nor[i] = suggestion
  end
  return nor
end

local function replace_slash(suggestions)
  if not suggestions or #suggestions == 0 then
    return
  end
  local slash = {}
  for i, suggestion in ipairs(suggestions) do
    suggestion = suggestion:gsub('\\"', '"')
    slash[i] = suggestion
  end
  return slash
end

---@param task_id integer
---@param suggestions? Suggestions
---@return Suggestions?
local function process_suggestions(task_id, suggestions)
  local row, col = Base.get_cursor()
  if not tasks:match_clean(task_id, row, col) then
    Log.debug('Completion request is outdated, discarding; task_id: {}, row: {}, col: {}', task_id, row, col)
    return
  end

  if not suggestions or #suggestions == 0 then
    Log.debug('No more suggestions')
    return
  end

  Log.debug('Suggestions received; task_id: {}, suggestions: {}', task_id, suggestions)

  local nls = condense_nl(suggestions)
  if nls then
    suggestions = nls
  end

  local nor = normalize_indent(suggestions)
  if nor then
    suggestions = nor
  end

  local slash = replace_slash(suggestions)
  if slash then
    suggestions = slash
  end

  if #suggestions == 0 then
    return
  end

  Log.debug('Processed suggestions: {}', suggestions)

  return suggestions
end

local function apply_suggestion(task_id, row, col, suggestion)
  if suggestion then
    cache:update(task_id, row, col, suggestion)
    if inline_mode then
      View.render_virt_text(suggestion)
    end
  end
end

local function lazy_inline_completion()
  local is_advance = function(row, col)
    local cached_row, cached_col = cache:get_cursor()
    return cached_row == row and cached_col + 1 == col
  end
  local row, col = Base.get_cursor()
  if is_advance(row, col) then
    local cur_line = api.nvim_buf_get_lines(0, row, row + 1, false)[1]
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
---@param on_success? function
---@param on_error? function
function M.generate_one_stage(row, col, force, on_success, on_error)
  Log.debug('Start generate one stage...')

  Status.update(SC.REQUESTING)

  if not Sessions.ready_for_generate() then
    Log.debug('Not ready for generate')
    if on_error then
      on_error()
    end
    return
  end

  Log.debug('Requested row: {}, col: {}', row, col)
  Log.debug('Cached row: {}, col: {}', cache:get_cursor())

  if not force and cache:equal_cursor(row, col) then
    Log.debug('Cached cursor matches requested cursor')
    if on_error then
      on_error()
    end
    return
  else
    Log.debug('Cached cursor is outdated')
  end

  local task_id = tasks:create(row, col)
  cache:flush()
  Sessions.request_generate_one_stage(task_id, function(id, suggestions)
    local processed = process_suggestions(id, suggestions)
    if processed then
      apply_suggestion(task_id, row, col, processed)
      Status.update(SC.SUGGESTIONS_READY)
    else
      Status.update(SC.NO_MORE_SUGGESTIONS)
    end
    if on_success then
      on_success(processed)
    end
  end, function()
    Status.update(SC.REQUEST_ERROR)
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
  Status.update(SC.IDLE)
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

-- Use `get_word` so that the word is the same as in `core.confirm`
-- https://github.com/hrsh7th/nvim-cmp/pull/1860
---@param suggestions string
---@return lsp.CompletionResponse|nil
function M.convert_to_lsp_completion_response(line, character, cursor_before_line, suggestions)
  cursor_before_line = cursor_before_line or ''
  local LABEL_LIMIT = 80
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
    cmp = {
      kind_text = 'FittenCode',
    },
  })
  return { items = items, isIncomplete = false }
end

function M.on_text_changed()
  if inline_mode then
    lazy_inline_completion()
  end
end

return M
