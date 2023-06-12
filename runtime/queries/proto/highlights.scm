[
  "enum"
  "extend"
  "extensions"
  "message"
  "oneof"
  "option"
  "reserved"
  "service"
  "syntax"
  "to"
] @keyword

"rpc" @keyword.function

"returns" @keyword.return

[
  "optional"
  "repeated"
  "required"
] @keyword.modifier

[
  "package"
  "import"
] @keyword.import

[
  (key_type)
  (type)
  (message_name)
  (enum_name)
  (service_name)
  (rpc_name)
  (message_or_enum_type)
] @type

(enum_field
  (identifier) @constant)

(string) @string

[
  "\"proto3\""
  "\"proto2\""
] @string.special

(int_lit) @number

(float_lit) @number.float

[
  (true)
  (false)
] @boolean

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

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
] @punctuation.delimiter

"=" @operator
