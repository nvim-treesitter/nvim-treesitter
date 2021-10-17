local M = {}

local assert = require "luassert"
local Path = require "plenary.path"

-- Get table of nodes from file
-- @param file  a tested file
local function get_nodes(file)
  assert(vim.fn.filereadable(file) == 1, string.format('File "%s" not readable', file))

  -- load reference file
  vim.cmd(string.format("edit %s", file))

  local parser = vim.treesitter.get_parser(0)
  local tstree = parser:parse()

  return tstree:root()
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

function Runner:expect_nodes(file, spec, title)
  title = title and title or tostring(spec.on_line)

  self.it(string.format("%s[%s]", file, title), function()
    local path = self.base_dir / file
    local nodes = get_nodes(path.filename)
    assert.are.same(nodes, spec)
  end)
end

M.Runner = Runner

return M
