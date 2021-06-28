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
  ":"
  "=>"
] @punctuation.special

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

(template_interpolation) @string.escape

(heredoc_identifier) @namespace
(heredoc_start) @namespace
(numeric_lit) @number
(bool_lit) @boolean
(null_lit) @constant
(comment) @comment
(identifier) @symbol

(block (identifier) @namespace)
(function_call (identifier) @function)
(function_call (function_arguments) @parameter)
(attribute (identifier) @symbol)

(ERROR) @error
