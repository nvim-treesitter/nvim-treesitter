; Function calls
(call
  function: (identifier) @function)

; Function definitions
(function_item
  name: (identifier) @function)

(predicate
  name: (identifier) @function)

; Types
(primitive_type) @type.builtin

[
  "array"
  "of"
  "par"
  "set"
  "var"
] @type.builtin

; Identifiers
(identifier) @variable

; Keywords
[
  "annotation"
  "constraint"
  "else"
  "elseif"
  "endif"
  "enum"
  "function"
  "if"
  "include"
  "let"
  "maximize"
  "minimize"
  "output"
  "predicate"
  "satisfy"
  "solve"
  "test"
  "then"
  "where"
] @keyword

; Operators
[
  "<->"
  "->"
  "<-"
  "\\/"
  "xor"
  "/\\"
  "="
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "in"
  "subset"
  "superset"
  "union"
  "diff"
  "symdiff"
  "intersect"
  ".."
  "+"
  "-"
  "++"
  "*"
  "/"
  "div"
  "mod"
  "^"
  "::"
] @operator

; Punctuation
[
  ","
  ":"
  ";"
  "|"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; Literals
[
  (integer_literal)
  (float_literal)
] @number

[
  (string_literal)
  (string_interpolation)
] @string

[
  (escape_sequence)
  (escape_interpolation)
] @string.escape

[
  (absent)
  (boolean_literal)
] @constant.builtin

; Comments
[
  (block_comment)
  (line_comment)
] @comment
