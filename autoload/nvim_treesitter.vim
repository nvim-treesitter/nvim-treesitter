function! s:visual_node(node_range)
  let [l:cursor_start, l:cursor_end] = a:node_range
  if !empty(l:cursor_start) && !empty(l:cursor_end)
    call cursor(l:cursor_start[0]+1, l:cursor_start[1]+1)
    normal v
    call cursor(l:cursor_end[0]+1, l:cursor_end[1])
  endif
endfunction

function! nvim_treesitter#select_node_incr()
  call s:visual_node(luaeval('require"nvim-treesitter.textobj".node_incremental()'))
endfunction

function! nvim_treesitter#select_context_incr()
  call s:visual_node(luaeval('require"nvim-treesitter.textobj".context_incremental()'))
endfunction
