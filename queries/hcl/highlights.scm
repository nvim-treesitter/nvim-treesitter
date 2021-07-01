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
  (string_lit)
  (quoted_template)
  (heredoc_template)
] @string


[
  (heredoc_identifier)
  (heredoc_start)
] @punctuation.delimiter

(template_interpolation) @string.escape

(numeric_lit) @number
(bool_lit) @boolean
(null_lit) @constant
(comment) @comment
(identifier) @variable

(block (identifier) @type)
(function_call (identifier) @function)
(attribute (identifier) @field)

(ERROR) @error
