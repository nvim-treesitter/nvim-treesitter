local api = vim.api
local utils = require'nvim-treesitter.ts_utils'
local query = require'nvim-treesitter.query'
local parsers = require'nvim-treesitter.parsers'

local M = {}

local folds_levels = utils.memoize_by_buf_tick(function(bufnr)
  local lang = parsers.get_buf_lang(bufnr)

  local matches
  if query.has_fold(lang) then
    matches = query.get_capture_matches(bufnr, "@fold", "fold")
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
    -- Fold only multiline nodes that are not exactly the same as prevsiously met folds
    if start ~= stop and not (levels_tmp[start] and levels_tmp[stop]) then
      levels_tmp[start] = (levels_tmp[start] or 0) + 1
      levels_tmp[stop] = (levels_tmp[stop] or 0) - 1
    end

  end

  local levels = {}
  local current_level = 0

  for lnum=0,api.nvim_buf_line_count(bufnr) do
    current_level = current_level + (levels_tmp[lnum] or 0)
    levels[lnum + 1] = current_level
  end

  return levels
end)

function M.get_fold_indic(lnum)
  if not parsers.has_parser() or not lnum then return '0' end

  local buf = api.nvim_get_current_buf()

  local levels = folds_levels(buf) or {}

  return tostring(levels[lnum] or 0)

end

return M
