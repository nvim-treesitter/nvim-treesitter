local M = {}

function M.set_buf_indent_opts(opts)
    local optnames = {'tabstop', 'shiftwidth', 'softtabstop', 'expandtab'}
    for _, opt in ipairs(optnames) do
      if opts[opt] ~= nil then
        vim.bo[opt] = opts[opt]
      end
    end
end

function M.indent_whole_file(file, opts)
  assert.are.same(1, vim.fn.filereadable(file))

  -- load reference file
  vim.cmd(string.format('edit %s', file))
  local reference = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- FIXME: why this is not set automatically?
  vim.bo.indentexpr = 'nvim_treesitter#indent()'
  assert.are.same('nvim_treesitter#indent()', vim.bo.indentexpr)

  M.set_buf_indent_opts(opts)

  -- indent the whole file
  vim.cmd 'silent normal gg=G'
  local indented =  vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- clear any changes to avoid 'No write since last change (add ! to override)'
  vim.cmd 'edit!'

  -- compare before and after
  assert.are.same(reference, indented)
end

return M
