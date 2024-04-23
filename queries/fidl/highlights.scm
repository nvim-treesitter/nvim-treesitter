[
  "ajar"
  "alias"
  "as"
  "bits"
  "closed"
  "compose"
  "const"
  "error"
  "flexible"
  "library"
  "open"
  ; "optional" we did not specify a node for optional yet
  "overlay"
  "protocol"
  "reserved"
  "strict"
  "using"
] @keyword

[
  "enum"
  "struct"
  "table"
  "union"
  "resource"
  "service"
  "type"
] @keyword.type

(primitives_type) @type.builtin

(builtin_complex_type) @type.builtin

(const_declaration
  (identifier) @constant)

[
  "="
  "|"
  "&"
  "->"
] @operator

(attribute
  "@" @attribute
  (identifier) @attribute)

(string_literal) @string

(numeric_literal) @number

[
  (true)
  (false)
] @boolean

(comment) @comment

[
  "("
  ")"
  "<"
  ">"
  "{"
  "}"
] @punctuation.bracket
