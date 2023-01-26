; Types

(node (identifier) @type)

(type) @type

(annotation_type) @type.builtin

; Properties

(prop (identifier) @property)

; Variables

(identifier) @variable

; Operators
[
 "="
 "+"
 "-"
] @operator

; Literals

(string) @string

(escape) @string.escape

(number) @number

(number (decimal) @float)
(number (exponent) @float)
(number (decimal) (exponent) @float)

(boolean) @boolean

; Misc

"null" @constant.builtin

["{" "}"] @punctuation.bracket

["(" ")"] @punctuation.bracket

; Comments

[
  (single_line_comment)
  (multi_line_comment)
] @comment

(node (node_slash_dash)) @comment
(node (node_prop_or_arg_slash_dash) @comment (prop) @comment)
(node (node_prop_or_arg_slash_dash) @comment (value) @comment)
(node_children (node_children_slash_dash)) @comment
