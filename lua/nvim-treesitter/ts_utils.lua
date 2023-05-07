local api = vim.api

local parsers = require('nvim-treesitter.parsers')
local utils = require('nvim-treesitter.utils')
local ts = vim.treesitter

local M = {}

function M.get_named_children(node)
  local nodes = {} ---@type TSNode[]
  for i = 0, node:named_child_count() - 1, 1 do
    nodes[i + 1] = node:named_child(i)
  end
  return nodes
end

function M.get_root_for_position(line, col, root_lang_tree)
  if not root_lang_tree then
    if not parsers.has_parser() then
      return
    end

    root_lang_tree = parsers.get_parser()
  end

  local lang_tree = root_lang_tree:language_for_range({ line, col, line, col })

  for _, tree in ipairs(lang_tree:trees()) do
    local root = tree:root()

    if root and ts.is_in_node_range(root, line, col) then
      return root, tree, lang_tree
    end
  end

  -- This isn't a likely scenario, since the position must belong to a tree somewhere.
  return nil, nil, lang_tree
end

---comment
---@param node TSNode
---@return TSNode result
function M.get_root_for_node(node)
  local parent = node
  local result = node

  while parent ~= nil do
    result = parent
    parent = result:parent()
  end

  return result
end

-- Byte length of node range
---@param node TSNode
---@return number
function M.node_length(node)
  local _, _, start_byte = node:start()
  local _, _, end_byte = node:end_()
  return end_byte - start_byte
end

-- Memoizes a function based on the buffer tick of the provided bufnr.
-- The cache entry is cleared when the buffer is detached to avoid memory leaks.
-- The options argument is a table with two optional values:
--  - bufnr: extracts a bufnr from the given arguments.
--  - key: extracts the cache key from the given arguments.
---@param fn function the fn to memoize, taking the buffer as first argument
---@param options? {bufnr: integer?, key: string|fun(...): string?} the memoization options
---@return function: a memoized function
function M.memoize_by_buf_tick(fn, options)
  options = options or {}

  ---@type table<string, {result: any, last_tick: integer}>
  local cache = setmetatable({}, { __mode = "kv" })
  local bufnr_fn = utils.to_func(options.bufnr or utils.identity)
  local key_fn = utils.to_func(options.key or utils.identity)

  return function(...)
    local bufnr = bufnr_fn(...)
    local key = key_fn(...)
    local tick = api.nvim_buf_get_changedtick(bufnr)

    if cache[key] then
      if cache[key].last_tick == tick then
        return cache[key].result
      end
    else
      local function detach_handler()
        cache[key] = nil
      end

      -- Clean up logic only!
      api.nvim_buf_attach(bufnr, false, {
        on_detach = detach_handler,
        on_reload = detach_handler,
      })
    end

    cache[key] = {
      result = fn(...),
      last_tick = tick,
    }

    return cache[key].result
  end
end

return M
