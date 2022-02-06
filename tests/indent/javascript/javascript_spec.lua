local Runner = require("tests.indent.common").Runner
-- local XFAIL = require("tests.indent.common").XFAIL

local ecma = Runner:new(it, "ecma", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
  filetype = "javascript",
})

describe("indent JavaScript:", function()
  describe("whole file:", function()
    ecma:whole_file {
      expected_failures = {},
    }
  end)

  describe("new line:", function()
    for _, info in
      ipairs {
        { 1, 2 },
        { 2, 4 },
        { 3, 4 },
      }
    do
      ecma:new_line("binary_expression.js", { on_line = info[1], text = "//", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 4, 2 },
        { 6, 0 },
      }
    do
      ecma:new_line("callback.js", { on_line = info[1], text = "//", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 2, 2 },
        { 5, 2 },
        { 7, 0 },
        { 12, 4 },
        { 18, 2 },
        { 19, 2 },
        { 20, 2 },
        { 25, 2 },
      }
    do
      ecma:new_line("func.js", { on_line = info[1], text = "//", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 1, 2 },
        { 2, 2 },
        { 3, 2 },
        { 5, 4 },
        { 6, 4 },
        { 8, 2 },
        { 9, 2 },
        { 12, 2 },
        { 13, 0 },
      }
    do
      ecma:new_line("if_else.js", { on_line = info[1], text = "hello()", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 2, 2 },
        { 5, 0 },
      }
    do
      ecma:new_line("object.js", { on_line = info[1], text = "//", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 3, 6 },
        { 4, 6 },
      }
    do
      ecma:new_line("ternary.js", { on_line = info[1], text = "//", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 1, 2 },
        { 2, 2 },
        { 3, 2 },
        { 4, 2 },
        { 5, 2 },
        { 6, 2 },
        { 7, 0 },
      }
    do
      ecma:new_line("try_catch.js", { on_line = info[1], text = "hello()", indent = info[2] }, info[3], info[4])
    end

    for _, info in
      ipairs {
        { 1, 2 },
        { 2, 0 },
      }
    do
      ecma:new_line("variable.js", { on_line = info[1], text = "hello()", indent = info[2] }, info[3], info[4])
    end
  end)
end)
