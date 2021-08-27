; CREDITS @stumash (stuart.mashaal@gmail.com)

;; variables

(identifier) @variable

((identifier) @variable.builtin
 (#match? @variable.builtin "^this$"))

;; types

(type_identifier) @type

(class_definition
  name: (identifier) @type)

(object_definition
  name: (identifier) @type)

(trait_definition
  name: (identifier) @type)

(type_definition
  name: (type_identifier) @type)

; method definition

(class_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))
(object_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))
(trait_definition
  body: (template_body
    (function_definition
      name: (identifier) @method)))

; method invocation

(call_expression
  function: (identifier) @function)

(call_expression
  function: (field_expression
    field: (identifier) @method))

(generic_function
  function: (identifier) @function)

(
  (identifier) @function.builtin
  (#match? @function.builtin "^super$")
)

; function definitions

(function_definition
  name: (identifier) @function)

(parameter
  name: (identifier) @parameter)

; expressions

(field_expression field: (identifier) @property)

(infix_expression operator: (identifier) @operator)
(infix_expression operator: (operator_identifier) @operator)
(infix_type operator: (operator_identifier) @operator)
(infix_type operator: (operator_identifier) @operator)

; literals

(boolean_literal) @boolean
(integer_literal) @number
(floating_point_literal) @float
(string) @string

[
(symbol_literal)
(string)
(character_literal)
] @string

;; keywords

[
  "abstract"
  "case"
  "class"
  "extends"
  "final"
  "finally"
;; `forSome` existential types not implemented yet
  "implicit"
  "lazy"
;; `macro` not implemented yet
  "object"
  "override"
  "package"
  "private"
  "protected"
  "sealed"
  "trait"
  "type"
  "val"
  "var"
  "with"
] @keyword

(null_literal) @keyword

;; special keywords

"new" @keyword.operator

[
  "else"
  "if"
  "match"
] @conditional

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
]  @punctuation.bracket

[
 "."
 ","
] @punctuation.delimiter

[
  "do"
  "for"
  "while"
  "yield"
] @repeat

"def" @keyword.function

[
 "=>"
 "<-"
] @operator

"import" @include

[
  "try"
  "catch"
  "throw"
] @exception

"return" @keyword.return

(comment) @comment

;; `case` is a conditional keyword in case_block

(case_block
  (case_clause ("case") @conditional))
