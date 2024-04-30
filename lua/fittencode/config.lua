local M = {}

---@class FittenCodeOptions
M.options = {
  -- Same options as `fittentech.fitten-code` in vscode
  action = {
    document_code = {
      -- Show "Fitten Code - Document Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    edit_code = {
      -- Show "Fitten Code - Edit Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    explain_code = {
      -- Show "Fitten Code - Explain Code" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    find_bugs = {
      -- Show "Fitten Code - Find Bugs" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    generate_unit_test = {
      -- Show "Fitten Code - Generate UnitTest" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
    start_chat = {
      -- Show "Fitten Code - Start Chat" in the editor context menu, when you right-click on the code.
      show_in_editor_context_menu = true,
    },
  },
  disable_specific_inline_completion = {
    -- Disable auto-completion for some specific file suffixes by entering them below
    -- For example, `suffixes = {'lua', 'cpp'}`
    suffixes = {},
  },
  inline_completion = {
    -- Enable inline code completion.
    enable = true,
  },
  delay_completion = {
    -- Delay time for inline completion (in milliseconds).
    ---@type integer
    delaytime = 0,
  },
  syntax_highlighting = {
    -- Use the Neovim Theme colors for syntax highlighting in the diff viewer.
    use_neovim_colors = false,
  },
  -- Set the mode of the completion.
  -- Available options:
  -- - 'inline' (default)
  -- - 'source'
  completion_mode = 'inline',
  use_default_keymaps = true,
  ---@class LogOptions
  log = {
    level = vim.log.levels.WARN,
  },
}

-- Private options
M.internal = {
  virtual_text = {
    inline = vim.fn.has('nvim-0.10') == 1,
  },
}

---@param opts? FittenCodeOptions
function M.setup(opts)
  M.options = vim.tbl_deep_extend('force', M.options, opts or {})
end

return M
