(hash_bang) @keyword.directive

(comment) @comment @spell

(number) @number

(identifier) @variable

(property_identifier) @property

[
  (string_literal)
  (string_literal_begin)
  (string_literal_continuation)
  (string_literal_end)
] @string

[
  "case"
  "default"
  "else"
  "if"
  "switch"
] @keyword.conditional

"import" @keyword.import

[
  (break_statement)
  (continue_statement)
  "for"
  "loop"
  "repeat"
  "while"
] @keyword.repeat

(for_statement
  "in" @keyword.repeat)

"class" @keyword.type

[
  "return"
  "yield"
] @keyword.return

[
  "catch"
  "defer"
  "throw"
  "try"
] @keyword.exception

[
  "constructor"
  "fun"
  "=>"
] @keyword.function

[
  "_"
  (line)
  "assert"
  ;"async"
  "const"
  "do"
  "extends"
  (fallthrough_statement)
  ;"get"
  ;"match"
  "public"
  ;"set"
  ;"static"
  "var"
  "with"
] @keyword

[
  (this)
  (super)
] @variable.builtin

[
  (false)
  (true)
] @boolean

(void) @constant.builtin

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ";"
  ":"
  "."
  ","
] @punctuation.delimiter

[
  (arithmetic_assignment_operator)
  (comparison_operator)
  (bitwise_operator)
  (additive_operator)
  (multiplicative_operator)
  (logical_operator)
  (unary_operator)
  "->"
  "..."
  "="
  "?"
] @operator

(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(class_member
  (function_decl
    name: (identifier) @function.method))

(function_decl
  name: (identifier) @function)

(class_decl
  name: (identifier) @type)

(invocation
  (identifier) @function.call)

(invocation
  (refinement
    property: (property_identifier) @function.method.call))
