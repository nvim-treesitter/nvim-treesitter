local Runner = require("tests.indent.common").Runner
--local XFAIL = require("tests.indent.common").XFAIL

local run = Runner:new(it, "tests/indent/zig", {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

describe("indent Zig:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new lines:", function()
    run:new_line("pr-3269.zig", { on_line = 5, text = "return;", indent = 4 })
    run:new_line("pr-3269.zig", { on_line = 6, text = "", indent = 0 })
    run:new_line("types.zig", { on_line = 4, text = "z: f32,", indent = 4 })
    run:new_line("types.zig", { on_line = 7, text = "", indent = 0 })
    run:new_line("types.zig", { on_line = 9, text = "spherical,", indent = 4 })
    run:new_line("types.zig", { on_line = 12, text = "", indent = 0 })
    run:new_line("types.zig", { on_line = 14, text = "predicate: bool,", indent = 4 })
    run:new_line("types.zig", { on_line = 17, text = "", indent = 0 })
    run:new_line("types.zig", { on_line = 22, text = "pub fn test(ptr: *Opaque) {}", indent = 4 })
    run:new_line("types.zig", { on_line = 23, text = "", indent = 0 })
    run:new_line("types.zig", { on_line = 21, text = "const copy = ptr;", indent = 8 })
    run:new_line("pr-7199.zig", { on_line = 4, text = "{", indent = 4 })
    run:new_line("pr-7199.zig", { on_line = 6, text = 'std.debug.print("Hello, world!\\n", .{});', indent = 8 })
    run:new_line("pr-7199.zig", { on_line = 7, text = 'std.debug.print("Hello, world!\\n", .{});', indent = 4 })
    run:new_line("pr-7199.zig", { on_line = 8, text = "", indent = 0 })
  end)
end)
