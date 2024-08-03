local configs = require "nvim-treesitter.configs"

describe("setup", function()
  it("preserves settings if called multiple times", function()
    configs.setup {
      auto_install = true,
      ignore_install = { "tmux" },
      ensure_installed = { "lua" },
    }

    configs.setup {
      auto_install = true,
      ensure_installed = { "lua" },
    }

    assert.equal(configs.get_ignored_parser_installs(), { "tmux" })
  end)
end)
