local parsers = require "nvim-treesitter.parsers"
local ts_utils = require "nvim-treesitter.ts_utils"

local M = {}

local function is_statusline_scope(node, type_patterns)
  if not node then
    return false
  end

  local node_type = node:type()
  for _, pattern in ipairs(type_patterns) do
    if node_type:find(pattern) then
      return true
    end
  end
  return false
end

-- default post-processing: trim spaces, new lines, trailing braces
local transform_line = function(line)
  return line:gsub("%s*[%[%(%{]*%s*$", ""):gsub("%s+", " ")
end

function M.statusline(opts)
  if not parsers.has_parser() then
    return
  end
  local options = opts or {}
  if type(opts) == "number" then
    options = { indicator_size = opts }
  end
  local bufnr = options.bufnr or 0
  local indicator_size = options.indicator_size or 100
  local type_patterns = options.type_patterns or { "namespace", "class", "struct", "function", "method" }
  local ignore_fields = options.ignore_fields or { "body" }
  local transform_fn = options.transform_fn or transform_line
  local separator = options.separator or " -> "
  local allow_duplicates = options.allow_duplicates or false

  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ""
  end

  local lines = {}
  local expr = current_node
  local prev_expr = nil
  local included_prev_expr = false

  -- walk up the tree from the current node
  while expr do
    local include_cur_expr = is_statusline_scope(expr, type_patterns)
    if include_cur_expr then
      local expr_lines = {}
      -- extract signature from a node by filtering out children nodes that look like
      -- implementation and concat the text for the rest of the nodes
      for expr_child, field_name in expr:iter_children() do
        if vim.tbl_contains(ignore_fields, field_name) then
          -- found body, break instead of continue to handle cases like lua functions
          -- function func()
          --   <body>
          -- end
          -- where `end` after body is redundant
          break
        end

        -- consider the tree for C++ code `int func2(){}`
        --  (function_definition ; [0, 0] - [0, 13]
        --    type: (primitive_type) ; [0, 0] - [0, 3]
        --    declarator: (function_declarator ; [0, 4] - [0, 11]
        --      declarator: (identifier) ; [0, 4] - [0, 9]
        --      parameters: (parameter_list)) ; [0, 9] - [0, 11]
        --    body: (compound_statement)) ; [0, 11] - [0, 13]
        -- function_declarator is nested inside function_definition, and it would be hard
        -- to reliably tell them part across languages. Instead of trying to ignore
        -- function_declarator, merge the text for that node into current line
        if prev_expr and expr_child:equal(prev_expr) and included_prev_expr then
          table.insert(expr_lines, lines[1])
        else
          -- normal case
          table.insert(expr_lines, vim.trim(vim.treesitter.get_node_text(expr_child, bufnr)))
        end
      end
      local line = transform_fn(table.concat(expr_lines, " "))
      if line ~= "" then
        -- since we're traversing from smaller scope to larger, we want to insert into lines
        -- in the opposite order so the largest scope comes first
        if included_prev_expr then
          -- the existing head of lines was already merged into expr_lines, so
          -- replace the head instead of pushing onto lines
          lines[1] = line
        elseif allow_duplicates or not vim.tbl_contains(lines, line) then
          -- normal case
          table.insert(lines, 1, line)
        end
      end
    end
    included_prev_expr = include_cur_expr
    prev_expr = expr
    expr = expr:parent()
  end

  local text = table.concat(lines, separator)
  local text_len = #text
  if text_len > indicator_size then
    return "..." .. text:sub(text_len - indicator_size, text_len)
  end

  return text
end

return M
