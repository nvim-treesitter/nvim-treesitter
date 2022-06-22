(line
 (word)*
 (word) @_filename
 (code_block) @lua (#offset! @lua 0 1 0 -1)
(#match? @_filename "\.lua:$"))


(line
 (word)*
 (word) @_filename
 (code_block) @vim (#offset! @vim 0 1 0 -1)
(#match? @_filename "\.vim:$"))
