local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/clojure", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Clojure:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("test.cljc", { on_line = 1, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 4, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 11, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 16, text = ":x", indent = 6 })
    run:new_line("test.cljc", { on_line = 20, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 23, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 31, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 34, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 34, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 47, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 51, text = ":x", indent = 3 })
    run:new_line("test.cljc", { on_line = 55, text = ":x", indent = 9 })
    run:new_line("test.cljc", { on_line = 63, text = ":x", indent = 10 })
    run:new_line("test.cljc", { on_line = 68, text = ":x", indent = 3 })
    run:new_line("test.cljc", { on_line = 70, text = ":x", indent = 4 })
    run:new_line("test.cljc", { on_line = 74, text = ":x", indent = 3 })
    run:new_line("test.cljc", { on_line = 83, text = ":x", indent = 3 })
    run:new_line("test.cljc", { on_line = 86, text = ":x", indent = 4 })
    run:new_line("test.cljc", { on_line = 89, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 92, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 95, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 98, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 101, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 104, text = ":x", indent = 1 })
    run:new_line("test.cljc", { on_line = 107, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 110, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 113, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 116, text = ":x", indent = 3 })
    run:new_line("test.cljc", { on_line = 120, text = ":x", indent = 2 })
    run:new_line("test.cljc", { on_line = 132, text = ":x", indent = 8 })
    run:new_line("test.cljc", { on_line = 135, text = ":x", indent = 2 })
  end)
end)
