((comment) @injection.content 
 (#set! injection.language "comment"))

(call_expression
  (selector_expression) @_function (#any-of? @_function
                                    "regexp.Match"
                                    "regexp.MatchReader"
                                    "regexp.MatchString"
                                    "regexp.Compile"
                                    "regexp.CompilePOSIX"
                                    "regexp.MustCompile"
                                    "regexp.MustCompilePOSIX")
  (argument_list
    . 
    [
     (raw_string_literal) 
     (interpreted_string_literal)
    ] @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "regex")))

(
  (comment)+ @injection.content
  .
  (import_declaration
    (import_spec path: (interpreted_string_literal) @_import_c))
  (#eq? @_import_c "\"C\"")
  (#lua-match? @injection.content "^/%*.*%*/$")
  (#set! injection.language "c")
  (#offset! @injection.content 0 2 0 -2)
  (#set! injection.combined))

(
  (comment)+ @injection.content 
  .
  (import_declaration
    (import_spec path: (interpreted_string_literal) @_import_c))
  (#eq? @_import_c "\"C\"")
  (#lua-match? @injection.content "^//")
  (#set! injection.language "c")
  (#offset! @injection.content 0 2 0 0)
  (#set! injection.combined))
