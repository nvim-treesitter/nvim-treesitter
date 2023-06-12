; Preproc
[
  "%builtins"
  "%lang"
] @keyword.directive

; Includes
(import_statement
  [
    "from"
    "import"
  ] @keyword.import
  module_name: (dotted_name
    (identifier) @module .))

[
  "as"
  "use"
  "mod"
] @keyword.import

; Variables
(identifier) @variable

; Namespaces
(namespace_definition
  (identifier) @module)

(mod_item
  name: (identifier) @module)

(use_list
  (self) @module)

(scoped_use_list
  (self) @module)

(scoped_identifier
  path: (identifier) @module)

(scoped_identifier
  (scoped_identifier
    name: (identifier) @module))

(scoped_type_identifier
  path: (identifier) @module)

((scoped_identifier
  path: (identifier) @type)
  (#lua-match? @type "^[A-Z]"))

((scoped_identifier
  name: (identifier) @type)
  (#lua-match? @type "^[A-Z]"))

((scoped_identifier
  name: (identifier) @constant)
  (#lua-match? @constant "^[A-Z][A-Z%d_]*$"))

((scoped_identifier
  path: (identifier) @type
  name: (identifier) @constant)
  (#lua-match? @type "^[A-Z]")
  (#lua-match? @constant "^[A-Z]"))

((scoped_type_identifier
  path: (identifier) @type
  name: (type_identifier) @constant)
  (#lua-match? @type "^[A-Z]")
  (#lua-match? @constant "^[A-Z]"))

(scoped_use_list
  path: (identifier) @module)

(scoped_use_list
  path: (scoped_identifier
    (identifier) @module))

(use_list
  (scoped_identifier
    (identifier) @module
    .
    (_)))

(use_list
  (identifier) @type
  (#lua-match? @type "^[A-Z]"))

(use_as_clause
  alias: (identifier) @type
  (#lua-match? @type "^[A-Z]"))

; Keywords
[
  ; 0.x
  "using"
  "let"
  "const"
  "local"
  "rel"
  "abs"
  "dw"
  "alloc_locals"
  (inst_ret)
  "with_attr"
  "with"
  "call"
  "nondet"
  ; 1.0
  "impl"
  "implicits"
  "of"
  "ref"
  "mut"
] @keyword

[
  "struct"
  "enum"
  "namespace"
  "type"
  "trait"
] @keyword.type

[
  "func"
  "fn"
  "end"
] @keyword.function

"return" @keyword.return

[
  "cast"
  "new"
  "and"
] @keyword.operator

[
  "tempvar"
  "extern"
] @keyword.modifier

[
  "if"
  "else"
  "match"
] @keyword.conditional

"loop" @keyword.repeat

[
  "assert"
  "static_assert"
  "nopanic"
] @keyword.exception

; Fields
(implicit_arguments
  (typed_identifier
    (identifier) @variable.member))

(member_expression
  "."
  (identifier) @variable.member)

(call_expression
  (assignment_expression
    left: (identifier) @variable.member))

(tuple_expression
  (assignment_expression
    left: (identifier) @variable.member))

(field_identifier) @variable.member

(shorthand_field_initializer
  (identifier) @variable.member)

; Parameters
(arguments
  (typed_identifier
    (identifier) @variable.parameter))

(call_expression
  (tuple_expression
    (assignment_expression
      left: (identifier) @variable.parameter)))

(return_type
  (tuple_type
    (named_type
      .
      (identifier) @variable.parameter)))

(parameter
  (identifier) @variable.parameter)

; Builtins
(builtin_directive
  (identifier) @variable.builtin)

(lang_directive
  (identifier) @variable.builtin)

[
  "ap"
  "fp"
  (self)
] @variable.builtin

; Functions
(function_definition
  "func"
  (identifier) @function)

(function_definition
  "fn"
  (identifier) @function)

(function_signature
  "fn"
  (identifier) @function)

(extern_function_statement
  (identifier) @function)

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (scoped_identifier
    (identifier) @function.call .))

(call_expression
  function: (field_expression
    field: (field_identifier) @function.call))

"jmp" @function.builtin

; Types
(struct_definition
  .
  (identifier) @type
  (typed_identifier
    (identifier) @variable.member)?)

(named_type
  (identifier) @type .)

[
  (builtin_type)
  (primitive_type)
] @type.builtin

((identifier) @type
  (#lua-match? @type "^[A-Z][a-zA-Z0-9_]*$"))

(type_identifier) @type

; Constants
((identifier) @constant
  (#lua-match? @constant "^[A-Z_][A-Z0-9_]*$"))

(enum_variant
  name: (identifier) @constant)

(call_expression
  function: (scoped_identifier
    "::"
    name: (identifier) @constant)
  (#lua-match? @constant "^[A-Z]"))

((match_arm
  pattern: (match_pattern
    (identifier) @constant))
  (#lua-match? @constant "^[A-Z]"))

((match_arm
  pattern: (match_pattern
    (scoped_identifier
      name: (identifier) @constant)))
  (#lua-match? @constant "^[A-Z]"))

((identifier) @constant.builtin
  (#any-of? @constant.builtin "Some" "None" "Ok" "Err"))

; Constructors
(unary_expression
  "new"
  (call_expression
    .
    (identifier) @constructor))

((call_expression
  .
  (identifier) @constructor)
  (#lua-match? @constructor "^%u"))

; Attributes
(decorator
  "@" @attribute
  (identifier) @attribute)

(attribute_item
  (identifier) @function.macro)

(attribute_item
  (scoped_identifier
    (identifier) @function.macro .))

; Labels
(label
  .
  (identifier) @label)

(inst_jmp_to_label
  "jmp"
  .
  (identifier) @label)

(inst_jnz_to_label
  "jmp"
  .
  (identifier) @label)

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "**"
  "=="
  "!="
  "&"
  "="
  "++"
  "+="
  "@"
  "!"
  "~"
  ".."
  "&&"
  "||"
  "^"
  "<"
  "<="
  ">"
  ">="
  "<<"
  ">>"
  "%"
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "^="
  "<<="
  ">>="
  "?"
] @operator

; Literals
(number) @number

(boolean) @boolean

[
  (string)
  (short_string)
] @string

; Punctuation
(attribute_item
  "#" @punctuation.special)

[
  "."
  ","
  ":"
  ";"
  "->"
  "=>"
  "::"
] @punctuation.delimiter

[
  "{"
  "}"
  "("
  ")"
  "["
  "]"
  "%{"
  "%}"
] @punctuation.bracket

(type_parameters
  [
    "<"
    ">"
  ] @punctuation.bracket)

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket)

; Comment
(comment) @comment @spell
