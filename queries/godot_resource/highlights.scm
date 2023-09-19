(identifier) @type.builtin

(attribute (identifier) @property)
(property (path) @property)
(constructor (identifier) @constructor)

(string) @string
(integer) @number
(float) @float

(true) @constant.builtin
(false) @constant.builtin

[
  "["
  "]"
] @tag.delimiter

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

"=" @operator

(ERROR _ @error) ; up the specificity to nodes under error, instead of parent node
