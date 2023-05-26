#!/usr/bin/env -S nvim -l

vim.opt.runtimepath:append('.')
local util = require('nvim-treesitter.util')
local parsers = require('nvim-treesitter.parsers')

---@class Parser
---@field name string
---@field parser ParserInfo

local generated_text = [[
Language | Tier | Queries | CLI | NPM | Maintainer
-------- |:----:|:-------:|:---:|:---:| ----------
]]
local footnotes = ''

for _, name in ipairs(parsers.get_names()) do
  local p = parsers.configs[name]
  -- language
  if p.install_info then
    generated_text = generated_text
      .. '['
      .. name
      .. ']('
      .. p.install_info.url
      .. ')'
      .. (p.readme_note and '[^' .. name .. ']' or '')
      .. ' | '
  else
    generated_text = generated_text
      .. name
      .. ' (queries only)'
      .. (p.readme_note and '[^' .. name .. ']' or '')
      .. ' | '
  end

  if p.readme_note then
    footnotes = footnotes .. '[^' .. name .. ']: ' .. p.readme_note .. '\n'
  end

  -- tier
  generated_text = generated_text .. (p.tier and parsers.tiers[p.tier] or '') .. ' | '

  -- queries
  generated_text = generated_text
    .. '`'
    .. (vim.uv.fs_stat('runtime/queries/' .. name .. '/highlights.scm') and 'H' or ' ')
    .. (vim.uv.fs_stat('runtime/queries/' .. name .. '/folds.scm') and 'F' or ' ')
    .. (vim.uv.fs_stat('runtime/queries/' .. name .. '/indents.scm') and 'I' or ' ')
    .. (vim.uv.fs_stat('runtime/queries/' .. name .. '/injections.scm') and 'J' or ' ')
    .. (vim.uv.fs_stat('runtime/queries/' .. name .. '/locals.scm') and 'L' or ' ')
    .. '` | '

  -- CLI
  generated_text = generated_text
    .. (p.install_info and p.install_info.requires_generate_from_grammar and '✓' or '')
    .. ' | '

  -- NPM
  generated_text = generated_text
    .. (p.install_info and p.install_info.generate_requires_npm and '✓' or '')
    .. ' | '

  -- Maintainer
  generated_text = generated_text
    .. (p.maintainers and table.concat(p.maintainers, ', ') or '')
    .. '\n'
end
generated_text = generated_text .. footnotes

local readme = 'SUPPORTED_LANGUAGES.md'
local readme_text = util.read_file(readme)

local new_readme_text = string.gsub(
  readme_text,
  '<!%-%-parserinfo%-%->.*<!%-%-parserinfo%-%->',
  '<!--parserinfo-->\n' .. generated_text .. '<!--parserinfo-->'
)

util.write_file(readme, new_readme_text)

if string.find(readme_text, generated_text, 1, true) then
  print(readme .. ' is up-to-date\n')
else
  print('New ' .. readme .. ' was written\n')
end
