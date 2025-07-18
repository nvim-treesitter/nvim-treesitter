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

(true) @boolean

(false) @boolean

(null) @constant.builtin

; Special references
(star) @constant.builtin

(parent) @constant.builtin

(this) @constant.builtin

; Identifiers
(identifier) @variable

; Parameters
(parameter) @variable.parameter

; Function calls
(function_call
  (identifier) @function)

(order_function
  "order" @function.builtin)

; Comments
(comment) @comment @spell

; Conditional projections
(conditional_projection
  "=>" @operator)

; Select statements
(select_statement
  "..." @operator
  "select" @keyword
  "=>" @operator)

; Spread operators
(spread_operator
  "..." @operator)

; Array access
(attribute_access
  "." @punctuation.delimiter)

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
