[
  (comment)
  (preprocessor_comment)
] @comment @spell

"#include" @keyword.import

[
  "#define"
  "#undef"
] @keyword.directive.define

[
  "#if"
  "#ifdef"
  "#ifndef"
  "#elif"
  "#elifdef"
  "#elifndef"
  "#else"
  "#endif"
  (directive)
] @keyword.directive

(identifier) @variable

(define_directive
  name: (identifier) @constant)

(define_function_directive
  name: (identifier) @function.macro)

(parameters
  (identifier) @variable.parameter)

"..." @variable.parameter.builtin

(undef_directive
  name: (identifier) @constant)

(ifdef_directive
  condition: (identifier) @constant)

(elifdef_directive
  condition: (identifier) @constant)

(expansion) @markup.raw

(component) @variable.member

(components
  (component) @property .)

[
  (string)
  (resource_value)
] @string

(escape_sequence) @string.escape

[
  "*"
  (any_component)
] @character.special

[
  "."
  ","
  ":"
] @punctuation.delimiter

[
  "("
  ")"
] @punctuation.bracket
