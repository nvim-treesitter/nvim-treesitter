[
  "enum"
  "extend"
  "extensions"
  "message"
  "oneof"
  "option"
  "optional"
  "repeated"
  "reserved"
  "returns"
  "required"
  "rpc"
  "service"
  "syntax"
  "to"
] @keyword

[
  "package"
  "import"
] @include

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

[
  (string)
  "\"proto3\""
] @string

(int_lit) @number

(float_lit) @float

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
