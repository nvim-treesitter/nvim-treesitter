function! nvim_treesitter#statusline(len)
  return luaeval("require'nvim-treesitter'.statusline(_A)", a:len)
endfunction
