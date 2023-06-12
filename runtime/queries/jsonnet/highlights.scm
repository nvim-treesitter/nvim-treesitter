[
  (true)
  (false)
] @boolean

(comment) @comment
(id) @variable
(import) @include
(null) @constant.builtin
(number) @number
(string) @string

(fieldname (id) @field)
(fieldaccess
  last: (id) @field)
(fieldaccess_super
  (id) @field)

[
  "["
  "]"
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

[
  "."
  ","
  ";"
  ":"
  "::"
  ":::"
] @punctuation.delimiter

; Nested field inheritance
("+" @punctuation.delimiter [":" "::" ":::"])

"=" @operator
(unaryop) @operator
(binary
  operator: (_) @operator)

"for" @repeat

"function" @keyword.function

"in" @keyword.operator

[
 (local)
 (tailstrict)
 "assert"
] @keyword

[
  "else"
  "if"
  "then"
] @conditional

"error" @exception

[
  (dollar)
  (self)
  (super)
] @variable.builtin
((id) @variable.builtin
 (#eq? @variable.builtin "std"))

; Function declaration
(param
  identifier: (id) @parameter)
(field
  (fieldname (id) @function)
  [(anonymous_function) (params)])
(bind
  function: (id) @function)

; Function call
(functioncall (id) @function.call)
(functioncall
  (fieldaccess
    last: (id) @function.call))
(functioncall
  (fieldaccess_super
    (id) @function.call))
(named_argument (id) @parameter)

(ERROR) @error
