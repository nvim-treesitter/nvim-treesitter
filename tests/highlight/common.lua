local M = {}

local assert = require "luassert"
local Path = require "plenary.path"
local ft_to_lang = require("nvim-treesitter.parsers").ft_to_lang

-- Get table with highlight query captures
-- @param file A path to file to parse
local function get_highlight_captures(file)
  assert(vim.fn.filereadable(file) == 1, string.format('File "%s" not readable', file))

  -- load reference file
  vim.cmd(string.format("edit %s", file))

  local ft = vim.bo.filetype
  local lang = ft_to_lang(ft)

  local parser = vim.treesitter.get_parser(0, lang)
  local tree = parser:parse()[1]

  local query = vim.treesitter.query.get_query(lang, "highlights")
  local captures = {}

  for id, node, _ in query:iter_captures(tree:root(), 0, 0, -1) do
    local capture = {}

    capture.name = query.captures[id]
    capture.begin_row, capture.begin_column, capture.end_row, capture.end_column = node:range()

    table.insert(captures, capture)
  end

  return captures
end

local Runner = {}
Runner.__index = Runner

-- Helper to avoid boilerplate when defining tests
-- @param it  the "it" function that busted defines globally in spec files
-- @param base_dir  all other paths will be resolved relative to this directory
function Runner:new(it, base_dir)
  local runner = {}
  runner.it = it
  runner.base_dir = Path:new(base_dir)
  return setmetatable(runner, self)
end

function Runner:expect_nodes(file, spec)
  self.it(string.format("%s", file), function()
    local path = self.base_dir / file
    local nodes = get_highlight_captures(path.filename)
    assert.are.same(nodes, spec)
  end)
end

M.Runner = Runner

return M
