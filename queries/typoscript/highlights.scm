(identifier) @field

(constant) @constant

(modifier_function) @function
(modifier_predefined) @function.builtin

[
  (condition) 
  (condition_end) 
  (condition_else)
] @conditional

(cobject) @type.builtin

[
  "@import"
  "INCLUDE_TYPOSCRIPT"
] @include

[
  (comment)
  (single_line_comment)
] @comment @spell

[
  (string)
  (multiline_value)
] @string

[
  "="
  ">"
  "<"
  ":="
  "=<"
  (condition_bool)
] @operator

"," @punctuation.delimiter

[
 "("
 ")"
 (block_punctuation)
 ] @punctuation.bracket
