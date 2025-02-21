; Brackets and operators
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
  "->"
  "."
  ":"
] @punctuation.delimiter

[
  "!="
  "%"
  "%="
  "&"
  "&="
  "*"
  "**"
  "**="
  "*="
  "+"
  "+="
  "-"
  "-="
  "/"
  "/="
  "<"
  "<<"
  "<<="
  "<="
  "<="
  "=="
  ">"
  ">="
  ">="
  ">>"
  ">>="
  ">>>"
  ">>>="
  "^"
  "^="
  "|"
  "|="
] @operator

; Keywords
[
  "as"
  "copy"
  "for"
  "impl"
  "in"
  "inline"
  "let"
  "move"
  "mut"
  "recover"
  "ref"
  "uni"
] @keyword

"fn" @keyword.function

"import" @keyword.import

[
  "and"
  "or"
] @keyword.operator

[
  "trait"
  "type"
] @keyword.type

[
  "extern"
  (modifier)
  (visibility)
] @keyword.modifier

[
  "loop"
  "while"
  (break)
  (next)
] @keyword.repeat

"return" @keyword.return

[
  "throw"
  "try"
] @keyword.exception

[
  "case"
  "else"
  "if"
  "match"
] @keyword.conditional

; Identifiers/variable references
(identifier) @variable

; Comments
(line_comment) @comment @spell

; Literals
(self) @variable.builtin

(nil) @constant.builtin

[
  (true)
  (false)
] @boolean

(integer) @number

(float) @number.float

(string) @string

(escape_sequence) @string.escape

(interpolation
  "${" @punctuation.special
  "}" @punctuation.special) @none

(constant) @constant

; Patterns
(integer_pattern) @number

(string_pattern) @string

(constant_pattern) @constant

(boolean_pattern) @boolean

; Types
(generic_type
  name: _ @type)

(type) @type

; Imports
(extern_import
  path: _ @string)

(import
  (path
    (identifier) @module))

; Classes
(class
  name: _ @type)

(define_field
  name: _ @variable.member)

; Traits
(trait
  name: _ @type)

; Implementations
(implement_trait
  class: _ @type)

(reopen_class
  name: _ @type)

(bound
  name: _ @type)

; Methods
(method
  name: _ @function)

(external_function
  name: _ @function)

(argument
  name: _ @variable.parameter)

(named_argument
  name: _ @variable.parameter)

(call
  name: [
    (name)
    (constant)
  ] @function)

(field) @variable.member
