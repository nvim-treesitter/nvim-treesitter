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

[
  "in"
  "as"
] @keyword.operator

[
  "constant"
  "private"
  "public"
] @keyword.modifier

"self" @variable.builtin

"network" @variable.builtin

"async" @keyword.coroutine

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
  (identifier
    (constant_identifier) @constant))

(variable
  (constant_identifier) @constant)

(associated_constant) @constant

(variable) @variable

(program_id) @string.special

;record declaration
(record_declaration
  (identifier) @type.definition)

;struct component
(struct_component_declaration
  (identifier) @variable.member)

(struct_expression
  (identifier) @type.definition)

(struct_component_initializer
  (identifier) @variable.member)

[
  (type)
  (boolean_type)
  (integer_type)
  (field_type)
  (group_type)
  (scalar_type)
  (address_type)
  (signature_type)
  (string_type)
] @type

[
  (block_height)
  (self_address)
  (self_caller)
  (self_signer)
  (network_id)
] @constant.builtin

(free_function_call
  (locator
    (identifier) @function))

(associated_function_call
  (named_type
    (identifier
      (constant_identifier) @function)))

(associated_function_call
  (identifier) @function.call)

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
  name: (identifier) @type.definition)

(variable_declaration
  (identifier) @variable)

[
  (address_literal)
  (signature_literal)
  ((affine_group_literal)
    (#set! priority 101))
  (field_literal)
  (product_group_literal)
  (scalar_literal)
  (signed_literal)
  (unsigned_literal)
] @number

(string_literal) @string

(annotation) @attribute
