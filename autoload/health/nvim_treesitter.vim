function! health#nvim_treesitter#check()
  lua require 'nvim-treesitter.health'.checkhealth()
endfunction
