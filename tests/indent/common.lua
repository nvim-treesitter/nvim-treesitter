local M = {}

local t = require('test.testutil')

M.XFAIL = 'xfail'

--- Compare the indentation of `before` (expected) and `after` (found) line by line.
--- @return table<integer, {[1]: integer, [2]: integer}>? errors found and expected indent per line
local function indent_errors(before, after)
  local errors = {}
  local ok = true
  for line = 1, #before do
    local expected = #string.match(before[line], '^%s*')
    local found = #string.match(after[line] or '', '^%s*')
    if expected ~= found then
      errors[line] = { found, expected }
      ok = false
    end
  end
  return not ok and errors or nil
end

--- Format a side-by-side diff of found and expected lines.
local function format_indent(before, after, errors)
  -- find minimal width if any line is longer
  local width = 40
  for _, line in ipairs(after) do
    width = #line > width and #line or width
  end
  width = width + 3

  local function pad(str)
    return str .. string.rep(' ', width - #str)
  end

  local output = {
    'Incorrect indentation',
    string.format('%8s %2s %s %s', '', '', pad('Found:') .. ' ', 'Expected:'),
  }
  for i, line in ipairs(before) do
    local indents = errors[i] and string.format('%d vs %d', errors[i][1], errors[i][2]) or ''
    local marker = errors[i] and '=>' or ''
    table.insert(
      output,
      string.format('%8s %2s |%s |%s', indents, marker, pad(after[i] or ''), line)
    )
  end
  return table.concat(output, '\n')
end

-- Custom assertion better suited for indentation diffs
local function compare_indent(before, after, xfail)
  local errors = indent_errors(before, after)
  if xfail then
    -- known failure: fail if the indentation is correct, so the test gets removed from the list
    assert(errors, 'Expected failure, but indentation is correct')
  elseif errors then
    error(format_indent(before, after, errors), 0)
  end
end

local function set_buf_indent_opts(opts)
  local optnames =
    { 'tabstop', 'shiftwidth', 'softtabstop', 'expandtab', 'filetype', 'lispoptions' }
  for _, opt in ipairs(optnames) do
    if opts[opt] ~= nil then
      vim.bo[opt] = opts[opt]
    end
  end
end

function M.run_indent_test(file, runner, opts)
  t.eq(1, vim.fn.filereadable(file), string.format('File "%s" not readable', file))

  -- load reference file
  vim.cmd(string.format('edit %s', file))
  vim.bo.indentexpr = require('nvim-treesitter').indentexpr
  local before = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  t.eq(require('nvim-treesitter').indentexpr, vim.bo.indentexpr)
  set_buf_indent_opts(opts)

  -- perform the test
  runner()

  -- get file content after the test
  local after = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- clear any changes to avoid 'No write since last change (add ! to override)'
  vim.cmd('edit!')

  return before, after
end

function M.indent_whole_file(file, opts, xfail)
  local before, after = M.run_indent_test(file, function()
    vim.cmd('silent normal gg=G')
  end, opts)

  compare_indent(before, after, xfail)
end

-- Open a file, use `normal o` to insert a new line and compare results
-- @param file path to the initial file
-- @param spec a table with keys:
--   on_line: line on which `normal o` is executed
--   text: text inserted in the new line
--   indent: expected indent before the inserted text (string or int)
-- @param opts buffer options passed to set_buf_indent_opts
function M.indent_new_line(file, spec, opts, xfail)
  local before, after = M.run_indent_test(file, function()
    -- move to the line and input the new one
    vim.cmd(string.format('normal! %dG', spec.on_line))
    vim.cmd(string.format('normal! o%s', spec.text))
  end, opts)

  local indent = type(spec.indent) == 'string' and spec.indent or string.rep(' ', spec.indent)
  table.insert(before, spec.on_line + 1, indent .. spec.text)

  compare_indent(before, after, xfail)

  before, after = M.run_indent_test(file, function()
    -- move to the line and input the new one
    vim.cmd(string.format('normal! %dG$', spec.on_line))
    vim.cmd(
      string.format(vim.api.nvim_replace_termcodes('normal! a<cr>%s', true, true, true), spec.text)
    )
  end, opts)

  indent = type(spec.indent) == 'string' and spec.indent or string.rep(' ', spec.indent)
  table.insert(before, spec.on_line + 1, indent .. spec.text)

  compare_indent(before, after, xfail)
end

local Runner = {}
Runner.__index = Runner

-- Helper to avoid boilerplate when defining tests
-- @param base_dir  all other paths will be resolved relative to this directory
-- @param buf_opts  buffer options passed to set_buf_indent_opts
function Runner:new(base_dir, buf_opts)
  local runner = {}
  runner.base_dir = base_dir
  runner.buf_opts = buf_opts
  return setmetatable(runner, self)
end

function Runner:whole_file(dirs, opts)
  opts = opts or {}
  local expected_failures = opts.expected_failures or {}
  expected_failures = vim.tbl_map(function(f)
    return vim.fs.normalize(vim.fs.joinpath(self.base_dir, f))
  end, expected_failures)
  dirs = type(dirs) == 'table' and dirs or { dirs }
  dirs = vim.tbl_map(function(dir)
    dir = vim.fs.normalize(vim.fs.joinpath(self.base_dir, dir))
    t.eq('directory', (vim.uv.fs_stat(dir) or {}).type, dir)
    return dir
  end, dirs)
  local scandir = function(dir)
    return (vim.fs.find(function()
      return true
    end, { path = dir, limit = math.huge }))
  end
  local files = vim.iter(dirs):map(scandir):flatten()
  for _, file in files:enumerate() do
    t.it(file, function()
      M.indent_whole_file(file, self.buf_opts, vim.tbl_contains(expected_failures, file))
    end)
  end
end

function Runner:new_line(file, spec, title, xfail)
  title = title and title or tostring(spec.on_line)
  t.it(string.format('%s[%s]', file, title), function()
    local path = vim.fs.joinpath(self.base_dir, file)
    M.indent_new_line(path, spec, self.buf_opts, xfail)
  end)
end

M.Runner = Runner

return M
