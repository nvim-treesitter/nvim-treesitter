local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/scala", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent Scala:", function()
  describe("whole file:", function()
    run:whole_file(".", {
      expected_failures = {
        "fixme_nested_fors.scala",
      },
    })
  end)

  describe("new line:", function()
    run:new_line("import.scala", { on_line = 2, text = "//", indent = 2 })
    run:new_line("macro_splice.scala", { on_line = 3, text = "//", indent = 4 })

    -- block indents
    for _, p in ipairs { { 2, 2 }, { 5, 2 }, { 12, 4 } } do
      run:new_line("block.scala", { on_line = p[1], text = "//", indent = p[2] })
    end
    for _, p in ipairs { { 2, 2 }, { 4, 2 }, { 9, 4 } } do
      run:new_line("indented_block.scala", { on_line = p[1], text = "//", indent = p[2] })
    end

    -- block dedents
    for _, p in ipairs { { 3, 0 }, { 6, 0 }, { 10, 2 }, { 13, 2 } } do
      run:new_line("block.scala", { on_line = p[1], text = "//", indent = p[2] })
    end
    for _, p in ipairs { { 4, 2 }, { 7, 2 }, { 8, 0 } } do
      run:new_line("end.scala", { on_line = p[1], text = "//", indent = p[2] })
    end
  end)
end)
