(string) @string
(escape_sequence) @string.escape
(capture (identifier) @type)
(anonymous_node (identifier) @string)
(predicate name: (identifier) @function)
(named_node name: (identifier) @variable)
(field_definition name: (identifier) @property)
(comment) @comment

(quantifier) @operator
(predicate_type) @punctuation.special

"." @operator

[
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

":" @punctuation.delimiter
"@" @punctuation.special
"_" @constant

((program . (comment) @include)
 (#match? @include "^;\ +inherits\ *:"))
