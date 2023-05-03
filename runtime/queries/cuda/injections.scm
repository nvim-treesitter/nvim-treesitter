(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "cuda"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "cuda"))

((comment) @injection.content 
 (#set! injection.language "comment"))
