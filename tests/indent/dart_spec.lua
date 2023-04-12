local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/dart", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
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
  run:new_line("try.dart", { on_line = 2, text = "var x;", indent = 4 })
  run:new_line("switch.dart", { on_line = 3, text = "x = 1;", indent = 6 })
  run:new_line("switch.dart", { on_line = 9, text = "x = 1;", indent = 6 })
  run:new_line("switch.dart", { on_line = 3, text = "case 2:", indent = 4 })
  run:new_line("switch.dart", { on_line = 16, text = "abc;", indent = 4 })
  run:new_line("switch.dart", { on_line = 20, text = "abc;", indent = 4 })
  run:new_line("switch.dart", { on_line = 28, text = "y++;", indent = 6 })

  run:new_line("multiple_arguments.dart", { on_line = 10, text = "var x;", indent = 4 })
  run:new_line("multiple_arguments.dart", { on_line = 11, text = "var x;", indent = 4 })
end)
