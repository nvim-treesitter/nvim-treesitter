---@class InstallInfo
---@field url string
---@field branch string|nil
---@field revision string|nil
---@field files string[]
---@field generate_requires_npm boolean|nil
---@field requires_generate_from_grammar boolean|nil
---@field location string|nil
---@field use_makefile boolean|nil

---@class ParserInfo
---@field install_info InstallInfo
---@field filetype string[]
---@field maintainers string[]
---@field requires string[]
---@field tier integer|nil
---@field readme_note string|nil

local M = {}

M.tiers = { 'core', 'stable', 'community', 'unstable' }

---@type ParserInfo[]
M.configs = setmetatable({}, {
  __index = function(_, k)
    local ok, c = pcall(require, 'nvim-treesitter.parsers.' .. k)
    if ok then
      return c
    end
  end,
})

--- @return string[]
M.get_names = function()
  local path =
    vim.fs.joinpath(vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h'), 'parsers')

  local parsers = {}
  for f in vim.fs.dir(path) do
    local lang = f:match('(.*).lua')
    parsers[#parsers + 1] = lang
  end
  table.sort(parsers)

  return parsers
end

-- Get a list of all available parsers
---@param tier integer? only get parsers of specified tier
---@return string[]
function M.get_available(tier)
  local parsers = M.get_names()
  if tier then
    parsers = vim.iter.filter(function(p)
      return M.configs[p].tier == tier
    end, parsers) --[[@as string[] ]]
  end
  if vim.fn.executable('tree-sitter') == 0 or vim.fn.executable('node') == 0 then
    parsers = vim.iter.filter(function(p)
      return not M.configs[p].install_info.requires_generate_from_grammar
    end, parsers) --[[@as string[] ]]
  end
  return parsers
end

return M
