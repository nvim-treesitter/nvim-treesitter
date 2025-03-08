local Runner = require("tests.indent.common").Runner
local runner = Runner:new(it, "tests/indent/html", {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  softtabstop = 0,
})

describe("indent HTML:", function()
  local css_indent = vim.api.nvim_create_autocmd("FileType", {
    pattern = "css",
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
    end,
  })
  local js_indent = vim.api.nvim_create_autocmd("FileType", {
    pattern = "javascript",
    callback = function()
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
    end,
  })

  describe("whole file:", function()
    runner:whole_file "."
  end)

  describe("new line:", function()
    runner:new_line("start_tag.html", { on_line = 1, text = "anything", indent = 0 })
    runner:new_line("start_tag.html", { on_line = 4, text = "anything", indent = 4 })
    runner:new_line("start_tag.html", { on_line = 6, text = "charset = utf-8", indent = 6 })
    runner:new_line("start_tag.html", { on_line = 6, text = ">", indent = 4 })
    runner:new_line("start_tag.html", { on_line = 6, text = "/>", indent = 4 })
    runner:new_line("issue-3986.html", { on_line = 3, text = "indent once", indent = 2 })
    runner:new_line("self_closing_tag.html", { on_line = 10, text = "Something", indent = 4 })
    runner:new_line("self_closing_tag.html", { on_line = 12, text = "disabled", indent = 6 })
    runner:new_line("self_closing_tag.html", { on_line = 12, text = "/>", indent = 4 })
    runner:new_line("script_style.html", { on_line = 5, text = "body", indent = 2 })
    runner:new_line("script_style.html", { on_line = 6, text = "<div></div>", indent = 2 })
    runner:new_line("script_style.html", { on_line = 9, text = "const x = 1", indent = 2 })
    runner:new_line("script_style.html", { on_line = 11, text = "Text", indent = 2 })
    runner:new_line("mixed_indent.html", { on_line = 3, text = "const x = 1;", indent = 6 })
  end)

  vim.api.nvim_del_autocmd(js_indent)
  vim.api.nvim_del_autocmd(css_indent)
end)
