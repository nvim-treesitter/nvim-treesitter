local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/php", {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 0,
  expandtab = true,
})

describe("indent PHP:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    run:new_line("example.php", { on_line = 11, text = "// new line starts 1 indentation to far", indent = 4 })
    run:new_line(
      "example2.php",
      { on_line = 5, text = "indentation with `enter` in insert mode is not correct", indent = 4 }
    )
    run:new_line("issue-2497.php", { on_line = 5, text = "$a =", indent = 4 })
    run:new_line("unfinished-call.php", { on_line = 6, text = "$a =", indent = 4 })
    run:new_line("issue-3591.php", { on_line = 4, text = "$a =", indent = 8 })
    run:new_line("enum-indent.php", { on_line = 4, text = "case", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 3, text = "true", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 4, text = "return;", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 7, text = "true", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 10, text = "|| false", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 11, text = "$a = 0;", indent = 0 })
    run:new_line("issue-4848.php", { on_line = 13, text = "true", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 16, text = "$a,", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 17, text = "true", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 20, text = "$a,", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 21, text = "return $a;", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 24, text = "return;", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 27, text = "true", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 28, text = "true => null,", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 31, text = "true => null,", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 35, text = "function a() {}", indent = 4 })
    run:new_line("issue-4848.php", { on_line = 37, text = "return;", indent = 8 })
    run:new_line("issue-4848.php", { on_line = 40, text = "$a,", indent = 8 })
    run:new_line("issue-4848.php", { on_line = 41, text = "return $a;", indent = 8 })
  end)
end)
