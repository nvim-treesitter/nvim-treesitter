local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/dot", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent dot:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("test.dot", { on_line = 1, text = "digraph {", indent = 0 })
    run:new_line("test.dot", { on_line = 2, text = "node [", indent = 2 })
    run:new_line("test.dot", { on_line = 3, text = "shape=ellipse,", indent = 4 })
    run:new_line("test.dot", { on_line = 5, text = "subgraph sub {", indent = 2 })
    run:new_line("test.dot", { on_line = 6, text = "a1 -> a2 -> a3;", indent = 4 })
    run:new_line("test.dot", { on_line = 8, text = "}", indent = 0 })
  end)
end)
