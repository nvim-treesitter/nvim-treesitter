" Last Change: 2020 juin 21

if exists('g:loaded_nvim_treesitter')
  finish
endif

augroup NvimTreesitter
augroup END

let g:loaded_nvim_treesitter = 1

lua << EOF
ts_installable_parsers = function()
  return table.concat(require'nvim-treesitter.parsers'.available_parsers(), '\n')
end
ts_available_modules = function()
  return table.concat(require'nvim-treesitter.configs'.available_modules(), '\n')
end
require'nvim-treesitter'.setup()
EOF

highlight link TSError Error

highlight link TSPunctDelimiter Delimiter
highlight link TSPunctBracket Delimiter
highlight link TSPunctSpecial Delimiter

highlight link TSConstant Constant
highlight link TSConstBuiltin Special
highlight link TSConstMacro Define
highlight link TSString String
highlight link TSStringRegex String
highlight link TSStringEscape SpecialChar
highlight link TSCharacter Character
highlight link TSNumber Number
highlight link TSBoolean Boolean
highlight link TSFloat TSFloat

highlight link TSFunction Function
highlight link TSFuncBuiltin Special
highlight link TSFuncMacro Macro
highlight link TSParameter Identifier
highlight link TSMethod Function
highlight link TSField Identifier
highlight link TSProperty Identifier
highlight link TSConstructor Special

highlight link TSConditional Conditional
highlight link TSRepeat Repeat
highlight link TSLabel Label
highlight link TSOperator Operator
highlight link TSKeyword Keyword
highlight link TSException Exception

highlight link TSType Type
highlight link TSTypeBuiltin Type
highlight link TSStructure Structure
highlight link TSInclude Include

