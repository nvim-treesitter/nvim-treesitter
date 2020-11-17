(identifier) @variable

(name) @variable
(type) @type
(comment) @comment

(enum_definition
  (name) @constant) @Statement

(function_definition
  (name) @function
  (parameters
    (identifier)* @parameter) @punctuation.bracket) @Statement

(return_statement) @Statement

(variable_statement
  (inferred_type)? @operator) @Statement

(call (identifier) @function) @punctuation.bracket
(attribute (attribute_call (identifier) @function) @punctuation.bracket)

; simple items
[ (binary_operator) (comparison_operator) ] @operator
[ (false) (true) ] @boolean
(string) @string
(integer) @number
