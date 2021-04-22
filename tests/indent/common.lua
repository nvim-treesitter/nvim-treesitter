local M = {}

local assert = require('luassert')
local say = require('say')

local function same_indent(state, arguments)
  local before = arguments[1]
  local after = arguments[2]

  local ok = true
  local errors = { before = {}, after = {} }
  for line = 1,#before do
    if before[line] ~= after[line] then
      -- store the actual indentation length for each line
      errors.before[line] = #string.match(before[line], '^%s*')
      errors.after[line] = #string.match(after[line], '^%s*')
      ok = false
    end
  end

  -- we will always use only a single argument, passing the other one in fmtargs
  arguments.fmtargs = { { errors = errors, other = after } }
  arguments.fmtargs[2] = { errors = errors, other = after }

  return ok
end

local function format_indent(arg, fmtargs)
  -- find minimal width if any line is longer
  local width = 40
  for _, line in ipairs(fmtargs.other) do
    width = #line > width and #line or width
  end

  width = width + 3
  local header_fmt = '%8s %2s%-' .. tostring(width + 1) .. 's %s'
  local fmt = '%8s %2s |%-' .. tostring(width) .. 's |%s'

  local output = {header_fmt:format('', '', 'Found:', 'Expected:')}

  for i, line in ipairs(arg) do
    if fmtargs.errors.before[i] then
      local indents = string.format('%d vs %d', fmtargs.errors.after[i], fmtargs.errors.before[i])
      table.insert(output, fmt:format(indents, '=>', fmtargs.other[i], line))
    else
      table.insert(output, fmt:format('', '', fmtargs.other[i], line))
    end
  end

  return table.concat(output, '\n')
end

say:set_namespace('en')
say:set('assertion.same_indent.positive', 'Incorrect indentation\n%s')
say:set('assertion.same_indent.negative', 'Incorrect indentation\n%s')
assert:register('assertion', 'same_indent', same_indent,
  'assertion.same_indent.positive', 'assert.same_indent.negative')

-- Custom assertion better suited for indentation diffs
local function compare_indent(before, after)
  assert:add_formatter(format_indent)
  assert.is.same_indent(before, after)
  assert:remove_formatter(format_indent)
end

local function set_buf_indent_opts(opts)
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

  assert.are.same('nvim_treesitter#indent()', vim.bo.indentexpr)
  set_buf_indent_opts(opts)

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

  compare_indent(before, after)
end

-- Open a file, use `normal o` to insert a new line and compare results
-- @param file path to the initial file
-- @param spec a table with keys:
--   on_line: line on which `normal o` is executed
--   text: text inserted in the new line
--   indent: expected indent before the inserted text (string or int)
-- @param opts buffer options passed to set_buf_indent_opts
function M.indent_new_line(file, spec, opts)
  local before, after = M.run_indent_test(file, function()
    -- move to the line and input the new one
    vim.cmd(string.format('normal! %dG', spec.on_line))
    vim.cmd(string.format('normal! o%s', spec.text))
  end, opts)

  local indent = type(spec.indent) == 'string' and spec.indent or string.rep(' ', spec.indent)
  table.insert(before, spec.on_line + 1, indent .. spec.text)

  compare_indent(before, after)
end

return M
