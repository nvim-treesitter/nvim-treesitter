local query = require "nvim-treesitter.query"

local function get_matching_nodes(case)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, case.lines)
  local lang_query = vim.treesitter.query.parse(case.lang, case.query)
  local parser = vim.treesitter.get_parser(0, case.lang)
  local tree = parser:parse()[1]
  local root = tree:root()
  local range = { root:range() }
  local nodes = {}
  for match in query.iter_prepared_matches(lang_query, root, 0, range[1], range[3] + 1) do
    local capture = match[case.capture]
    if capture ~= nil then
      local node = capture.node
      table.insert(nodes, { vim.treesitter.get_node_text(node, 0), { node:range() } })
    end
  end
  return nodes
end

describe("make-range", function()
  it("handles full match", function()
    assert.same(
      { { "int argc, char *argv[]", { 0, 9, 0, 31 } } },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration) @_end)
            (#make-range! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional start", function()
    assert.same(
      {
        { "int argc", { 0, 9, 0, 17 } },
        { "int argc, char *argv[]", { 0, 9, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration)? @_start
            .
            (parameter_declaration)  @_end)
            (#make-range! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional end", function()
    assert.same(
      {
        { "int argc, char *argv[]", { 0, 9, 0, 31 } },
        { "char *argv[]", { 0, 19, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration)? @_end)
            (#make-range! "@target" @_start @_end))
        ]],
      }
    )
  end)
end)

describe("make-range-exclude-start", function()
  it("handles full match", function()
    assert.same(
      { { ", char *argv[]", { 0, 17, 0, 31 } } },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration) @_end)
            (#make-range-exclude-start! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional start", function()
    assert.same(
      {
        { "int argc", { 0, 9, 0, 17 } },
        { ", char *argv[]", { 0, 17, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration)? @_start
            .
            (parameter_declaration)  @_end)
            (#make-range-exclude-start! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional end", function()
    assert.same(
      {
        { ", char *argv[]", { 0, 17, 0, 31 } },
        { "", { 0, 31, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration)? @_end)
            (#make-range-exclude-start! "@target" @_start @_end))
        ]],
      }
    )
  end)
end)

describe("make-range-exclude-end", function()
  it("handles full match", function()
    assert.same(
      { { "int argc, ", { 0, 9, 0, 19 } } },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration) @_end)
            (#make-range-exclude-end! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional start", function()
    assert.same(
      {
        { "", { 0, 9, 0, 9 } },
        { "int argc, ", { 0, 9, 0, 19 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration)? @_start
            .
            (parameter_declaration)  @_end)
            (#make-range-exclude-end! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional end", function()
    assert.same(
      {
        { "int argc, ", { 0, 9, 0, 19 } },
        { "char *argv[]", { 0, 19, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration)? @_end)
            (#make-range-exclude-end! "@target" @_start @_end))
        ]],
      }
    )
  end)
end)

describe("make-range-exclusive", function()
  it("handles full match", function()
    assert.same(
      { { ", ", { 0, 17, 0, 19 } } },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration) @_end)
            (#make-range-exclusive! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional start", function()
    assert.same(
      {
        { "", { 0, 9, 0, 9 } },
        { ", ", { 0, 17, 0, 19 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration)? @_start
            .
            (parameter_declaration)  @_end)
            (#make-range-exclusive! "@target" @_start @_end))
        ]],
      }
    )
  end)

  it("handles optional end", function()
    assert.same(
      {
        { ", ", { 0, 17, 0, 19 } },
        { "", { 0, 31, 0, 31 } },
      },
      get_matching_nodes {
        lang = "c",
        lines = { "int main(int argc, char *argv[]) { return 0; }" },
        capture = "@target",
        query = [[
          ((parameter_list
            (parameter_declaration) @_start
            .
            (parameter_declaration)? @_end)
            (#make-range-exclusive! "@target" @_start @_end))
        ]],
      }
    )
  end)
end)
