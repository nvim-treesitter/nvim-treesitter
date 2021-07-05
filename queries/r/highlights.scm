; highlights.scm

(call function: (identifier) @function)
(namespace_get function: (identifier) @method)
(namespace_get_internal function: (identifier) @method)

; Literals

(integer) @number

(float) @number

(complex) @number

(string) @string

(comment) @comment

(formal_parameters (identifier) @parameter)

(identifier) @variable

; Operators
[
 "="
 "<-"
 "<<-"
 "->"
] @operator

(unary operator: [
  "-"
  "+"
  "!"
  "~"
] @operator)

(binary operator: [
  "-"
  "+"
  "*"
  "/"
  "^"
  "<"
  ">"
  "<="
  ">="
  "=="
  "!="
  "||"
  "|"
  "&&"
  "&"
  ":"
  "~"
] @operator)

(special) @operator

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

[
 "while"
 "if"
 "else"
 "repeat"
 "for"
 "in"
 (dots)
 (true)
 (false)
 (break)
 (next)
 (inf)
 (nan)
 (na)
 (null)
] @keyword


"function" @keyword.function
