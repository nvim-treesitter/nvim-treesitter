local tsutils = require "nvim-treesitter.ts_utils"

describe("Test is_in_node_range", function()

  function is_in_node_range(range, line, col, expected)
    local node = {
      range = function ()
        return unpack(range)
      end
    }
    local actual = tsutils.is_in_node_range(node, line, col)
    assert.are.same(actual, expected)
  end

  function table_repr(t)
    return string.format("{%s, %s, %s, %s}", unpack(t))
  end

  local params = {
    {{0, 0, 1, 0}, 0, 5, true},
    {{0, 0, 1, 0}, 1, 0, false},
    {{0, 0, 2, 0}, 2, 0, false},
    {{0, 0, 3, 0}, 2, 0, true},
    {{0, 3, 0, 5}, 0, 1, false},
    {{0, 3, 0, 5}, 0, 3, true},
    {{0, 3, 0, 5}, 0, 5, false},
  }
  for _, param in ipairs(params) do
    local r, line, col, expected = unpack(param)
    it(string.format("%s, %s, %s -> %s", table_repr(r), line, col, expected), function ()
      is_in_node_range(unpack(param))
    end)
  end
end)
