local api = vim.api
local ts = vim.treesitter
local utils = require "nvim-treesitter.utils"

local new_lang_api = ts.language.register ~= nil

local filetype_to_parsername = {}

if new_lang_api then
  filetype_to_parsername = setmetatable({}, {
    __newindex = function(_, k, v)
      require("nvim-treesitter.utils").notify(
        "filetype_to_parsername is deprecated, please use 'vim.treesitter.language.register'",
        vim.log.levels.WARN
      )
      ts.language.register(v, k)
    end,
  })
end

local function register_lang(lang, ft)
  if new_lang_api then
    ts.language.register(lang, ft)
    return
  end
  filetype_to_parsername[ft] = lang
end

for ft, lang in pairs {
  javascriptreact = "javascript",
  ecma = "javascript",
  jsx = "javascript",
  sh = "bash",
  html_tags = "html",
  ["typescript.tsx"] = "tsx",
  ["html.handlebars"] = "glimmer",
  systemverilog = "verilog",
  pandoc = "markdown",
  rmd = "markdown",
  quarto = "markdown",
  dosini = "ini",
  confini = "ini",
  svg = "xml",
  xsd = "xml",
  xslt = "xml",
  expect = "tcl",
  mysql = "sql",
  sbt = "scala",
  neomuttrc = "muttrc",
} do
  register_lang(lang, ft)
end

---@class InstallInfo
---@field url string
---@field branch string|nil
---@field revision string|nil
---@field files string[]
---@field generate_requires_npm boolean|nil
---@field requires_generate_from_grammar boolean|nil
---@field location string|nil
---@field use_makefile boolean|nil
---@field cxx_standard string|nil

---@class ParserInfo
---@field install_info InstallInfo
---@field filetype string
---@field maintainers string[]
---@field experimental boolean|nil
---@field readme_name string|nil

---@type ParserInfo[]
local list = setmetatable({}, {
  __newindex = function(table, parsername, parserconfig)
    rawset(table, parsername, parserconfig)
    register_lang(parsername, parserconfig.filetype or parsername)
  end,
})

local function load_parser()
  local filename = utils.join_path(utils.get_package_path(), "parser.json")
  local parsers = vim.fn.filereadable(filename) == 1 and vim.fn.json_decode(vim.fn.readfile(filename)) or {}
  for k, v in pairs(parsers) do
    list[k] = v
  end
end

load_parser()

local M = {
  list = list,
  filetype_to_parsername = filetype_to_parsername,
}

local function get_lang(ft)
  if new_lang_api then
    return ts.language.get_lang(ft)
  end
  return filetype_to_parsername[ft]
end

function M.ft_to_lang(ft)
  local result = get_lang(ft)
  if result then
    return result
  else
    ft = vim.split(ft, ".", { plain = true })[1]
    return get_lang(ft) or ft
  end
end

-- Get a list of all available parsers
---@return string[]
function M.available_parsers()
  local parsers = vim.tbl_keys(M.list)
  table.sort(parsers)
  if vim.fn.executable "tree-sitter" == 1 and vim.fn.executable "node" == 1 then
    return parsers
  else
    return vim.tbl_filter(function(p) ---@param p string
      return not M.list[p].install_info.requires_generate_from_grammar
    end, parsers)
  end
end

function M.get_parser_configs()
  return M.list
end

local parser_files

function M.reset_cache()
  parser_files = setmetatable({}, {
    __index = function(tbl, key)
      rawset(tbl, key, api.nvim_get_runtime_file("parser/" .. key .. ".*", false))
      return rawget(tbl, key)
    end,
  })
end

M.reset_cache()

function M.has_parser(lang)
  lang = lang or M.get_buf_lang(api.nvim_get_current_buf())

  if not lang or #lang == 0 then
    return false
  end
  -- HACK: nvim internal API
  if vim._ts_has_language(lang) then
    return true
  end
  return #parser_files[lang] > 0
end

function M.get_parser(bufnr, lang)
  bufnr = bufnr or api.nvim_get_current_buf()
  lang = lang or M.get_buf_lang(bufnr)

  if M.has_parser(lang) then
    return ts.get_parser(bufnr, lang)
  end
end

-- @deprecated This is only kept for legacy purposes.
--             All root nodes should be accounted for.
function M.get_tree_root(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  return M.get_parser(bufnr):parse()[1]:root()
end

-- Gets the language of a given buffer
---@param bufnr number? or current buffer
---@return string
function M.get_buf_lang(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()
  return M.ft_to_lang(api.nvim_buf_get_option(bufnr, "ft"))
end

return M
