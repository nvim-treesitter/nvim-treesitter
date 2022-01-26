local stub = require "luassert.stub"
local parsers = require "nvim-treesitter.parsers"

describe("maintained_parsers", function()
  before_each(function()
    stub(vim.fn, "executable")
    stub(parsers, "get_parser_config")
    stub(parsers, "get_parser_configs")
  end)

  after_each(function()
    vim.fn.executable:clear()
    parsers.get_parser_config:clear()
    parsers.get_parser_configs:clear()
  end)

  it("does not return experimental parsers", function()
    local mock_c_parser = {
      install_info = {
        url = "https://github.com/tree-sitter/tree-sitter-c",
        files = { "src/parser.c" },
      },
      maintainers = { "@vigoux" },
    }

    local mock_list = {
      c = mock_c_parser,
    }

    parsers.get_parser_config.returns(mock_c_parser)
    parsers.get_parser_configs.returns(mock_list)

    assert.same(parsers.maintained_parsers(), vim.tbl_keys(mock_list))
  end)
end)
