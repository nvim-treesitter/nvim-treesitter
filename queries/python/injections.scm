((call
  function: (attribute
	  object: (identifier) @_re)
  arguments: (argument_list (string) @regex))
 (#eq? @_re "re")
 (#match? @regex "^r.*"))

; Module docstring
((module . (expression_statement (string) @content))
 (#offset! @content 0 3 0 -3)
 (#inject-from! "docstrings" "rst"))

; Class docstring
((class_definition
  body: (block . (expression_statement (string) @content)))
 (#offset! @content 0 3 0 -3)
 (#inject-from! "docstrings" "rst"))

; Function/method docstring
((function_definition
  body: (block . (expression_statement (string) @content)))
 (#offset! @content 0 3 0 -3)
 (#inject-from! "docstrings" "rst"))

; Attribute docstring
(((expression_statement (assignment)) . (expression_statement (string) @content))
 (#offset! @content 0 3 0 -3)
 (#inject-from! "docstrings" "rst"))

(comment) @comment
