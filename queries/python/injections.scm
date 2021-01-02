((call
  function: (attribute
	  object: (identifier) @_re)
  arguments: (argument_list (string) @regex))
 (#eq? @_re "re")
 (#match? @regex "^r.*"))

(class_definition

  body: (block . (expression_statement (string) @rst)))

(function_definition
  body: (block . (expression_statement (string) @rst)))

((expression_statement (assignment)) . (expression_statement (string) @rst))
