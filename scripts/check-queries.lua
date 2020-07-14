-- Execute as `nvim --headless -c "luafile ./scripts/check-queries.lua"`
local function do_check()
  local parsers = require 'nvim-treesitter.parsers'.available_parsers()
  local queries = require 'nvim-treesitter.query'
  local query_types = {'highlights', 'locals', 'textobjects'}

  for _, lang in pairs(parsers) do
    for _, query_type in pairs(query_types) do
      print('Checking '..lang..' '..query_type)
      queries.get_query(lang, query_type)
    end
  end
end


local ok, err = pcall(do_check)
if ok then
  print('Check successful!\n')
  vim.cmd('q')
else
  print('Check failed:')
  print(err)
  print('\n')
  vim.cmd('cq')
end
