((preproc_def
 (preproc_arg) @injection.content)
 (#lua-match? @injection.content "\n")
 (#set! injection.language "glsl"))

(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "glsl"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "glsl"))

((comment) @injection.content 
 (#set! injection.language "comment"))
