[
  "ajar"
  "alias"
  "as"
  "bits"
  "closed"
  "compose"
  "const"
  "enum"
  "error"
  "flexible"
  "library"
  "open"
  ; "optional" we did not specify a node for optional yet
  "overlay"
  "protocol"
  "reserved"
  "resource"
  "service"
  "strict"
  "struct"
  "table"
  "type"
  "union"
  "using"
] @keyword

(primitives_type) @type

(builtin_complex_type) @type

(const_declaration
  (identifier) @constant)

[
  "="
  "|"
  "&"
  "->"
] @operator

(attribute
  (identifier) @attribute)

(attribute
  "@" @attribute)

(string_literal) @string

(numeric_literal) @number

[
  (true)
  (false)
] @constant.builtin

(comment) @comment

[
  "("
  ")"
  "<"
  ">"
  "{"
  "}"
] @punctuation.bracket
