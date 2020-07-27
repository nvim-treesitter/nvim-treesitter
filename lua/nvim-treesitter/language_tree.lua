local api = vim.api
local ts = vim.treesitter
local parsers = require"nvim-tresitter.parsers"
local query = require"nvim-treesitter.query"
local hl = require"nvim-treesitter.highlight"

local ts_hs_ns = api.nvim_get_namespaces()["treesitter_hl"]

local M = {}

local LanguageTree = {}

function LanguageTree.new(bufnr, language, ranges)
  local buffer = bufnr or api.nvim_get_current_buf()
  local lang = language or parsers.get_buf_lang(bufnr)

  if ranges then
    parser.set_included_ranges(ranges)
  end

  local hl_query = hl.create_highlighter(bufnr, lang)
  local injection_query = query.get_query(lang, "injections")

  local self = setmetatable({
    buf = buffer,
    hl_query = hl_query,
    injection_query = injection_query,
    children = {}
  }, LanguageTree)

  self.parser = ts.get_parser(buffer, lang, {
    on_changedtree = function(...) self:on_changedtree(...) end
  })

  return end

function LanguageTree:on_changedtree(changes)
  -- Get a fresh root
  if not self.injection_query then return end
  local root = self.parser.tree:root()

  for _, ch in ipairs(changes or {}) do

    for match in query.iter_prepared_matches(self.injection_query, changed_node, self.buf, ch[1], ch[3] + 1) do
      if match.content then
        local start_row, start_col, end_row, end_col = match.content:range()
        -- TODO(vigoux): this might be quite wrong
        api.nvim_buf_clear_namespace(self.buf, ts_hs_ns, start_row, end_row)

        -- Language injection here
        if match.lang then

          -- Prepare the child if not already done
          if not self.children[match.lang] then
            self.children[match.lang] = { ranges = {} }
          end
        end
      end
    end
  end
end

return M
