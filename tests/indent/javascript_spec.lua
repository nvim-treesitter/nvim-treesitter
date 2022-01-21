local Runner = require("tests.indent.common").Runner
-- local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
  filetype = "javascript",
})

describe("indent JavaScript:", function()
  describe("whole file:", function()
    run:whole_file({ "ecma/" }, {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    for _, info in ipairs {
      { 1, 2 },
      { 2, 2 },
      { 3, 2 },
      { 4, 2 },
      { 5, 2 },
      { 6, 2 },
      { 7, 0 },
    } do
      run:new_line("ecma/try_catch.js", { on_line = info[1], text = "hello()", indent = info[2] })
    end

    for _, info in ipairs {
      { 1, 2 },
      { 2, 2 },
      { 3, 2 },
      { 5, 4 },
      { 6, 4 },
      { 8, 2 },
      { 9, 2 },
      { 12, 2 },
      { 13, 0 },
    } do
      run:new_line("ecma/if_else.js", { on_line = info[1], text = "hello()", indent = info[2] })
    end
  end)
end)
