function! nvim_treesitter#statusline(...) abort
  return luaeval("require'nvim-treesitter'.statusline(_A)", get(a:, 1, {}))
endfunction

function! nvim_treesitter#foldexpr() abort
	return luaeval(printf('require"nvim-treesitter.fold".get_fold_indic(%d)', v:lnum))
endfunction

function! nvim_treesitter#installable_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.parsers'.available_parsers()") + ['all', 'maintained'], "\n")
endfunction

function! nvim_treesitter#installed_parsers(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.info'.installed_parsers()") + ['all', 'maintained'], "\n")
endfunction

function! nvim_treesitter#available_modules(arglead, cmdline, cursorpos) abort
  return join(luaeval("require'nvim-treesitter.configs'.available_modules()"), "\n")
endfunction

function! nvim_treesitter#indent() abort
	return luaeval(printf('require"nvim-treesitter.indent".get_indent(%d)', v:lnum))
endfunction

function! nvim_treesitter#query_omnifunc(findstart, base) abort
  if a:findstart
    " locate the start of the word
    let start = col('.') - 2 " -2 necessary to exclude current cursor position and to transfer into 0-based indexing
    let result = matchstrpos(getline('.')[0:start], '\v("|\\|\-|\w)*$')
    return result[1]
  else
    return luaeval(printf("require'nvim-treesitter.query_filetype'.omnifunc([[%s]])", a:base))
  endif
endfunction
