local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/hcl", {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
})

describe("indent HCL:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("no-indent-after-brace.tf", { on_line = 4, text = "# Wow, no indent here please", indent = 0 })
  end)
end)
