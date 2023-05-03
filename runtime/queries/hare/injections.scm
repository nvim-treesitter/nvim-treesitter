((comment) @injection.content
 (#set! injection.language "comment"))

((call_expression
  . (_) @_fnname
  . "("
  . (_ [(string_content) (raw_string_content)] @injection.content)
  . ")")
  (#any-of? @_fnname "compile" "regex::compile")
  (#set! injection.language "regex"))
