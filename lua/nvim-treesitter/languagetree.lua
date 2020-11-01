local parsers = require'nvim-treesitter.parsers'
local queries = require'nvim-treesitter.query'
local tsutils = require'nvim-treesitter.ts_utils'
local TSHighlighter = require'vim.treesitter.highlighter'

local ns = vim.api.nvim_create_namespace("treesitter/highlighter")

local LanguageTree = {}
LanguageTree.__index = LanguageTree

local trees = { }

function LanguageTree.new(bufnr, lang, opts)
  local buf

  opts = opts or {}

  if not bufnr or bufnr == 0 then
    buf = vim.api.nvim_get_current_buf()
  else
    buf = bufnr
  end

  local is_root = opts.root ~= false
  local parser = vim.treesitter.get_parser(buf, parsers.ft_to_lang(lang), {}, {
    id = opts.parser_id,
    skip_byte_cb = not is_root
  })
  if not parser then return end

  local query = queries.get_query(lang, "highlights")
  if not query then return end

  local self = setmetatable(
    {
      highlighter = TSHighlighter.new(parser, query, {
        id = parser.id
      }),
      parser = parser,
      children = {}
    },
    LanguageTree)

  if is_root then
    trees[buf] = self
    self.parser:register_cbs{
      on_bytes = function(...)
        -- Update all the trees before we run the injection updates.
        self:on_bytes(...)
        self:update()
      end
    }
  end

  -- If lazy_update is true it means we are updating at a later
  -- time... IE when ranges are set
  if not opts.lazy_update then
    -- First setup
    self:update()
  end

  return self
end

--- Runs a byte update on the entire tree of languages.
function LanguageTree:on_bytes(...)
  local args = {...}

  self:for_each_child(function(tree)
    tree.parser:_on_bytes(unpack(args))
  end, {include_self = false, recursive = true})
end

function LanguageTree:add_child(lang, child)
  self.children[lang] = child
end

function LanguageTree:remove_child(lang)
  self.children[lang] = nil
end

function LanguageTree:get_child(lang, index)
  return self.children[lang] and self.children[lang][index] or nil
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

  for lang, child in pairs(self.children) do
    if child:contains(range, true) then
      child:nodes_for_line(range, result)
    end
  end

  return result
end

function LanguageTree:contains(range, line_only)
  for _, region in pairs(self.highlighter.regions) do
    local contains = line_only and region:intersects_line(range[1]) or region:is_in_range(range)

    if contains then
      return true
    end
  end

  return false
end

function LanguageTree:for_each_child(fn, opts)
  opts = opts or {}

  if opts.include_self then
    fn(self, self.parser.lang)
  end

  for lang, tree in pairs(self.children) do
    fn(tree, lang, i)

    if opts.recursive then
      tree:for_each_child(fn, {include_self = false, recursive = true})
    end
  end
end

function LanguageTree:update()
  local query = queries.get_query(self.parser.lang, "injections")

  if not query then
    self.highlighter:parse()
    return
  end

  local regions = self.highlighter:parse()
  local injections = {}

  -- Find injections
  for _, region in ipairs(regions) do
    for inj in queries.iter_prepared_matches(query, region.root, self.parser.bufnr, region.topline, region.botline+1) do
      local lang = inj.lang

      if type(lang) ~= "string" then
        lang = tsutils.get_node_text(lang.node, self.parser.bufnr)[1]
      end

      if not lang or not inj.injection.node then
        vim.api.nvim_err_writeln("Invalid match encountered")
        return nil
      end

      if not injections[lang] then
        injections[lang] = { global = {}, isolated = {} }
      end

      if inj.isolated then
        table.insert(injections[lang].isolated, {inj.injection.node})
      else
        table.insert(injections[lang].global, inj.injection.node)
      end
    end
  end

  local seen = {}

  -- Update each child accordingly
  for lang, injection in pairs(injections) do
    local child = self.children[lang]

    if not child then
      child = LanguageTree.new(self.parser.bufnr, lang, {
        parser_id = self.parser.id .. "_" .. lang,
        root = false,
        lazy_update = true
      })

      self:add_child(lang, child)
    end

    local ranges = {}

    if #injection.global > 0 then
      table.insert(ranges, injection.global)
    end

    if #injection.isolated > 0 then
      vim.list_extend(ranges, injection.isolated)
    end

    child.highlighter:set_ranges(ranges)
    child:update()

    seen[lang] = true
  end

  -- Clean up unused parsers
  for lang, children in pairs(self.children) do
    if not seen[lang] and self.children[lang] then
      self.children[lang].highlighter:destroy()
      self.children[lang] = nil
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
