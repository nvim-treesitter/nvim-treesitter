(identifier) @variable

(reference_identifier) @variable

(member_identifier) @variable.member

; Classes
(custom_type) @type

(class_field
  name: (identifier) @property)

(struct_field
  name: (identifier) @property)

(class_definition
  name: (identifier) @type)

(struct_definition
  name: (identifier) @type)

(interface_definition
  name: (identifier) @type)

(method_definition
  name: (identifier) @function.method)

(json_literal_member
  (identifier) @property)

; Functions
(keyword_argument_key) @variable.parameter

(parameter_definition
  name: (identifier) @variable.parameter)

(variadic) @variable.parameter.builtin

(call
  caller: (reference
    (nested_identifier
      property: (member_identifier) @function.method.call)))

(call
  caller: (reference
    (reference_identifier) @function.method.call))

; Primitives
(number) @number

(duration) @constant

(string) @string

(bool) @boolean

[
  (builtin_type)
  "MutSet"
  "MutMap"
  "MutArray"
  "Json"
  "Set"
  "Map"
  "Array"
  "MutJson"
] @type.builtin

(json_container_type) @type.builtin

; Special
(comment) @comment @spell

[
  "-"
  "-="
  "+"
  "+="
  "*"
  "**"
  "/"
  "%"
  "<"
  "<="
  "="
  "=="
  "!"
  "!="
  ">"
  ">="
  "&&"
  "??"
  "||"
  "?"
] @operator

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

(mutable_container_type
  [
    "<"
    ">"
  ] @punctuation.bracket)

(immutable_container_type
  [
    "<"
    ">"
  ] @punctuation.bracket)

[
  ";"
  "."
  ","
  ":"
  "=>"
] @punctuation.delimiter

[
  "as"
  "let"
  "new"
  (phase_specifier)
  "impl"
  "test"
] @keyword

"bring" @keyword.import

[
  "class"
  "struct"
  "interface"
] @keyword.type

[
  "for"
  "in"
] @keyword.repeat

[
  "if"
  "else"
] @keyword.conditional

[
  "pub"
  "protected"
  "internal"
  "extern"
  (static)
] @keyword.modifier

"return" @keyword.return

(import_statement
  module_name: (identifier) @module)

(import_statement
  alias: (identifier) @module)

(call
  (reference
    (nested_identifier
      object: (reference) @_ref
      property: (member_identifier) @_ident))
  (argument_list
    (positional_argument
      (string) @string.regexp))
  (#eq? @_ref "regex")
  (#eq? @_ident "compile")
  (#offset! @string.regexp 0 1 0 -1))
