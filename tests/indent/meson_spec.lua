local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/meson", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Meson:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("cond.meson", { on_line = 3, text = "foo()", indent = 2 })
    run:new_line("cond.meson", { on_line = 6, text = "foo()", indent = 2 })
    run:new_line("cond.meson", { on_line = 7, text = "foo()", indent = 2 })
    run:new_line("cond.meson", { on_line = 12, text = "foo()", indent = 2 })
    run:new_line("cond.meson", { on_line = 14, text = "foo()", indent = 2 })
    run:new_line("dict.meson", { on_line = 13, text = ",'x':1,", indent = 2 })
    run:new_line("loop.meson", { on_line = 3, text = "foo()", indent = 2 })
    run:new_line("loop.meson", { on_line = 7, text = "foo()", indent = 2 })
    run:new_line("ternary.meson", { on_line = 11, text = "x : y", indent = 2 })
  end)
end)
