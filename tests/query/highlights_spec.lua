local ts = vim.treesitter

local COMMENT_NODES = {
  markdown = 'html_block',
}

local function check_assertions(file)
  assert.same(
    1,
    vim.fn.executable('highlight-assertions'),
    '"highlight-assertions" not executable!'
      .. ' Get it via "cargo install --git https://github.com/theHamsta/highlight-assertions"'
  )
  local buf = vim.fn.bufadd(file)
  vim.fn.bufload(file)
  local ft = vim.bo[buf].filetype
  local lang = vim.treesitter.language.get_lang(ft) or ft
  local comment_node = COMMENT_NODES[lang] or 'comment'
  local assertions = vim.fn.json_decode(
    vim.fn.system(
      "highlight-assertions -p '"
        .. vim.api.nvim_get_runtime_file('parser/' .. lang .. '.so', false)[1]
        .. "' -s '"
        .. file
        .. "' -c "
        .. comment_node
    )
  )
  assert.True(#assertions > 0, 'No assertions detected!')

  local parser = ts.get_parser(buf)

  parser:parse(true)

  for _, assertion in ipairs(assertions) do
    local row = assertion.position.row
    local col = assertion.position.column
    assert.is.number(row)
    assert.is.number(col)

    local captures = {}
    parser:for_each_tree(function(tstree, tree)
      if not tstree then
        return
      end

      local root = tstree:root()
      local root_start_row, _, root_end_row, _ = root:range()

      -- Only worry about trees within the line range
      if root_start_row > row or root_end_row < row then
        return
      end

      local query = ts.query.get(tree:lang(), 'highlights')
      if not query then
        return
      end

      for id, node, _ in query:iter_captures(root, buf, row, row + 1) do
        if ts.is_in_node_range(node, row, col) then
          local capture = query.captures[id]
          if capture ~= nil and capture ~= 'conceal' and capture ~= 'spell' then
            captures[capture] = true
          end
        end
      end
    end)
    if assertion.expected_capture_name:match('^!') then
      assert.Falsy(
        captures[assertion.expected_capture_name:sub(2)],
        'Error in '
          .. file
          .. ':'
          .. (row + 1)
          .. ':'
          .. (col + 1)
          .. ': expected "'
          .. assertion.expected_capture_name
          .. '", captures: '
          .. vim.inspect(vim.tbl_keys(captures))
      )
    else
      assert.True(
        captures[assertion.expected_capture_name],
        'Error in '
          .. file
          .. ':'
          .. (row + 1)
          .. ':'
          .. (col + 1)
          .. ': expected "'
          .. assertion.expected_capture_name
          .. '", captures: '
          .. vim.inspect(vim.tbl_keys(captures))
      )
    end
  end
end

describe('highlight queries', function()
  local files = vim.fn.split(vim.fn.glob('tests/query/highlights/**/*.*'))
  for _, file in ipairs(files) do
    it(file, function()
      check_assertions(file)
    end)
  end
end)
