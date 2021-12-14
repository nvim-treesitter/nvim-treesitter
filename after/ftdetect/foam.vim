" Last Change: 2021 Dec 13

function! s:foamFile(path)
    let l:lines = getline(1, 10)
    for line in lines
        if match(line, 'FoamFile') >= 0
            set filetype=foam
        endif
    endfor
endfunction

autocmd FileType BufNewFile,BufRead *Dict,*Properties,fvSchemes,fvSolution,*/constant/g,*/0/* call s:foamFile(expand("%"))
autocmd FileType cpp call s:foamFile(expand("%"))
