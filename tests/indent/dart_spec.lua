local Runner = require("tests.indent.common").Runner
local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/dart", {
  tabstop = 4,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Lua:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {
        "./dart/multiple_arguments.dart", -- expected failure issue #4637
      },
    })
  end)
end)

describe("new line:", function()
  run:new_line("class.dart", { on_line = 2, text = "var x;", indent = 0 })
  run:new_line("try.dart", { on_line = 2, text = "var x;", indent = 4 })
  run:new_line("multiple_arguments.dart", { on_line = 10, text = "var x;", indent = 4 })
  run:new_line(
    "multiple_arguments.dart",
    { on_line = 11, text = "var x;", indent = 4 },
    "expected failure issue #4637",
    XFAIL
  )
end)
