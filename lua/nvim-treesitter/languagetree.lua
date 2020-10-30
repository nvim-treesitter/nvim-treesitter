local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local tsutils = require'nvim-treesitter.ts_utils'
local TSHighlighter = require'vim.treesitter.highlighter'

local ns = vim.api.nvim_create_namespace("treesitter/highlighter")

local LanguageTree = {}
LanguageTree.__index = LanguageTree

local trees = { }

function LanguageTree.new(bufnr, lang, not_root)
  local buf
  if not bufnr or bufnr == 0 then
    buf = vim.api.nvim_get_current_buf()
  else
    buf = bufnr
  end

  local parser = parsers.get_parser(buf, parsers.ft_to_lang(lang))
  if not parser then return end

  local query = queries.get_query(lang, "highlights")
  if not query then return end

  local self = setmetatable(
    {
      highlighter = TSHighlighter.new(parser, query),
      parser = parser,
      children = {}
    },
    LanguageTree)

  if not not_root then
    trees[buf] = self
    self.parser:register_cbs{
      on_bytes = function() self:update() end
    }
  end

  -- First setup
  self:update()

  return self
end

function LanguageTree:add_child(lang, child)
  if not vim.tbl_contains(self.children, child) then
    table.insert(self.children, child)
  end
end

function LanguageTree:remove_child(lang)
  self.children[lang] = nil
end

function LanguageTree:node_for_range(range)
  for _, child in pairs(self.children) do
    if child:contains(range) then
      return child:node_for_range(range)
    end
  end
end

function LanguageTree:nodes_for_line(range, result)
  result = result or {}

  if self:contains(range, true) then
    table.insert(result, self)
  end

  for _, child in pairs(self.children) do
    if child:contains(range, true) then
      child:nodes_for_line(range, result)
    end
  end

  return result
end

local function range_contains_line(source, dest)
  return source[1] <= dest[1] and source[3] >= dest[3]
end

local function range_contains(source, dest)
  local start_fits = source[1] < dest[1] or (source[1] == dest[1] and source[2] <= dest[2])
  local end_fits = source[3] > dest[3] or (source[3] == dest[3] and source[4] >= dest[4])

  return start_fits and end_fits
end

function LanguageTree:contains(range, line_only)
  for _, source in pairs(self.parser:included_ranges()) do
    local contains_fn = line_only and range_contains_line or range_contains

    if contains_fn(source, range) then
      return true
    end
  end

  return false
end

function LanguageTree:update()
  local query = queries.get_query(self.parser.lang, "injections")
  if not query then return end

  local root = self.parser:parse():root()
  local startl, _, stopl, _ = root:range()

  local injections = {}

  -- Find injections
  for inj in queries.iter_prepared_matches(query, root, self.parser.bufnr, startl, stopl+1) do
    local lang = inj.lang

    if type(lang) ~= "string" then
      lang = tsutils.get_node_text(lang.node, self.parser.bufnr)[1]
    end

    if not lang or not inj.injection.node then
      vim.api.nvim_err_writeln("Invalid match encountered")
      return nil
    end

    if not injections[lang] then
      injections[lang] = {}
    end

    table.insert(injections[lang], inj.injection.node)
  end

  local seen = {}

  -- Update each child accordingly
  -- TODO(vigoux): for now avoid languages that include themselves, will
  -- be fixed when managing our own parsers
  for lang, ranges in pairs(injections) do

    if lang ~= self.parser.lang then

      if not self.children[lang] then
        self.children[lang] = LanguageTree.new(self.parser.bufnr, lang, true)
      end

      if self.children[lang] then
        self.children[lang].parser:set_included_ranges(ranges)
        self.children[lang]:update()
        seen[lang] = true
      end
    end
  end

  -- Clean up unused parsers
  for lang, _ in pairs(self.children) do
    if not seen[lang] then
      self:remove_child(lang)
    end
  end
end

function LanguageTree._on_line(_, _win, buf, line)
  local tree = trees[buf]
  if not tree then return end

  local line_len = #(vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1])

  local matches = tree:nodes_for_line { line, 0, line, line_len } -- TODO proper search here

  -- Matches are from least specific to most specific range (parent -> child)
  for _, match in ipairs(matches) do
    TSHighlighter._on_line("line", _win, buf, line, match.highlighter)
  end
end

vim.api.nvim_set_decoration_provider(ns, {
  on_buf = TSHighlighter._on_buf;
  on_win = TSHighlighter._on_win;
  on_line = LanguageTree._on_line;
})

return LanguageTree
