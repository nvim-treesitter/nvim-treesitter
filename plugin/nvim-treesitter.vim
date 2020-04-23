" Last Change: 2020 avril 23

if exists('g:loaded_nvim_treesitter')
  finish
endif

augroup NvimTreesitter
augroup END

let g:loaded_nvim_treesitter = 1

lua << EOF
ts_installable_parsers = function()
  return table.concat(require'nvim-treesitter.configs'.available_parsers(), '\n')
end
ts_available_modules = function()
  return table.concat(require'nvim-treesitter.configs'.available_modules(), '\n')
end
require'nvim-treesitter'.setup()
EOF
