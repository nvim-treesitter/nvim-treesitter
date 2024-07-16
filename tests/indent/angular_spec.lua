local Runner = require("tests.indent.common").Runner
local runner = Runner:new(it, "tests/indent/angular", {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  filetype = "htmlangular",
})

describe("indent HTML Angular:", function()
  describe("whole file:", function()
    runner:whole_file "."
  end)

  describe("new line:", function()
    for _, info in ipairs {
      { 1, 2 },
      { 2, 2 },
      { 3, 2 },
      { 4, 2 },
      { 6, 0 },
      { 7, 2 },
      { 8, 4 },
      { 10, 4 },
      { 11, 6 },
      { 12, 6 },
      { 13, 4 },
      { 14, 2 },
    } do
      runner:new_line("if-else.html", { on_line = info[1], text = "//", indent = info[2] })
    end

    for _, info in ipairs {
      { 1, 2 },
      { 2, 4 },
      { 3, 6 },
      { 4, 6 },
      { 6, 6 },
      { 7, 6 },
      { 9, 6 },
      { 10, 6 },
      { 12, 2 },
    } do
      runner:new_line("switch-case.html", { on_line = info[1], text = "//", indent = info[2] })
    end

    for _, info in ipairs {
      { 1, 2 },
      { 2, 2 },
      { 3, 2 },
      { 4, 2 },
      { 5, 0 },
    } do
      runner:new_line("for.html", { on_line = info[1], text = "//", indent = info[2] })
    end

    for _, info in ipairs {
      { 1, 2 },
      { 2, 2 },
      { 3, 2 },
      { 4, 2 },
      { 5, 2 },
      { 6, 2 },
      { 7, 2 },
      { 8, 2 },
      { 9, 0 },
    } do
      runner:new_line("defer.html", { on_line = info[1], text = "//", indent = info[2] })
    end
  end)
end)
