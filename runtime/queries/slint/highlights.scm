(identifier) @variable

(type_identifier) @type

(comment) @comment @spell

(int_literal) @number

(float_literal) @number.float

(string_literal) @string

(function_identifier) @function

[
  (image_macro)
  (children_macro)
  (radial_grad_macro)
  (linear_grad_macro)
] @function.macro

(call_expression
  function: (identifier) @function.call)

(call_expression
  function:
    (field_expression
      field: (identifier) @function.call))

(vis) @keyword.import

(units) @type

(array_literal
  (identifier) @type)

(transition_statement
  state: (identifier) @variable.member)

(state_expression
  state: (identifier) @variable.member)

(struct_block_definition
  (identifier) @variable.member)

; (state_identifier) @variable.member
[
  "in"
  "for"
] @keyword.repeat

"@" @keyword

[
  "import"
  "from"
] @keyword.import

[
  "if"
  "else"
] @keyword.conditional

[
  "root"
  "parent"
  "duration"
  "easing"
] @variable.builtin

[
  "true"
  "false"
] @boolean

[
  "struct"
  "property"
  "callback"
  "in"
  "animate"
  "states"
  "when"
  "out"
  "transitions"
  "global"
] @keyword

[
  "black"
  "transparent"
  "blue"
  "ease"
  "ease_in"
  "ease-in"
  "ease_in_out"
  "ease-in-out"
  "ease_out"
  "ease-out"
  "end"
  "green"
  "red"
  "red"
  "start"
  "yellow"
  "white"
  "gray"
] @constant.builtin

; Punctuation
[
  ","
  "."
  ";"
  ":"
] @punctuation.delimiter

; Brackets
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(define_property
  [
    "<"
    ">"
  ] @punctuation.bracket)

[
  "angle"
  "bool"
  "brush"
  "color"
  "float"
  "image"
  "int"
  "length"
  "percent"
  "physical-length"
  "physical_length"
  "string"
] @type.builtin

[
  ":="
  "<=>"
  "!"
  "-"
  "+"
  "*"
  "/"
  "&&"
  "||"
  ">"
  "<"
  ">="
  "<="
  "="
  ":"
  "+="
  "-="
  "*="
  "/="
  "?"
  "=>"
] @operator

(ternary_expression
  [
    ":"
    "?"
  ] @keyword.conditional.ternary)
