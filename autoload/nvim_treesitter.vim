function! nvim_treesitter#statusline(len) abort
  return luaeval("require'nvim-treesitter'.statusline(_A)", a:len)
endfunction

function! nvim_treesitter#foldexpr() abort
	return luaeval(printf('require"nvim-treesitter.fold".get_fold_indic(%d)', v:lnum))
endfunction

function! nvim_treesitter#installable_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.parsers'.available_parsers()") + ['all'], "\n")
endfunction

function! nvim_treesitter#installed_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.info'.installed_parsers()") + ['all'], "\n")
endfunction

function! nvim_treesitter#available_modules(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.configs'.available_modules()"), "\n")
endfunction
