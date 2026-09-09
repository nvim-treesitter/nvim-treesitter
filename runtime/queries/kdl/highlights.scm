; Variables
(identifier) @variable

; Nodes
(node
  name: (identifier) @tag)

(node
  name: (identifier
    (string) @tag))

; Types
(type) @type

(type
  name: (identifier) @type)

; Reserved type annotations are advisory in the spec, not syntax.
((type
  name: (identifier) @type.builtin)
  (#any-of? @type.builtin
    "i8" "i16" "i32" "i64" "i128" "u8" "u16" "u32" "u64" "u128" "isize" "usize" "f32" "f64"
    "decimal64" "decimal128" "date-time" "time" "date" "duration" "decimal" "currency" "country-2"
    "country-3" "country-subdivision" "email" "idn-email" "hostname" "idn-hostname" "ipv4" "ipv6"
    "url" "url-reference" "irl" "irl-reference" "url-template" "uuid" "regex" "base64" "base85"))

; Properties
(prop
  key: (identifier) @property)

; Operators
"=" @operator

; Literals
(string) @string

(multi_line_string) @string

(string_fragment) @string

(escape) @string.escape

(escaped_whitespace) @string.escape

(number) @number

(keyword_number) @number

(number
  (decimal) @number.float)

(number
  (exponent) @number.float)

(boolean) @boolean

[
  "null"
  "#null"
] @constant.builtin

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

";" @punctuation.delimiter

; Comments
[
  (single_line_comment)
  (multi_line_comment)
  (version)
] @comment @spell

(node_comment) @comment

(node_field_comment) @comment

(node_children_comment) @comment
