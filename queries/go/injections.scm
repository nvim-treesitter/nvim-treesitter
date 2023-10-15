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

((comment) @injection.content
  (#match? @injection.content "/\\*!([a-zA-Z]+:)?re2c")
  (#set! injection.language "re2c"))
