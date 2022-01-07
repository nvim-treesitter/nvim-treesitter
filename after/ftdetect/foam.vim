" Last Change: 2022 Jan 08

function! s:foamFile(path)
    " Return if file type already set
    if (&filetype == 'foam')
        return
    endif

    let l:lines = getline(1, 15)
    let l:f = -1
    let l:o = -1
    for line in lines
        if (match(line, 'FoamFile') >= 0)
            let l:f = index(lines, line)
        endif
        if (match(line, 'object') >= 0)
            let l:o = index(lines, line)
        endif
    endfor
    if ((l:o >= 0) && (l:f) && (l:o > l:f))
        set filetype=foam
    endif
endfunction

autocmd FileType cpp call s:foamFile(expand("%"))
autocmd BufNewFile,BufRead *Dict,*Properties,fvSchemes,fvSolution,*/constant/g,*/0/* call s:foamFile(expand("%"))
