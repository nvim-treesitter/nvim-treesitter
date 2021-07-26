((call
  function: (attribute
    object: (identifier) @_module)
  arguments: (argument_list (string "\"" @_start "string_content" @regex)))
 (#eq? @_module "re")
 (#match? @_start "^r"))

; Module docstring
(module . (expression_statement (string "string_content" @rst)))

; Class docstring
(class_definition
  body: (block . (expression_statement (string "string_content" @rst))))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string "string_content" @rst))))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string "string_content" @rst)))

(comment) @comment
