; highlights.scm

[
  "!"
  "\*"
  "/"
  "%"
  "\+"
  "-"
  ">"
  ">="
  "<"
  "<="
  "=="
  "!="
  "&&"
  "||"
] @operator

[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
] @punctuation.bracket

[
  "."
  ".*"
  ","
  "[*]"
] @punctuation.delimiter

[
  (ellipsis)
  "\?"
  "=>"
] @punctuation.special

[
  ":"
  "="
] @none

[
  "for"
  "in"
] @repeat

[ 
  "if"
] @conditional

[
  (quoted_template_start) ; "
  (quoted_template_end); "
  (template_literal) ; non-interpolation/directive content
] @string

[
  (heredoc_identifier) ; <<END
  (heredoc_start) ; END
] @punctuation.delimiter

( template_interpolation
  [
    (template_interpolation_start) ; ${
    (template_interpolation_end) ; }
  ] @punctuation.bracket
)

(numeric_lit) @number
(bool_lit) @boolean
(null_lit) @constant
(comment) @comment
(identifier) @variable

(block (identifier) @type)
(function_call (identifier) @function)
(attribute (identifier) @field)

; { key: val }
;
; highlight identifier keys as though they were block attributes
(object_elem key: (expression (variable_expr (identifier) @field)))

(ERROR) @error
