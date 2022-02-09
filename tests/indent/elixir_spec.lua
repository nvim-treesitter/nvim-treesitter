local Runner = require("tests.indent.common").Runner

local run = Runner:new(it, "tests/indent/elixir", {
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 0,
  expandtab = true,
})

describe("indent elixir:", function()
  describe("new line", function()
    run:new_line("module.ex", { on_line = 1, text = "defp bar, do: :ok", indent = 2 })
    run:new_line("function.ex", { on_line = 2, text = "_ = 1 + 1", indent = 4 })
    run:new_line("function.ex", { on_line = 3, text = "defp bar, do: :ok", indent = 2 })
    run:new_line("function.ex", { on_line = 8, text = ":value", indent = 6 })
    run:new_line("rescue.ex", { on_line = 3, text = "e in RuntimeError -> e", indent = 2 })
    run:new_line("after.ex", { on_line = 3, text = 'IO.puts "cleaning up!"', indent = 2 })
    run:new_line("catch.ex", { on_line = 3, text = ":error -> :ok", indent = 2 })
    run:new_line("stab_clause.ex", { on_line = 2, text = ":ok", indent = 2 })
    run:new_line("pipeline.ex", { on_line = 3, text = "|> then(fn v -> v end)", indent = 2 })
    run:new_line("pipeline.ex", { on_line = 3, text = "|> then(&IO.puts/1)", indent = 2 })
    run:new_line("pipeline.ex", { on_line = 10, text = "|> then(&IO.puts/1)", indent = 2 })
    run:new_line("map.ex", { on_line = 2, text = "c: :d", indent = 2 })

    -- keep broken test in PR for understanding
    -- why does typing `in` from `IO.inspect` cause the line to dedent?
    run:new_line("pipeline.ex", { on_line = 3, text = "|> then(&IO.inspect/1)", indent = 2 })
  end)
end)
