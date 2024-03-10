local M = {}

---@class FittencodeOptions
M.options = {
  action = {
    document_code = {
      show_in_editor_context_menu = true,
    },
    edit_code = {
      show_in_editor_context_menu = true,
    },
    explain_code = {
      show_in_editor_context_menu = true,
    },
    find_bugs = {
      show_in_editor_context_menu = true,
    },
    generate_unit_test = {
      show_in_editor_context_menu = true,
    },
    start_chat = {
      show_in_editor_context_menu = true,
    },
  },
  disable_specific_inline_completion = {
    suffixes = {},
  },
  inline_completion = {
    enable = true,
  },
  syntax_highlighting = {
    use_neovim_colors = false,
  },
  ---@class LogOptions
  log = {
    level = vim.log.levels.WARN,
  },
}

-- Private options
M.internal = {
  extmark = {
    inline = vim.fn.has('nvim-0.10') == 1,
  },
}

---@param opts? FittencodeOptions
function M.setup(opts)
  M.options = vim.tbl_deep_extend('force', M.options, opts or {})
end

return M
