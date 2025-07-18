; Keywords
[
  "select"
  "asc"
  "desc"
] @keyword

[
  "in"
  "match"
] @keyword.operator

; Operators
[
  "=="
  "!="
  ">"
  ">="
  "<"
  "<="
  "&&"
  "||"
  "!"
  "+"
  "-"
  "*"
  "/"
  "%"
  "**"
  ".."
  "..."
  "=>"
  "->"
  "|"
] @operator

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ":"
  "."
] @punctuation.delimiter

; Literals
(string) @string

(number) @number

[
  (true)
  (false)
] @boolean

; Special references
[
  (null)
  (star)
  (parent)
  (this)
] @constant.builtin

; Identifiers
(identifier) @variable

; Parameters
(parameter
  "$" @variable.parameter
  (identifier) @variable.parameter)

; Function calls
(function_call
  (identifier) @function)

(order_function
  "order" @function.builtin)

; Comments
(comment) @comment @spell

; String keys in projections/objects
(pair
  (literal
    (string) @property))

; Highlight field names in projections
(projection
  (identifier) @property)

; Built-in functions (essential GROQ functions)
(function_call
  (identifier) @function.builtin
  (#any-of? @function.builtin
    "count" "length" "defined" "references" "now" "dateTime" "coalesce" "unique" "max" "min" "sum"
    "avg" "round" "floor" "ceil" "abs" "sqrt" "upper" "lower" "string" "number" "boolean" "array"
    "object" "type" "global" "sanity" "path" "delta" "after" "before"))
