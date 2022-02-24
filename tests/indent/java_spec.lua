local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/java", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Java:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("method.java", { on_line = 1, text = "void foo() {}", indent = 2 })
    run:new_line("issue_2571.java", { on_line = 5, text = "void bar() {}", indent = 2 })
  end)
end)
