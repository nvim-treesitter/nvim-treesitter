vim.opt.runtimepath:append('.')
-- Execute as `nvim --headless -c "luafile ./scripts/update-readme.lua"`

---@class Parser
---@field name string
---@field parser ParserInfo

local parsers = require('nvim-treesitter.parsers').configs
local sorted_parsers = {}
for k, v in pairs(parsers) do
  table.insert(sorted_parsers, { name = k, parser = v })
end
table.sort(sorted_parsers, function(a, b)
  return a.name < b.name
end)

local tiers = require('nvim-treesitter.parsers').tiers

local generated_text = [[
Language | Tier | Queries | CLI | NPM | Maintainer
-------- |:----:|:-------:|:---:|:---:| ----------
]]
local footnotes = ''

for _, v in ipairs(sorted_parsers) do
  local p = v.parser
  -- language
  generated_text = generated_text
    .. '['
    .. v.name
    .. ']('
    .. p.install_info.url
    .. ')'
    .. (p.readme_note and '[^' .. v.name .. ']' or '')
    .. ' | '
  if p.readme_note then
    footnotes = footnotes .. '[^' .. v.name .. ']: ' .. p.readme_note .. '\n'
  end

  -- tier
  generated_text = generated_text .. (p.tier and tiers[p.tier] or '') .. ' | '

  -- queries
  generated_text = generated_text
    .. '`'
    .. (vim.loop.fs_stat('runtime/queries/' .. v.name .. '/highlights.scm') and 'H' or ' ')
    .. (vim.loop.fs_stat('runtime/queries/' .. v.name .. '/folds.scm') and 'F' or ' ')
    .. (vim.loop.fs_stat('runtime/queries/' .. v.name .. '/indents.scm') and 'I' or ' ')
    .. (vim.loop.fs_stat('runtime/queries/' .. v.name .. '/injections.scm') and 'J' or ' ')
    .. '`| '

  -- CLI
  generated_text = generated_text
    .. (p.install_info.requires_generate_from_grammar and '✓' or '')
    .. ' | '

  -- NPM
  generated_text = generated_text .. (p.install_info.generate_requires_npm and '✓' or '') .. ' | '

  -- Maintainer
  generated_text = generated_text
    .. (p.maintainers and table.concat(p.maintainers, ', ') or '')
    .. '\n'
end
generated_text = generated_text .. footnotes

local readme_text = table.concat(vim.fn.readfile('SUPPORTED_LANGUAGES.md'), '\n')

local new_readme_text = string.gsub(
  readme_text,
  '<!%-%-parserinfo%-%->.*<!%-%-parserinfo%-%->',
  '<!--parserinfo-->\n' .. generated_text .. '<!--parserinfo-->'
)
vim.fn.writefile(vim.fn.split(new_readme_text, '\n'), 'SUPPORTED_LANGUAGES.md')

if string.find(readme_text, generated_text, 1, true) then
  print('README.md is up-to-date!')
  vim.cmd('q')
else
  print('New README.md was written. Please commit that change!')
  vim.cmd('cq')
end
