(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "hlsl"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "hlsl"))

((comment) @injection.content
 (#set! injection.language "comment"))
