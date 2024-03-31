local Runner = require("tests.indent.common").Runner

local runner = Runner:new(it, "tests/indent/nix", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

describe("indent Nix:", function()
  describe("whole file:", function()
    runner:whole_file(".", {
      expected_failures = {},
    })
  end)

  describe("new line:", function()
    for _, info in ipairs {
      { 14, 2 },
      { 16, 2 },
      { 48, 4 },
      { 112, 6 },
    } do
      runner:new_line("general.nix", { on_line = info[1], text = "x = 1;", indent = info[2] })
    end

    for _, info in ipairs {
      { 115, 6 },
      { 113, 10 },
      { 6, 4 },
      { 12, 2 },
      { 16, 6 },
      { 35, 6 },
      { 23, 2 },
      { 21, 6 },
    } do
      runner:new_line("conds.nix", { on_line = info[1], text = "x = 1;", indent = info[2] })
    end
  end)
end)
