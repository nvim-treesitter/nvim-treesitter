[
  "generator"
  "datasource"
  "model"
  "enum"
] @keyword

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ":"
  ","
] @punctuation.special

[
  "="
  "?"
] @operator

(comment) @comment
(string) @string
(integer) @number
(boolean) @constant.builtin
(prisma_type) @type.builtin

(field_type (non_null_type (identifier) @type))
(field_type (array_type (non_null_type (identifier) @type)))

(apply_function (identifier) @function)

(attribute_specifier (identifier) @attribute)

(key_value (key (identifier) @attribute))

(model_single_attribute (identifier) @variable.parameter)
(model_multi_attribute (identifier) @variable.parameter)

(model_field (identifier) @property)

((identifier) @constant
 (#vim-match? @constant "^[A-Z_][A-Z\\d_]+$"))
