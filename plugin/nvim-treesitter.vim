" Last Change: 2020 avril 19

if exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
ts_installable_parsers = function()
  return table.concat(require'nvim-treesitter'.available_parsers(), '\n')
end
require'nvim-treesitter'._root.setup()
EOF

let g:loaded_nvim_treesitter = 1

augroup NvimTreesitter
augroup END
