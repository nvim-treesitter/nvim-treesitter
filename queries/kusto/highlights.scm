(identifier) @variable

(let_keyword) @keyword

(function_call
  (identifier) @function.call)
[
  (type_cast_function)
  (to_scalar_function)
  (between_function)
  (datatable_function)
] @function.call

(typed_parameter
  (identifier) @parameter)
(function_arguments (identifier) @parameter)

[
  (binary_operator)
  (compound_keywords)
  (operator)
  (range_operator)
  (join_operator)
  (sub_operator)
  (to_operator)
  (mv_apply_operator)
  (sort_keyword)
] @keyword.operator

(string) @string
(number) @number
(bool) @boolean
(null) @constant.builtin
(comment) @comment @spell

(type) @type
(join_types) @type.qualifier

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ":"
  (pipe)
] @punctuation.delimiter
