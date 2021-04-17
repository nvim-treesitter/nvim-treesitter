local M = {}

local assert = require('luassert')

function M.set_buf_indent_opts(opts)
  local optnames = {'tabstop', 'shiftwidth', 'softtabstop', 'expandtab', 'filetype'}
  for _, opt in ipairs(optnames) do
    if opts[opt] ~= nil then
      vim.bo[opt] = opts[opt]
    end
  end
end

function M.run_indent_test(file, runner, opts)
  assert.are.same(1, vim.fn.filereadable(file))

  -- load reference file
  vim.cmd(string.format('edit %s', file))
  local before = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- FIXME: why this is not set automatically?
  vim.bo.indentexpr = 'nvim_treesitter#indent()'
  assert.are.same('nvim_treesitter#indent()', vim.bo.indentexpr)

  M.set_buf_indent_opts(opts)

  -- perform the test
  runner()

  -- get file content after the test
  local after = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- clear any changes to avoid 'No write since last change (add ! to override)'
  vim.cmd 'edit!'

  return before, after
end

function M.indent_whole_file(file, opts)
  local before, after = M.run_indent_test(file, function()
    vim.cmd 'silent normal gg=G'
  end, opts)

  assert.are.same(before, after)
end

-- Open a file, use `normal o` to insert a new line and compare results
-- @param file path to the initial file
-- @param spec a table with keys:
--   on_line: line on which `normal o` is executed
--   text: text inserted in the new line
--   indent: expected indent before the inserted text (string or int)
-- @param opts buffer options passed to M.set_buf_indent_opts
function M.indent_new_line(file, spec, opts)
  local before, after = M.run_indent_test(file, function()
    -- move to the line and input the new one
    vim.cmd(string.format('normal! %dG', spec.on_line))
    vim.cmd(string.format('normal! o%s', spec.text))
  end, opts)

  local indent = type(spec.indent) == 'string' and spec.indent or string.rep(' ', spec.indent)

  -- print('# before:\n', table.concat(before, '\n'))
  -- print('# after:\n', table.concat(after, '\n'))

  table.insert(before, spec.on_line + 1, indent .. spec.text)
  assert.are.same(before, after)
end

return M
