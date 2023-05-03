(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "arduino"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "arduino"))

((comment) @injection.content 
 (#set! injection.language "comment"))
