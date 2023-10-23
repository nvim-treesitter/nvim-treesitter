(identifier) @field

(constant) @constant

(modifier_function) @function
(modifier_predefined) @function.builtin

[
  (condition) 
  (condition_end) 
  (condition_else)
] @conditional


[
  "@import"
  "INCLUDE_TYPOSCRIPT"
] @keyword

(cobject) @type.builtin

[
  "@import"
  "INCLUDE_TYPOSCRIPT"
] @include

[
  (comment)
  (single_line_comment)
] @comment

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

[
  ","
] @punctuation.delimiter

[
 "("
 ")"
 (block_punctuation)
 ] @punctuation.bracket
