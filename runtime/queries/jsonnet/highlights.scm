(id) @variable
(comment) @comment @spell

; Literals
(null) @constant.builtin
(string) @string
(number) @number
[
  (true)
  (false)
] @boolean

; Keywords
"for" @repeat
"in" @keyword.operator
"function" @keyword.function

[
  "if"
  "then"
  "else"
] @conditional

[
  (local)
  (tailstrict)
  "function"
] @keyword

[
  "assert"
  "error"
] @exception

[
  (dollar)
  (self)
  (super)
] @variable.builtin
((id) @variable.builtin
 (#eq? @variable.builtin "std"))

; Operators
[
  (multiplicative)
  (additive)
  (bitshift)
  (comparison)
  (equality)
  (bitand)
  (bitxor)
  (bitor)
  (and)
  (or)
  (unaryop)
] @operator

; Punctuation
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
] @punctuation.delimiter

[
  "::"
  ":::"
] @punctuation.special

(field
  (fieldname) "+" @punctuation.special)

; Imports
[
  (import)
  (importstr)
] @include

; Fields

(fieldname (id) @field)
(fieldname (string (string_content) @field))

; Functions
(field
  function: (fieldname (id) @function))
(field
  function: (fieldname
              (string (string_content) @function)))
(param
  identifier: (id) @parameter)

(bind (id) @variable.local)
(bind function: (id) @function)

; Function call
(functioncall
  (fieldaccess
    last: (id) @function.call)?
  (fieldaccess_super
    (id) @function.call)?
  (id)? @function.call
  "("
  (args
    (named_argument
      (id) @parameter
    ))?
  ")")
