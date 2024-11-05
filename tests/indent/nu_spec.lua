local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/nu", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = -1,
  expandtab = true,
})

describe("indent Nu:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)
end)
