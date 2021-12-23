(preproc_arg) @cpp

((comment) @re2c
 (#match? @re2c "\\\*!(.*:)?re2c")
 (#offset! @re2c 0 2 0 -2))

(comment) @comment
