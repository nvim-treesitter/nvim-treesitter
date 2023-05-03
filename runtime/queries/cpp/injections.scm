(preproc_function_def
 (preproc_arg) @injection.content
 (#set! injection.language "cpp"))

(preproc_call
 (preproc_arg) @injection.content
 (#set! injection.language "cpp"))

((comment) @injection.content 
 (#set! injection.language "comment"))

(raw_string_literal
  delimiter: (raw_string_delimiter) @injection.language
  (raw_string_content) @injection.content)
