(comment) @comment

[
 "function"
] @keyword.function

[
 "async"
 "await"
 "type"
 "interface"
 "class"
] @keyword

[
  "new"
  "print"
  "echo"
  "newtype"
  "clone"
] @keyword.operator

[
 "return"
] @keyword.return

[
  "shape"
  "tupe"
  (array_type)
  "bool"
  "float"
  "int"
  "string"
  "arraykey"
  "void"
  "nonnull"
  (null)
  "mixed"
  "dynamic"
  "noreturn"
] @type

(type_specifier
  (qualified_identifier) @type)

[
  "="
  "??="
  ".="
  "|="
  "^="
  "&="
  "<<="
  ">>="
  "+="
  "-="
  "*="
  "/="
  "%="
  "**="

  "==>"
  "|>"
  "??"
  "||"
  "&&"
  "|"
  "^"
  "&"
  "=="
  "!="
  "==="
  "!=="
  "<"
  ">"
  "<="
  ">="
  "<=>"
  "<<"
  ">>"
  "+"
  "-"
  "."
  "*"
  "/"
  "%"
  "**"

  "++"
  "--"
  "!"

  "?:"

  "="
  "??="
  ".="
  "|="
  "^="
  "&="
  "<<="
  ">>="
  "+="
  "-="
  "*="
  "/="
  "%="
  "**="

  ;; type modifiers
  "@"
  "?"
  "~"
] @operator

(integer) @number
(float) @float

(parameter
  (variable) @parameter)

(call_expression
  function: (qualified_identifier) @function)

(function_declaration
  name: (identifier) @function)

(type_arguments
  [ "<" ">" ] @punctuation.bracket)
[ "(" ")" "[" "]" "{" "}" "<<" ">>"] @punctuation.bracket

[ "." ";" "::" ":" "," ] @punctuation.delimiter

(ternary_expression
  ["?" ":"] @conditional)

[
  "if"
  "else"
  "elseif"
  "switch"
  "case"
] @conditional

[
  "try"
  "catch"
  "finally"
] @exception

[
  "for"
  "while"
  "do"
  "continue"
  "break"
] @repeat

(string) @string

(ERROR) @error
