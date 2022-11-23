; basic keywords
[
  ("assert")
  ("with")
  ("let")
  ("in")
  ("rec")
  ("inherit")
] @keyword

; if/then/else
[
  ("if")
  ("then")
  ("else")
] @conditional

; field access default (`a.b or c`)
("or") @keyword.operator

; comments
(comment) @comment

; strings
[ (string_expression) (indented_string_expression) ] @string

; paths and URLs
[ (path_expression) (spath_expression) (uri_expression) ] @string.special

; escape sequences
(escape_sequence) @string.escape

; delimiters
[
  "."
  ";"
  ","
] @punctuation.delimiter

; brackets
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

; `?` in `{ x ? y }:`, used to set defaults for named function arguments
; I'm not really sure what group this should go in, but it should probably have highlighting, so I'm putting it in @punctuation.special
(formal
  name: (identifier) @parameter
  "?"? @punctuation.special)

; `...` in `{ ... }`, used to ignore unknown named function arguments (see above)
(ellipses) @punctuation.special

; universal is the parameter of the function expression
; `:` in `x: y`, used to separate function argument from body (see above)
(function_expression
  universal: (identifier) @parameter
  ":" @punctuation.special)

; basic identifiers
(variable_expression) @variable

; builtin functions
((identifier) @_i (#match? @_i "^(builtins|baseNameOf|dirOf|fetchTarball|map|removeAttrs|toString)$")) @variable.builtin

; display entire builtins path as builtin (ex. `builtins.filter` is highlighted as one long builtin)
(select_expression
  expression: ((variable_expression) @_i (#eq? @_i "builtins"))
  attrpath: (attrpath attr: (identifier) @variable.builtin)) @variable.builtin

; import
((identifier) @_i (#eq? @_i "import")) @include

; null
((identifier) @_i (#eq? @_i "import")) @constant.builtin

; these are technically functions but they act more like keywords (abort and throw are control flow, derivation is a core language construct)
((identifier) @_i (#match? @_i "^(abort|derivation|throw)$")) @keyword

; booleans
((identifier) @_i (#match? @_i "^(true|false)$")) @boolean

; string interpolation (this was very annoying to get working properly)
(interpolation "${" @punctuation.special (_) "}" @punctuation.special) @none

; fields (the `.` in `a.b = c;` isn't included)
(attrset_expression (binding_set (binding . (attrpath (identifier) @field))))
(rec_attrset_expression (binding_set (binding . (attrpath (identifier) @field))))

; unary operators
(unary_expression operator: _ @operator)

; binary operators
(binary_expression operator: _ @operator)

; integers, also highlight a unary -
[
  (unary_expression "-" (integer_expression))
  (integer_expression)
] @number

; floats, also highlight a unary -
[
  (unary_expression "-" (float_expression))
  (float_expression)
] @float
