local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

-- will use both c/ and cpp/
local run = Runner:new(it, "tests/indent", {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
  filetype = "cpp",
})

describe("indent C++:", function()
  describe("whole file:", function()
    run:whole_file({ "cpp/" }, {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("cpp/access.cpp", { on_line = 3, text = "protected:", indent = 0 })
    run:new_line("cpp/class.cpp", { on_line = 2, text = "using T = int;", indent = 4 })
    run:new_line("cpp/stream.cpp", { on_line = 5, text = "<< x + 3", indent = 8 })
  end)
end)
