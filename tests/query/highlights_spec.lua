require "nvim-treesitter.highlight" -- yes, this is necessary to set the hlmap
local highlighter = require "vim.treesitter.highlighter"
local utils = require "nvim-treesitter.utils"
local ts_utils = require "nvim-treesitter.ts_utils"
local parsers = require "nvim-treesitter.parsers"

local function check_assertions(file)
  local buf = vim.fn.bufadd(file)
  vim.fn.bufload(file)
  local lang = parsers.get_buf_lang(buf)
  assert.same(
    1,
    vim.fn.executable "highlight-assertions",
    '"highlight-assertions" not executable!'
      .. ' Get it via "cargo install --git https://github.com/theHamsta/highlight-assertions"'
  )
  local assertions = vim.fn.json_decode(
    vim.fn.system(
      "highlight-assertions -p '" .. utils.get_parser_install_dir() .. "/" .. lang .. ".so'" .. " -s '" .. file .. "'"
    )
  )
  local parser = parsers.get_parser(buf, lang)

  local self = highlighter.new(parser, {})

  for _, assertion in ipairs(assertions) do
    local row = assertion.position.row
    local col = assertion.position.column

    local captures = {}
    local highlights = {}
    self.tree:for_each_tree(function(tstree, tree)
      if not tstree then
        return
      end

      local root = tstree:root()
      local root_start_row, _, root_end_row, _ = root:range()

      -- Only worry about trees within the line range
      if root_start_row > row or root_end_row < row then
        return
      end

      local query = self:get_query(tree:lang())

      -- Some injected languages may not have highlight queries.
      if not query:query() then
        return
      end

      local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

      for capture, node, _ in iter do
        local hl = query.hl_cache[capture]
        assert.is.truthy(hl)

        assert.Truthy(node)
        assert.is.number(row)
        assert.is.number(col)
        if hl and ts_utils.is_in_node_range(node, row, col) then
          local c = query._query.captures[capture] -- name of the capture in the query
          if c ~= nil then
            captures[c] = true
            local general_hl = query:_get_hl_from_capture(capture)
            highlights[general_hl] = true
          end
        end
      end
    end, true)
    assert.True(
      captures[assertion.expected_capture_name] or highlights[assertion.expected_capture_name],
      "Error in at "
        .. file
        .. ":"
        .. (row + 1)
        .. ":"
        .. (col + 1)
        .. ': expected "'
        .. assertion.expected_capture_name
        .. '", captures: '
        .. vim.inspect(vim.tbl_keys(captures))
        .. '", highlights: '
        .. vim.inspect(vim.tbl_keys(highlights))
    )
  end
end

describe("highlight queries", function()
  local files = vim.fn.split(vim.fn.glob "tests/query/highlights/**/*.*")
  for _, file in ipairs(files) do
    it(file, function()
      check_assertions(file)
    end)
  end
end)
