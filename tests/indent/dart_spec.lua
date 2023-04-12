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
        "./multiple_arguments.dart",
        "./class.dart",
        "./class_function_argument.dart",
      },
    })
  end)
end)

describe("new line:", function()
  run:new_line("class.dart", { on_line = 4, text = "int five;", indent = 2 })
  run:new_line("class.dart", { on_line = 6, text = "'100'", indent = 8 }, "expected failure", XFAIL)
  run:new_line("class.dart", { on_line = 7, text = "int five = 5", indent = 2 }, "expected failure", XFAIL)
  run:new_line("try.dart", { on_line = 2, text = "var x;", indent = 4 })
  run:new_line("multiple_arguments.dart", { on_line = 10, text = "var x;", indent = 4 })
  run:new_line(
    "multiple_arguments.dart",
    { on_line = 11, text = "var x;", indent = 4 },
    "expected failure issue #4637",
    XFAIL
  )
  run:new_line("class_function_argument.dart", { on_line = 11, text = "}", indent = 4 })
end)
