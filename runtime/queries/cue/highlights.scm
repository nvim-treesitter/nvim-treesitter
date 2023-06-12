; Includes
[
  "package"
  "import"
] @keyword.import

; Namespaces
(package_identifier) @module

(import_spec
  [
    "."
    "_"
  ] @punctuation.special)

[
  (attr_path)
  (package_path)
] @string.special.url ; In attributes

; Attributes
(attribute) @attribute

; Conditionals
"if" @keyword.conditional

; Repeats
"for" @keyword.repeat

(for_clause
  "_" @punctuation.special)

; Keywords
"let" @keyword

"in" @keyword.operator

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "|"
  "&"
  "||"
  "&&"
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "=~"
  "!~"
  "!"
  "="
] @operator

; Fields & Properties
(field
  (label
    (identifier) @variable.member))

(selector_expression
  (_)
  (identifier) @property)

; Functions
(call_expression
  function: (identifier) @function.call)

(call_expression
  function:
    (selector_expression
      (_)
      (identifier) @function.call))

(call_expression
  function: (builtin_function) @function.call)

(builtin_function) @function.builtin

; Variables
(identifier) @variable

; Types
(primitive_type) @type.builtin

((identifier) @type
  (#lua-match? @type "^_?#"))

[
  (slice_type)
  (pointer_type)
] @type ; In attributes

; Punctuation
[
  ","
  ":"
] @punctuation.delimiter

[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  "<"
  ">"
] @punctuation.bracket

[
  (ellipsis)
  "?"
] @punctuation.special

; Literals
(string) @string

[
  (escape_char)
  (escape_unicode)
] @string.escape

(number) @number

(float) @number.float

(si_unit
  (float)
  (_) @string.special.symbol)

(boolean) @boolean

[
  (null)
  (top)
  (bottom)
] @constant.builtin

; Interpolations
(interpolation
  "\\(" @punctuation.special
  (_)
  ")" @punctuation.special) @none

(interpolation
  "\\("
  (identifier) @variable
  ")")

; Comments
(comment) @comment @spell
