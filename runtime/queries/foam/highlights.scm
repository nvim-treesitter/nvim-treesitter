; Comments
(comment) @comment @spell

; Generic Key-value pairs and dictionary keywords
(key_value
  keyword: (identifier) @function)

(dict
  key: (identifier) @type)

; Macros
(macro
  "$" @keyword.conditional
  (prev_scope)* @keyword.conditional
  (identifier)* @module)

; Directives
"#" @keyword.conditional

(preproc_call
  directive: (identifier)* @keyword.conditional
  argument: (identifier)* @module)

((preproc_call
  argument: (identifier)* @module) @keyword.conditional
  (#eq? @keyword.conditional "ifeq"))

((preproc_call) @keyword.conditional
  (#any-of? @keyword.conditional "else" "endif"))

; Literals
(number_literal) @number.float

(string_literal) @string

(escape_sequence) @string.escape

(boolean) @boolean

; Treat [m^2 s^-2] the same as if it was put in numbers format
(dimensions
  dimension: (identifier) @number.float)

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "#{"
  "#}"
  "|-"
  "-|"
  "<!--("
  ")-->"
  "$$"
] @punctuation.bracket

";" @punctuation.delimiter

((identifier) @constant.builtin
  (#any-of? @constant.builtin "uniform" "non-uniform" "and" "or"))
