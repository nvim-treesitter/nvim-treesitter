local Runner = require("tests.indent.common").Runner
local XFAIL = require("tests.indent.common").XFAIL

local buf_opts = {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
  filetype = "cpp",
}

local cpp = Runner:new(it, "cpp", buf_opts)
local c = Runner:new(it, "c", buf_opts)

describe("indent C++:", function()
  describe("whole file:", function()
    cpp:whole_file {
      expected_failures = {},
    }

    c:whole_file {
      expected_failures = {
        "preproc_func.c",
        "unfinished_comment.c",
      },
    }
  end)

  describe("new line:", function()
    cpp:new_line("access.cpp", { on_line = 3, text = "protected:", indent = 0 })
    cpp:new_line("class.cpp", { on_line = 2, text = "using T = int;", indent = 4 })
    cpp:new_line("stream.cpp", { on_line = 5, text = "<< x + 3", indent = 8 })

    -- TODO: find a clean way to import these from c_spec.lua
    c:new_line("array.c", { on_line = 2, text = "0,", indent = 4 })
    c:new_line("cond.c", { on_line = 3, text = "x++;", indent = 8 })
    c:new_line("cond.c", { on_line = 6, text = "x++;", indent = 8 })
    c:new_line("cond.c", { on_line = 8, text = "x++;", indent = 8 })
    c:new_line("cond.c", { on_line = 9, text = "x++;", indent = 4 })
    c:new_line("expr.c", { on_line = 10, text = "2 *", indent = 8 })
    c:new_line("func.c", { on_line = 17, text = "int z,", indent = 4 })
    c:new_line("label.c", { on_line = 3, text = "normal:", indent = 0 })
    c:new_line("loop.c", { on_line = 3, text = "x++;", indent = 8 })
    c:new_line("preproc_cond.c", { on_line = 5, text = "x++;", indent = 4 })
    c:new_line("preproc_func.c", { on_line = 3, text = "x++; \\", indent = 8 }, "expected failure", XFAIL)
    c:new_line("string.c", { on_line = 1, text = "brave new \\", indent = 0 })
    c:new_line("string.c", { on_line = 4, text = '"brave new "', indent = 4 })
    c:new_line("struct.c", { on_line = 4, text = "int y;", indent = 8 })
    c:new_line("switch.c", { on_line = 3, text = "x++;", indent = 12 })
    c:new_line("ternary.c", { on_line = 4, text = ": (x == 0) : 0", indent = 8 })
    -- the line after inserted one will be left with wrong indent but we only care about the inserted one
    c:new_line("no_braces.c", { on_line = 4, text = "x++;", indent = 8 })
    c:new_line("no_braces.c", { on_line = 7, text = "x++;", indent = 8 })
    c:new_line("no_braces.c", { on_line = 10, text = "x++;", indent = 8 })
  end)
end)
