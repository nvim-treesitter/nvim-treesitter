local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/capnp", {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
})

describe("indent Cap'n Proto:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("test.capnp", { on_line = 31, text = "foo @0;", indent = 1 })
    run:new_line("test.capnp", { on_line = 96, text = "boolField      = true,", indent = 3 })
    run:new_line("test.capnp", { on_line = 336, text = "grault @7 :UInt64;", indent = 4 })
    run:new_line("test.capnp", {
      on_line = 569,
      text = "call @0 Inner2(Text) -> (qux :Qux, gen :TestGenerics(TestAllTypes, TestAnyPointer));",
      indent = 2,
    })
    run:new_line("test.capnp", { on_line = 613, text = "foo @0 :Foo;", indent = 2 })
    run:new_line("test.capnp", { on_line = 650, text = "foo = (int16Field = 123),", indent = 3 })
    run:new_line("test.capnp", { on_line = 691, text = 'textField = "nested",', indent = 5 })
    run:new_line("test.capnp", { on_line = 955, text = "testTailCaller @4;", indent = 2 })
  end)
end)
