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
  "[*]"
  ".*"
] @specialChar

[
  "."
  ","
] @specialChar

[
  (ellipsis)
  "\?"
  ":"
  "=>"
] @special

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

(heredoc_identifier) @namespace
(heredoc_start) @namespace
(template_interpolation) @statement
(numeric_lit) @number
(bool_lit) @boolean
(null_lit) @constant
(comment) @comment
(identifier) @identifier

(block (identifier) @namespace)
(function_call (identifier) @function)
(function_call (function_arguments) @parameter)
(attribute (identifier) @symbol)

(ERROR) @error
