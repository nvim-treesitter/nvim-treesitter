local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/wgsl", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent WGSL:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("basic.wgsl", { on_line = 47, text = "c: u32,", indent = 2 })
    run:new_line("basic.wgsl", { on_line = 52, text = "c: u32,", indent = 2 })
    run:new_line("basic.wgsl", { on_line = 56, text = "c: u32,", indent = 2 })
    run:new_line("basic.wgsl", { on_line = 59, text = "c: u32,", indent = 2 })
    run:new_line("type_constructor_or_function_call_expression.wgsl", {
      on_line = 3,
      text = "b",
      indent = 4,
    })
    run:new_line("type_constructor_or_function_call_expression.wgsl", {
      on_line = 4,
      text = "c",
      indent = 4,
    })
    run:new_line("type_constructor_or_function_call_expression.wgsl", {
      on_line = 8,
      text = "b",
      indent = 4,
    })
    run:new_line("type_constructor_or_function_call_expression.wgsl", {
      on_line = 9,
      text = "c",
      indent = 4,
    })
  end)
end)
