local tsutils = require "nvim-treesitter.ts_utils"
local is_in_node_range = tsutils.is_in_node_range

describe("is_in_node_range", function()
  local node = {
    range = function()
      return unpack { 0, 3, 2, 5 }
    end,
  }
  local root_node = {
    range = function()
      return unpack { 0, 0, 2, 0 }
    end,
  }

  it("returns false before node start", function()
    assert.is_false(is_in_node_range(node, 0, 0))
    assert.is_false(is_in_node_range(node, 0, 1))
    assert.is_false(is_in_node_range(node, 0, 2))
  end)

  it("returns true at node start", function()
    assert.is_true(is_in_node_range(node, 0, 3))
  end)

  it("returns true on first line of the node", function()
    assert.is_true(is_in_node_range(node, 0, 4))
  end)

  it("returns true between node lines", function()
    assert.is_true(is_in_node_range(node, 1, 2))
    assert.is_true(is_in_node_range(node, 1, 20))
  end)

  it("returns false at node end for normal nodes", function()
    assert.is_false(is_in_node_range(node, 2, 5))
  end)

  it("returns true at node end for root node", function()
    assert.is_true(is_in_node_range(root_node, 2, 0))
  end)

  it("returns false after node end", function()
    assert.is_false(is_in_node_range(node, 2, 6))
    assert.is_false(is_in_node_range(node, 3, 0))
    assert.is_false(is_in_node_range(root_node, 3, 0))
  end)
end)

describe("update_selection", function()
  local function get_updated_selection(case)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, case.lines)
    tsutils.update_selection(0, case.node, case.selection_mode)
    vim.cmd "normal! y"
    return vim.fn.getreg '"'
  end

  it("charwise1", function()
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 0, 2, 1 },
        selection_mode = "v",
      },
      "foo\n\nb"
    )
    it("charwise2", function() end)
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 1, 2, 1 },
        selection_mode = "v",
      },
      "oo\n\nb"
    )
    it("charwise3", function() end)
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 2, 2, 1 },
        selection_mode = "v",
      },
      "o\n\nb"
    )
    it("charwise4", function() end)
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 3, 2, 1 },
        selection_mode = "v",
      },
      "\n\nb"
    )
  end)
  it("linewise", function()
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 3, 2, 1 },
        selection_mode = "V",
      },
      "foo\n\nbar\n"
    )
  end)
  it("blockwise", function()
    assert.equal(
      get_updated_selection {
        lines = { "foo", "", "bar" },
        node = { 0, 3, 2, 1 },
        selection_mode = "<C-v>",
      },
      "foo\n\nbar"
    )
  end)
end)
