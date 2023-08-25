(macro_invocation
  (token_tree) @injection.content (#set! injection.language "rust"))

(macro_definition
  (macro_rule
    left: (token_tree_pattern) @injection.content 
    (#set! injection.language "rust")))

(macro_definition
  (macro_rule
    right: (token_tree) @injection.content
    (#set! injection.language "rust")))

([
  (line_comment)
  (block_comment)
] @injection.content
 (#set! injection.language "comment"))

((macro_invocation
   macro: ((identifier) @injection.language)
   (token_tree) @injection.content)
 (#eq? @injection.language "html"))

(call_expression
  function: (scoped_identifier
    path: (identifier) @_regex (#eq? @_regex "Regex")
    name: (identifier) @_new (#eq? @_new "new"))
  arguments: (arguments
    (raw_string_literal) @injection.content)
    (#set! injection.language "regex"))

(call_expression
  function: (scoped_identifier
    path: (scoped_identifier (identifier) @_regex (#eq? @_regex "Regex").)
    name: (identifier) @_new (#eq? @_new "new"))
  arguments: (arguments
    (raw_string_literal) @injection.content)
    (#set! injection.language "regex"))

((block_comment) @injection.content
  (#match? @injection.content "/\\*!([a-zA-Z]+:)?re2c")
  (#set! injection.language "re2c"))
