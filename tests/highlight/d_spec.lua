local Runner = require("tests.highlight.common").Runner

local runner = Runner:new(it, "tests/highlight/d")

describe("D highlights", function()
  runner:expect_nodes("import.d", {
    {
      begin_line = 1,
      begin_column = 1,
      end_line = 1,
      end_column = 8,
      name = "@include",
    },
  })
end)
