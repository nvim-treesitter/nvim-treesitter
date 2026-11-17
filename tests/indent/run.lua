-- Runs in the Nvim under test (see tests/indent/common.lua).
local M = {}

local function set_buf_indent_opts(opts)
  local optnames =
    { 'tabstop', 'shiftwidth', 'softtabstop', 'expandtab', 'filetype', 'lispoptions' }
  for _, opt in ipairs(optnames) do
    if opts[opt] ~= nil then
      vim.bo[opt] = opts[opt]
    end
  end
end

--- Open `file`, run `runner` and return the buffer lines before and after.
--- @param file string
--- @param runner fun()
--- @param opts table buffer options passed to set_buf_indent_opts
--- @return string[] before, string[] after
local function run_indent_test(file, runner, opts)
  assert(vim.uv.fs_access(file, 'R'), string.format('File "%s" not readable', file))

  -- load reference file
  vim.cmd.edit(vim.fn.fnameescape(file))
  vim.bo.indentexpr = require('nvim-treesitter').indentexpr
  local before = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  set_buf_indent_opts(opts)

  -- perform the test
  runner()

  -- get file content after the test
  local after = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- clear any changes to avoid 'No write since last change (add ! to override)'
  vim.cmd.edit({ bang = true })

  return before, after
end

--- Reindent the whole file with `gg=G`.
--- @return string[] before, string[] after
function M.whole_file(file, opts)
  return run_indent_test(file, function()
    vim.cmd.normal({ 'gg=G', bang = true, mods = { silent = true } })
  end, opts)
end

--- Insert `text` in a new line after line `on_line`, once with `o` and once with `a<CR>`.
--- @return string[][] # { before, after } for each way of inserting
function M.new_line(file, on_line, text, opts)
  local o_before, o_after = run_indent_test(file, function()
    vim.cmd.normal({ on_line .. 'G', bang = true })
    vim.cmd.normal({ 'o' .. text, bang = true })
  end, opts)

  local cr_before, cr_after = run_indent_test(file, function()
    vim.cmd.normal({ on_line .. 'G$', bang = true })
    vim.cmd.normal({ 'a' .. vim.keycode('<CR>') .. text, bang = true })
  end, opts)

  return { { o_before, o_after }, { cr_before, cr_after } }
end

return M
