local Runner = require("tests.indent.common").Runner
local run = Runner:new(it, "tests/indent/yuck", {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
})

describe("indent yuck", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("indent.yuck", { on_line = 13, text = ":box1 parameter", indent = 4 })
    run:new_line("indent.yuck", { on_line = 17, text = ")", indent = 0 })
  end)
end)
