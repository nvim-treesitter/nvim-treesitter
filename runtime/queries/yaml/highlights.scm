(boolean_scalar) @boolean

(null_scalar) @constant.builtin

(double_quote_scalar) @string

(single_quote_scalar) @string

((block_scalar) @string
  (#set! "priority" 99))

(string_scalar) @string

(escape_sequence) @string.escape

(integer_scalar) @number

(float_scalar) @number

(comment) @comment @spell

(anchor_name) @type

(alias_name) @type

(tag) @type

[
  (yaml_directive)
  (tag_directive)
  (reserved_directive)
] @keyword.directive

(block_mapping_pair
  key:
    (flow_node
      [
        (double_quote_scalar)
        (single_quote_scalar)
      ] @variable.member))

(block_mapping_pair
  key:
    (flow_node
      (plain_scalar
        (string_scalar) @variable.member)))

(flow_mapping
  (_
    key:
      (flow_node
        [
          (double_quote_scalar)
          (single_quote_scalar)
        ] @variable.member)))

(flow_mapping
  (_
    key:
      (flow_node
        (plain_scalar
          (string_scalar) @variable.member))))

[
  ","
  "-"
  ":"
  ">"
  "?"
  "|"
] @punctuation.delimiter

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "*"
  "&"
  "---"
  "..."
] @punctuation.special
