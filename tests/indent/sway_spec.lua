local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/sway", {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

describe("indent Sway:", function()
  describe("whole file:", function()
    run:whole_file(".", {})
  end)
  describe("new line:", function()
    run:new_line("main.sw", { on_line = 12, text = "const CONST: u32 = 2;", indent = 0 })
    run:new_line("main.sw", { on_line = 14, text = "let hi = 5;", indent = 4 })
    run:new_line("main.sw", { on_line = 15, text = "let hi = 5;", indent = 8 })
    run:new_line("main.sw", { on_line = 92, text = "let hi = 5;", indent = 12 })
  end)
end)
