(comment) @comment @spell

[
  (preproc_include)
  (dtsi_include)
] @keyword.import

(preproc_def) @constant.macro

(preproc_function_def) @function.macro

[
  (memory_reservation)
  (file_version)
] @attribute

[
  (string_literal)
  (byte_string_literal)
  (system_lib_string)
] @string

(integer_literal) @number

(identifier) @variable

(node
  (identifier) @module)

(property
  (identifier) @property)

(node
  label: (_) @label)

(call_expression
  (identifier) @function.macro)

(reference) @label ; referencing labeled_item.identifier

(unit_address) @constant

"=" @operator

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
  ":"
  ","
  "@"
] @punctuation.delimiter
