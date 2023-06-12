(type_identifier) @type

(identifier) @variable

(field_identifier) @variable.member

(escape_sequence) @string.escape

(primitive_type) @type.builtin

(boolean_literal) @boolean

(integer_literal) @number

(float_literal) @number.float

(char_literal) @character

; -------
; Paths
; -------
(use_declaration
  argument: (identifier) @module)

(use_wildcard
  (identifier) @module)

(mod_item
  name: (identifier) @module)

(scoped_use_list
  path: (identifier)? @module)

(use_list
  (identifier) @module)

(use_as_clause
  path: (identifier)? @module
  alias: (identifier) @module)

; ---
; Remaining Paths
; ---
(scoped_identifier
  path: (identifier)? @module
  name: (identifier) @module)

(scoped_type_identifier
  path: (identifier) @module)

[
  "*"
  "'"
  "->"
  "=>"
  "<="
  "="
  "=="
  "!"
  "!="
  "%"
  "%="
  "&"
  "&="
  "&&"
  "|"
  "|="
  "||"
  "^"
  "^="
  "*"
  "*="
  "-"
  "-="
  "+"
  "+="
  "/"
  "/="
  ">"
  "<"
  ">="
  ">>"
  "<<"
  ">>="
  "<<="
  "@"
  ".."
  "..="
  "'"
  "?"
] @operator

(use_wildcard
  "*" @character.special)

[
  (string_literal)
  (raw_string_literal)
] @string

[
  (line_comment)
  (block_comment)
] @comment

; ---
; Extraneous
; ---
(self) @variable.builtin

(enum_variant
  (identifier) @constant)

(field_initializer
  (field_identifier) @variable.member)

(shorthand_field_initializer
  (identifier) @variable.member)

(shorthand_field_identifier) @variable.member

(loop_label
  "'" @label
  (identifier) @label)

; ---
; Punctuation
; ---
[
  "::"
  ":"
  "."
  ";"
  ","
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "#"
] @punctuation.bracket

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket)

(type_parameters
  [
    "<"
    ">"
  ] @punctuation.bracket)

(closure_parameters
  "|" @punctuation.bracket)

(let_declaration
  pattern: [
    (identifier) @variable
    (tuple_pattern
      (identifier) @variable)
  ])

; It needs to be anonymous to not conflict with `call_expression` further below.
(_
  value: (field_expression
    value: (identifier)? @variable
    field: (field_identifier) @variable.member))

(parameter
  pattern: (identifier) @variable.parameter)

(parameter
  pattern: (ref_pattern
    [
      (mut_pattern
        (identifier) @variable.parameter)
      (identifier) @variable.parameter
    ]))

(closure_parameters
  (identifier) @variable.parameter)

(for_expression
  "for" @keyword.repeat)

"in" @keyword.repeat

[
  "match"
  "if"
  "else"
] @keyword.conditional

"while" @keyword.repeat

[
  "break"
  "continue"
  "return"
  "yield"
] @keyword.return

"use" @keyword.import

(mod_item
  "mod" @keyword.import
  !body)

(use_as_clause
  "as" @keyword.import)

(type_cast_expression
  "as" @keyword.operator)

[
  "as"
  "mod"
  "abi"
  "impl"
  "where"
  "trait"
  "for"
  "let"
  "contract"
  "script"
  "predicate"
  "library"
] @keyword

[
  "struct"
  "enum"
  "storage"
  "configurable"
  "type"
] @keyword.type

[
  "fn"
  "abi"
] @keyword.function

[
  (mutable_specifier)
  "const"
  "ref"
  "deref"
  "move"
  "pub"
] @keyword.modifier

(reference_type
  "&" @keyword.modifier)

(self_parameter
  "&" @keyword.modifier)

; -------
; Guess Other Types
; -------
((identifier) @constant
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

; ---
; PascalCase identifiers in call_expressions (e.g. `Ok()`)
; are assumed to be enum constructors.
; ---
(call_expression
  function: [
    ((identifier) @constant
      (#lua-match? @constant "^[A-Z]"))
    (scoped_identifier
      name: ((identifier) @constant
        (#lua-match? @constant "^[A-Z]")))
  ])

; ---
; Assume that types in match arms are enums and not
; tuple structs. Same for `if let` expressions.
; ---
(match_pattern
  (scoped_identifier
    name: (identifier) @constructor))

(tuple_struct_pattern
  type: [
    (identifier) @constructor
    (scoped_identifier
      name: (identifier) @constructor)
  ])

(struct_pattern
  type: [
    (type_identifier) @constructor
    (scoped_type_identifier
      name: (type_identifier) @constructor)
  ])

; ---
; Other PascalCase identifiers are assumed to be structs.
; ---
((identifier) @type
  (#lua-match? @type "^[A-Z]"))

; -------
; Functions
; -------
(call_expression
  function: [
    (identifier) @function.call
    (scoped_identifier
      name: (identifier) @function.call)
    (field_expression
      field: (field_identifier) @function.method.call)
  ])

(generic_function
  function: [
    (identifier) @function.call
    (scoped_identifier
      name: (identifier) @function.call)
    (field_expression
      field: (field_identifier) @function.method.call)
  ])

(function_item
  name: (identifier) @function)

(function_signature_item
  name: (identifier) @function)
