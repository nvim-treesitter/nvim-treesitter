(package
  (full_ident
    (identifier) @module))

(extend
  (full_ident
    (identifier) @type))

(constant
  (full_ident
    (identifier) @constant))

(field
  (identifier) @property)

(map_field
  (identifier) @property)

(oneof
  (identifier) @type)

(oneof_field
  (identifier) @property)

(field_option
  (identifier) @property)

(enum_value_option
  (identifier) @property)

(block_lit
  (identifier) @property)

; Extension option names, e.g. option (foo.bar) = ...
(option
  (full_ident
    (identifier) @variable))

(option
  (full_ident
    (identifier)
    (identifier) @variable.member))

[
  "option"
  "syntax"
  "edition"
] @keyword.directive

[
  "reserved"
  "to"
  "max"
] @keyword

[
  "enum"
  "extend"
  "extensions"
  "group"
  "message"
  "map"
  "oneof"
  "service"
] @keyword.type

"rpc" @keyword.function

"returns" @keyword.return

[
  "export"
  "local"
  "optional"
  "repeated"
  "required"
  "stream"
  "weak"
  "public"
] @keyword.modifier

[
  "package"
  "import"
] @keyword.import

[
  (key_type)
  (type)
] @type.builtin

[
  (message_name)
  (enum_name)
  (service_name)
  (message_or_enum_type)
] @type

(rpc_name) @function.method

(enum_field
  (identifier) @constant)

(string) @string

(import
  path: (string) @string.special.path)

[
  "\"proto3\""
  "\"proto2\""
] @string.special.symbol

(escape_sequence) @string.escape

(int_lit) @number

(float_lit) @number.float

[
  (true)
  (false)
] @boolean

(comment) @spell

(comment) @comment

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "<"
  ">"
] @punctuation.bracket

[
  ";"
  ","
  "."
  ":"
] @punctuation.delimiter

[
  "="
  "-"
  "+"
] @operator
