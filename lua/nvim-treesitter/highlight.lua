local api = vim.api

local configs = require "nvim-treesitter.configs"

local M = {}

---@param config table
---@param lang string
---@return boolean
local function should_enable_vim_regex(config, lang)
  local additional_hl = config.additional_vim_regex_highlighting
  local is_table = type(additional_hl) == "table"

  return additional_hl and (not is_table or vim.tbl_contains(additional_hl, lang))
end

---@param bufnr integer
local function enable_syntax(bufnr)
  api.nvim_buf_set_option(bufnr, "syntax", "ON")
end

---@param bufnr integer
---@param lang string
function M.attach(bufnr, lang)
  local config = configs.get_module "highlight"
  vim.treesitter.start(bufnr, lang)
  if config and should_enable_vim_regex(config, lang) then
    enable_syntax(bufnr)
  end
end

---@param bufnr integer
function M.detach(bufnr)
  vim.treesitter.stop(bufnr)
  enable_syntax(bufnr)
end

---@deprecated
function M.start(...)
  vim.notify(
    "`nvim-treesitter.highlight.start` is deprecated: use `nvim-treesitter.highlight.attach` or `vim.treesitter.start`",
    vim.log.levels.WARN
  )
  M.attach(...)
end

---@deprecated
function M.stop(...)
  vim.notify(
    "`nvim-treesitter.highlight.stop` is deprecated: use `nvim-treesitter.highlight.detach` or `vim.treesitter.stop`",
    vim.log.levels.WARN
  )
  M.detach(...)
end

return M
