((preproc_def
 (preproc_arg) @injection.content)
 (#lua-match? @injection.content "\n")
 (#set! injection.language "hlsl"))

(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "hlsl"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "hlsl"))

((comment) @injection.content
 (#set! injection.language "comment"))
