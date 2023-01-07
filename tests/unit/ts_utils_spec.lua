local tsutils = require "nvim-treesitter.ts_utils"

describe("is_in_node_range", function()
  local function test_is_in_node_range(line, col)
    local node = {
      range = function()
        return unpack { 0, 3, 2, 5 }
      end,
    }
    return tsutils.is_in_node_range(node, line, col)
  end

  it("returns false before node start", function()
    assert.is_false(test_is_in_node_range(0, 0))
    assert.is_false(test_is_in_node_range(0, 1))
    assert.is_false(test_is_in_node_range(0, 2))
  end)

  it("returns true at node start", function()
    assert.is_true(test_is_in_node_range(0, 3))
  end)

  it("returns true on first line of the node", function()
    assert.is_true(test_is_in_node_range(0, 4))
  end)

  it("returns true between node lines", function()
    assert.is_true(test_is_in_node_range(1, 2))
    assert.is_true(test_is_in_node_range(1, 20))
  end)

  it("returns false on node end", function()
    -- Ranges are end-exclusive
    assert.is_false(test_is_in_node_range(2, 5))
  end)

  it("returns false after node end", function()
    assert.is_false(test_is_in_node_range(2, 6))
    assert.is_false(test_is_in_node_range(3, 0))
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

describe("swap_nodes", function()
  local function swap(case)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, case.lines)
    vim.opt.filetype = case.filetype
    local a = vim.treesitter.get_node_at_pos(0, case.a[1], case.a[2], {})
    local b = vim.treesitter.get_node_at_pos(0, case.b[1], case.b[2], {})
    tsutils.swap_nodes(a, b, 0, true)
  end

  it("works on adjacent nodes", function()
    swap {
      filetype = "python",
      lines = { "print(1)" },
      a = { 0, 0 },
      b = { 0, 5 },
    }

    it("swaps text", function() end)
    assert.same(vim.api.nvim_buf_get_lines(0, 0, -1, false), { "(1)print" })

    it("moves the cursor", function() end)
    assert.same(vim.api.nvim_win_get_cursor(0), { 1, 3 })
  end)

  it("works with multiline nodes", function()
    swap {
      filetype = "lua",
      lines = { "x = { [[", "]], [[", ".....]]}" },
      a = { 0, 6 },
      b = { 1, 4 },
    }

    it("swaps text", function() end)
    assert.same(vim.api.nvim_buf_get_lines(0, 0, -1, false), { "x = { [[", ".....]], [[", "]]}" })

    it("moves the cursor", function() end)
    assert.same(vim.api.nvim_win_get_cursor(0), { 2, 9 })
  end)
end)
