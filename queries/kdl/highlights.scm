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

((number) @number
 (#is-not? float))

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
