local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/php", {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
})

describe("indent PHP:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("example.php", { on_line = 11, text = "// new line starts 1 indentation to far", indent = 4 })
  end)
end)
