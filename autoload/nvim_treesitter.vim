function! nvim_treesitter#statusline(len)
  return luaeval("require'nvim-treesitter'.statusline(_A)", a:len)
endfunction

function! nvim_treesitter#foldexpr()
	return luaeval(printf('require"nvim-treesitter.fold".get_fold_indic(%d)', v:lnum))
endfunction
