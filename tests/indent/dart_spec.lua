local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/dart", {
  tabstop = 4,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Lua:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)
end)

describe("new line:", function()
  run:new_line("class.dart", { on_line = 2, text = "var x;", indent = 0 })
end)
