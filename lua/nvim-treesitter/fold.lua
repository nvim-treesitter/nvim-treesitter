local api = vim.api
local utils = require'nvim-treesitter.ts_utils'
local query = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'

local M = {}

-- This is cached on buf tick to avoid computing that multiple times
-- Especially not for every line in the file when `zx` is hit
local folds_levels = utils.memoize_by_buf_tick(function(bufnr)
  local lang = parsers.get_buf_lang(bufnr)
  local max_fold_level = api.nvim_win_get_option(0, 'foldnestmax')

  local matches
  if query.has_folds(lang) then
    matches = query.get_capture_matches(bufnr, "@fold", "folds")
  elseif query.has_locals(lang) then
    matches = query.get_capture_matches(bufnr, "@scope", "locals")
  else
    return {}
  end

  local levels_tmp = {}

  for _, node in ipairs(matches) do
    local start, _, stop, stop_col = node.node:range()

    if stop_col > 0 then
      stop = stop + 1
    end

    -- This can be folded
    -- Fold only multiline nodes that are not exactly the same as previously met folds
    if start ~= stop and not (levels_tmp[start] and levels_tmp[stop]) then
      levels_tmp[start] = (levels_tmp[start] or 0) + 1
      levels_tmp[stop] = (levels_tmp[stop] or 0) - 1
    end

  end

  local levels = {}
  local current_level = 0

  -- We now have the list of fold opening and closing, fill the gaps and mark where fold start
  for lnum=0, api.nvim_buf_line_count(bufnr) do
    local prefix = ''
    local shift = levels_tmp[lnum] or 0

    -- Determine if it's the start of a fold
    if levels_tmp[lnum] and shift >= 0 then
      prefix = '>'
    end

    current_level = current_level + shift

    -- Ignore folds greater than max_fold_level
    if current_level > max_fold_level then
      levels[lnum + 1] = max_fold_level
    else
      levels[lnum + 1] = prefix .. tostring(current_level)
    end
  end

  return levels
end)

function M.get_fold_indic(lnum)
  if not parsers.has_parser() or not lnum then return '0' end

  local buf = api.nvim_get_current_buf()

  local levels = folds_levels(buf) or {}

  return levels[lnum] or '0'
end

return M
