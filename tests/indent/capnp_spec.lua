local t = require('test.testutil')
local Runner = require('tests.indent.common').Runner

local run = Runner:new('tests/indent/capnp', {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
})

t.describe("indent Cap'n Proto:", function()
  t.describe('whole file:', function()
    run:whole_file('.', {
      expected_failures = {},
    })
  end)

  t.describe('new line:', function()
    run:new_line('test.capnp', { on_line = 31, text = 'foo @0;', indent = 2 })
    run:new_line('test.capnp', { on_line = 96, text = 'boolField      = true,', indent = 4 })
    run:new_line('test.capnp', { on_line = 340, text = 'grault @7 :UInt64;', indent = 8 })
    run:new_line('test.capnp', {
      on_line = 573,
      text = 'call @0 Inner2(Text) -> (qux :Qux, gen :TestGenerics(TestAllTypes, TestAnyPointer));',
      indent = 4,
    })
    run:new_line('test.capnp', { on_line = 617, text = 'foo @0 :Foo;', indent = 4 })
    run:new_line('test.capnp', { on_line = 654, text = 'foo = (int16Field = 123),', indent = 4 })
    run:new_line('test.capnp', { on_line = 695, text = 'textField = "nested",', indent = 6 })
    run:new_line('test.capnp', { on_line = 970, text = 'testTailCaller @4;', indent = 4 })
  end)
end)
