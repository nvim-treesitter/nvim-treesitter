local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/query", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
  lispoptions = "expr:1",
})

describe("indent Query:", function()
  describe("whole file:", function()
    run:whole_file(".", {})
  end)
  describe("new line:", function()
    run:new_line("test.scm", { on_line = 3, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 5, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 12, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 25, text = "(#my-directive!)", indent = 10 })
    run:new_line("test.scm", { on_line = 34, text = '"more"', indent = 2 })
    run:new_line("test.scm", { on_line = 35, text = "(node)", indent = 0 })
    run:new_line("test.scm", { on_line = 40, text = "(node)", indent = 0 })
    run:new_line("test.scm", { on_line = 44, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 46, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 48, text = "(node)", indent = 2 })
    run:new_line("test.scm", { on_line = 50, text = "node_name", indent = 2 })
  end)
end)
