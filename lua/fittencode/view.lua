local api = vim.api
local fn = vim.fn

local M = {}

local function make_rooms_for_virt_text(virt_text)
  -- virtual line not rendering if it's beyond the last line · Issue #20179 · neovim/neovim
  -- https://github.com/neovim/neovim/issues/20179
  local current_line = fn.line('.') + 1
  local max_line = api.nvim_buf_line_count(0)
  local unused_line = 0
  for i = current_line, max_line do
    local curline = vim.api.nvim_buf_get_lines(0, current_line - 1, current_line, false)[1]
    if string.len(curline) == 0 then
      unused_line = unused_line + 1
    else
      break
    end
  end

  local virt_text_count = vim.tbl_count(virt_text)
  local needed_lines = virt_text_count - unused_line
  if needed_lines > 0 then
    for i = 1, needed_lines do
      api.nvim_buf_set_lines(0, current_line + i - 1, current_line + i - 1, false, { '' })
    end
  end
end

local function draw_virt_text(virt_text)
  local first_line = true
  for i, line in ipairs(virt_text) do
    if first_line then
      first_line = false
      api.nvim_buf_set_extmark(0, M.namespace, fn.line('.') - 1, fn.col('.') - 1, {
        virt_text = line,
        virt_text_pos = 'inline',
        hl_mode = 'combine',
      })
    else
      local row = fn.line('.') - 2 + i
      if row < api.nvim_buf_line_count(0) then
        api.nvim_buf_set_extmark(0, M.namespace, row, 0, {
          virt_text = line,
          virt_text_pos = 'inline',
          hl_mode = 'combine',
        })
      end
    end
  end
end

local function clear_ns(namespace, bufnr)
  if namespace ~= nil then
    api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  end
end

local function reset_ns()
  if M.namespace ~= nil then
    clear_ns(M.namespace, 0)
  else
    M.namespace = api.nvim_create_namespace('Fittencode')
  end
end

function M.render_virt_text(virt_text)
  reset_ns()
  make_rooms_for_virt_text(virt_text)
  draw_virt_text(virt_text)
end

local function local_fmt_clear()
  vim.bo.autoindent = false
  vim.bo.smartindent = false
  vim.bo.formatoptions = ''
  vim.bo.textwidth = 0
end

local function local_fmt_recover()
  vim.bo.autoindent = vim.o.autoindent
  vim.bo.smartindent = vim.o.smartindent
  vim.bo.formatoptions = vim.o.formatoptions
  vim.bo.textwidth = vim.o.textwidth
end

function M.set_text(complete_lines)
  local_fmt_clear()

  local row = fn.line('.') - 1
  local col = fn.col('.')
  local count = vim.tbl_count(complete_lines)

  for i = 1, count, 1 do
    local line = complete_lines[i]
    local len = string.len(line)
    if i == 1 then
      if len ~= 0 then
        api.nvim_buf_set_text(0, row, col - 1, row, col - 1, { line })
      end
    else
      local max = api.nvim_buf_line_count(0)
      if row + i - 1 >= max then
        api.nvim_buf_set_lines(0, max, max, false, { line })
      else
        api.nvim_buf_set_text(0, row + i - 1, 0, row + i - 1, 0, { line })
      end
    end
  end

  local first_len = string.len(complete_lines[1])
  if count == 1 and first_len ~= 0 then
    api.nvim_win_set_cursor(0, { row + 1, col + first_len - 1 })
  else
    local last_len = string.len(complete_lines[count])
    api.nvim_win_set_cursor(0, { row + count, last_len })
  end

  local_fmt_recover()
end

function M.clear_virt_text()
  clear_ns(M.namespace, 0)
end

return M
