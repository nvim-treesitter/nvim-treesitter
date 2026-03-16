(identifier) @variable.member

(symfony_variable) @variable

(constant) @constant

(symfony_method) @function.method.call

[
  (modifier_function)
  (symfony_function)
] @function.call

[
  (modifier_predefined)
  (symfony_predefined_function)
] @function.builtin

(modifier_parameter) @variable.parameter

(symfony_function_parameter
  (symfony_variable) @variable.parameter)

(symfony_method_parameter
  (symfony_variable) @variable.parameter)

[
  (condition)
  (condition_end)
  (condition_else)
] @keyword.conditional

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

(deletion_line
  ">" @operator)

(copy_line
  "<" @operator)

[
  "="
  "=<"
  ":="
  "?."
  (symfony_condition_operator)
  (condition_bool_legacy)
  (constant_null_coalescing)
] @operator

(symfony_ternary_operator) @keyword.conditional.ternary

((symfony_condition_operator) @keyword.operator
  (#any-of? @keyword.operator
    "and" "or" "xor" "not" "not in" "in" "contains" "starts with" "ends with" "matches"))

[
  ","
  "."
] @punctuation.delimiter

(symfony_property_access
  "." @operator)

(symfony_method_call
  "." @operator)

[
  "("
  ")"
  "["
  "]"
  (block_punctuation)
] @punctuation.bracket

(condition
  "[" @punctuation.special)

(condition
  "]" @punctuation.special)

(symfony_number) @number

(symfony_boolean) @boolean

(symfony_null) @constant.builtin
