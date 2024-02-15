local fn = vim.fn
local api = vim.api
local uv = vim.uv

local Base = require('fittencode.base')
local Log = require('fittencode.log')
local Lsp = require('fittencode.lsp')
local View = require('fittencode.view')
local Tasks = require('fittencode.tasks')
local Sessions = require('fittencode.sessions')
local SuggestionCache = require('fittencode.suggestion_cache')

local M = {}

---@class SuggestionCache
local cache = SuggestionCache:new()

local function on_completion_request_done(task_id, suggestion)
  local row, col = Base.get_cursor()
  if not Tasks.match(task_id, row, col, true) then
    return
  end

  cache:update_pos(row, col)
  cache:update_lines(suggestion)
  View.render_virt_text(suggestion)
end

function M.completion_request(row, col, force)
  if not Sessions.validate_current_api_key() then
    return
  end

  if not force and cache:equal_pos(row, col) then
    return
  end

  local task_id = Tasks.create(row, col)
  cache:flush()

  if not Lsp.is_active() then
    Sessions.do_completion_request(task_id, on_completion_request_done)
  end
end

function M.has_suggestion()
  return vim.tbl_count(cache.lines or {}) ~= 0
end

function M.completion_request_at_cursor()
  M.reset_completion()

  local row, col = Base.get_cursor()
  M.completion_request(row, col, true)
end

function M.chaining_complete()
  if not M.has_suggestion() then
    return
  end

  View.clear_virt_text()
  View.set_text(cache.lines)

  M.reset_completion()
end

function M.accept_line()
  if not M.has_suggestion() then
    return
  end

  View.clear_virt_text()

  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  local line = table.remove(cache.lines, 1)
  local cur = vim.tbl_count(cache.lines)
  local stage = cache.count - 1

  if cur == stage then
    View.set_text({ line })
    View.set_text({ '', '' })
  else
    if cur == 0 then
      View.set_text({ line })
    else
      View.set_text({ line, '' })
    end
  end

  api.nvim_command('redraw!')

  if vim.tbl_count(cache.lines) > 0 then
    View.render_virt_text(cache.lines)
  else
    M.completion_request_at_cursor()
  end

  vim.o.eventignore = eventignore

  local row, col = Base.get_cursor()
  cache:update_pos(row, col)
end

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
  if not M.has_suggestion() then
    return
  end

  View.clear_virt_text()

  local eventignore = vim.o.eventignore
  vim.o.eventignore = 'all'

  local line = cache.lines[1]
  local indices = next_indices(line)
  local word = string.sub(line, 1, indices)
  line = string.sub(line, string.len(word) + 1)

  if string.len(line) == 0 then
    table.remove(cache.lines, 1)
    if M.has_suggestion() then
      View.set_text({ word, '' })
    else
      View.set_text({ word })
    end
  else
    cache.lines[1] = line
    View.set_text({ word })
  end

  api.nvim_command('redraw!')

  if vim.tbl_count(cache.lines) > 0 then
    View.render_virt_text(cache.lines)
  else
    M.completion_request_at_cursor()
  end

  vim.o.eventignore = eventignore

  local row, col = Base.get_cursor()
  cache:update_pos(row, col)
end

function M.reset_completion(row, col)
  View.clear_virt_text()
  cache:flush()
end

function M.stage_completion()
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
