(identifier) @variable.member

(symfony_variable) @variable

(constant) @constant

(symfony_function) @function.call

(symfony_method) @function.method.call

[
  (modifier_function)
  (symfony_function)
] @function

[
  (modifier_predefined)
  (symfony_predefined_function)
] @function.builtin

[
  (symfony_function_parameter)
  (symfony_method_parameter)
  (modifier_parameter)
] @variable.parameter

(symfony_function_parameter
  (symfony_variable) @variable.parameter)

(symfony_method_parameter
  (symfony_variable) @variable.parameter)

[
  (condition)
  (condition_end)
  (condition_else)
] @keyword.conditional

((condition
  "[" @keyword.conditional)
  (#set! "priority" 110))

((condition
  "]" @keyword.conditional)
  (#set! "priority" 110))

[
  "@import"
  "INCLUDE_TYPOSCRIPT"
] @keyword.import

(condition_attribute) @tag.attribute

(cobject) @type.builtin

(symfony_built_in_variable) @variable.builtin

(symfony_property) @variable.member

[
  (comment)
  (single_line_comment)
] @comment @spell

[
  (string)
  (multiline_value_content)
  (symfony_string)
] @string

(reference_line
  "=<" @operator)

(deletion_line
  ">" @operator)

(copy_line
  "<" @operator)

(modification_line
  ":=" @operator)

[
  "="
  "."
  "?."
  (symfony_condition_operator)
  (condition_bool_legacy)
  (constant_null_coalescing)
] @operator

(symfony_ternary_operator) @keyword.conditional.ternary

((symfony_condition_operator) @keyword.operator
  (#match? @keyword.operator "and|or|xor|not|not in|in|contains|starts with|ends with|matches"))

"," @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  (block_punctuation)
] @punctuation.bracket

(symfony_number) @number

(symfony_boolean) @boolean

(symfony_null) @constant.builtin
