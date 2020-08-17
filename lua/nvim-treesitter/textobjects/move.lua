local utils = require'nvim-treesitter.utils'
local shared = require'nvim-treesitter.textobjects.shared'
local attach = require'nvim-treesitter.textobjects.attach'
local api = vim.api

local M = {}

function M.goto_adjacent(query_string, forward, start, same_parent, overlapping_range_ok)
  local bufnr, _, node = shared.textobject_at_point(query_string)
  local adjacent = shared.get_adjacent(forward, node,  query_string, same_parent, overlapping_range_ok, bufnr)

  if adjacent then
    utils.set_jump()

    local adjacent_textobject_range = {adjacent:range()}
    local position
    if start then
      position = { adjacent_textobject_range[1] + 1, adjacent_textobject_range[2] }
    else
      position = { adjacent_textobject_range[3] + 1, adjacent_textobject_range[4] }
    end
    api.nvim_win_set_cursor(api.nvim_get_current_win(), position)
  end
end

-- luacheck: push ignore 631
M.goto_next_start = function(query_string) M.goto_adjacent(query_string, 'forward', 'start', not 'same_parent', 'overlap ok') end
M.goto_next_end = function(query_string) M.goto_adjacent(query_string, 'forward', not 'start', not 'same_parent', 'overlap ok') end
M.goto_previous_start = function(query_string) M.goto_adjacent(query_string, not 'forward', 'start', not 'same_parent', 'overlap ok') end
M.goto_previous_end = function(query_string) M.goto_adjacent(query_string, not 'forward', not 'start', not 'same_parent', 'overlap ok') end
-- luacheck: pop

local normal_mode_functions = {"goto_next_start",
                               "goto_next_end",
                               "goto_previous_start",
                               "goto_previous_end"}

M.attach = attach.make_attach(normal_mode_functions, "move")
M.deattach = attach.make_detach(normal_mode_functions, "move")

return M
