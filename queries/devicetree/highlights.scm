(comment) @comment

[
  (preproc_include)
  (dtsi_include)
] @include

[
  (preproc_def)
] @constant.macro

[
  (preproc_function_def)
] @function.macro

[
  (memory_reservation)
  (file_version)
] @annotation

[
  (string_literal)
  (byte_string_literal)
  (system_lib_string)
] @string

(integer_literal) @number

(identifier) @variable
(node (identifier) @attribute)
(property (identifier) @property)
(labeled_item (identifier) @label)
(call_expression (identifier) @function.macro)

(reference) @attribute
(unit_address) @constant

[ "=" ] @operator
[ "(" ")" "[" "]" "{" "}" "<" ">" ] @punctuation.bracket
[ ";" ":" "," "@" ] @punctuation.delimiter
