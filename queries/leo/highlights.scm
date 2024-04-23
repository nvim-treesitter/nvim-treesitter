(variable_identifier) @variable

(constant_identifier) @constant

[
  "assert"
  "assert_eq"
  "assert_neq"
  "block"
  "console"
  "const"
  "let"
  "mapping"
  "program"
  "self"
  "then"
] @keyword

[
  "record"
  "struct"
] @keyword.type

"in" @keyword.operator

[
  "constant"
  "private"
  "public"
] @keyword.modifier

"self" @variable.builtin

[
  "finalize"
  "function"
  "inline"
  "transition"
] @keyword.function

"import" @keyword.import

"return" @keyword.return

(return_arrow) @punctuation.delimiter

"for" @keyword.repeat

[
  "else"
  "if"
] @keyword.conditional

[
  (ternary_if)
  (ternary_else)
] @keyword.conditional.ternary

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ";"
  ","
  "::"
] @punctuation.delimiter

[
  "!"
  "&&"
  "||"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "&"
  "|"
  "^"
  "<<"
  ">>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  "="
  "+="
  "-="
  "*="
  "/="
  "%="
  "**="
  "<<="
  ">>="
  "&="
  "|="
  "^="
  "&&="
  "||="
] @operator

(comment) @comment @spell

(boolean_literal) @boolean

(constant_declaration
  (identifier) @constant)

[
  (program_id)
  (this_program_id)
] @string.special

;record declaration
(record_declaration
  (identifier) @variable.member)

;struct component
(struct_component_declaration
  (identifier) @variable.member)

(type) @type

(associated_constant) @constant

[
  (block_height)
  (self_caller)
  (self_signer)
] @constant.builtin

(free_function_call
  (locator
    (identifier) @function))

(record_type
  (locator
    (identifier) @variable.member))

(transition_declaration
  name: (identifier) @function.builtin)

(finalizer
  name: (identifier) @function.builtin)

(free_function_call
  (identifier) @function.call)

(function_declaration
  name: (identifier) @function)

(inline_declaration
  name: (identifier) @function.macro)

(method_call
  .
  (_)
  .
  (identifier) @function.method.call)

(function_parameter
  (identifier) @variable.parameter)

(struct_declaration
  name: (identifier) @variable.member)

(variable_declaration
  (identifier_or_identifiers
    (identifier) @variable))

[
  (address_literal)
  (signature_literal)
  ((affine_group_literal)
    (#set! "priority" 101))
  (field_literal)
  (product_group_literal)
  (scalar_literal)
  (signed_literal)
  (unsigned_literal)
] @number

(annotation) @attribute
