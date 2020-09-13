" Last Change: 2020 Aug 13

if exists('g:loaded_nvim_treesitter')
  finish
endif

augroup NvimTreesitter
augroup END

let g:loaded_nvim_treesitter = 1

lua require'nvim-treesitter'.setup()

highlight default TSNone term=none cterm=none gui=none guifg=none guibg=none

highlight default link TSError TSNone

highlight default link TSPunctDelimiter Delimiter
highlight default link TSPunctBracket Delimiter
highlight default link TSPunctSpecial Delimiter

highlight default link TSConstant Constant
highlight default link TSConstBuiltin Special
highlight default link TSConstMacro Define
highlight default link TSString String
highlight default link TSStringRegex String
highlight default link TSStringEscape SpecialChar
highlight default link TSCharacter Character
highlight default link TSNumber Number
highlight default link TSBoolean Boolean
highlight default link TSFloat Float

highlight default link TSFunction Function
highlight default link TSFuncBuiltin Special
highlight default link TSFuncMacro Macro
highlight default link TSParameter Identifier
highlight default link TSParameterReference TSParameter
highlight default link TSMethod Function
highlight default link TSField Identifier
highlight default link TSProperty Identifier
highlight default link TSConstructor Special
highlight default link TSAnnotation PreProc
highlight default link TSAttribute PreProc

highlight default link TSConditional Conditional
highlight default link TSRepeat Repeat
highlight default link TSLabel Label
highlight default link TSOperator Operator
highlight default link TSKeyword Keyword
highlight default link TSKeywordFunction Keyword
highlight default link TSKeywordOperator TSOperator
highlight default link TSException Exception

highlight default link TSType Type
highlight default link TSTypeBuiltin Type
highlight default link TSStructure Structure
highlight default link TSInclude Include

highlight default link TSVariable TSNone
highlight default link TSVariableBuiltin Special

highlight default link TSDefinitionUsage Visual
highlight default link TSDefinition Search

highlight default link TSCurrentScope CursorLine

highlight default link TSText TSNone
highlight default TSStrong term=bold cterm=bold gui=bold
highlight default TSEmphasis term=italic cterm=italic gui=italic
highlight default TSUnderline term=underline cterm=underline gui=underline
highlight default link TSTitle Title
highlight default link TSLiteral String
highlight default link TSURI Underlined

highlight default link TSTag Label
highlight default link TSTagDelimiter Delimiter
