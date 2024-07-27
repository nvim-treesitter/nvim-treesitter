; Includes
"use" @keyword.import

; Keywords
[
  "primitive"
  "embed"
  "let"
  "var"
  (compile_intrinsic)
  "as"
  "consume"
  "recover"
  "object"
  "where"
] @keyword

[
  "class"
  "struct"
  "type"
  "interface"
  "trait"
  "actor"
] @keyword.type

"fun" @keyword.function

"be" @keyword.coroutine

[
  "in"
  "is"
] @keyword.operator

"return" @keyword.return

; Qualifiers
[
  "iso"
  "trn"
  "ref"
  "val"
  "box"
  "tag"
  "#read"
  "#send"
  "#share"
  "#alias"
  "#any"
] @keyword.modifier

; Conditionals
[
  "if"
  "ifdef"
  "iftype"
  "then"
  "else"
  "elseif"
  "match"
] @keyword.conditional

(if_statement
  "end" @keyword.conditional)

(iftype_statement
  "end" @keyword.conditional)

(match_statement
  "end" @keyword.conditional)

; Repeats
[
  "repeat"
  "until"
  "while"
  "for"
  "continue"
  "do"
  "break"
] @keyword.repeat

(do_block
  "end" @keyword.repeat)

(repeat_statement
  "end" @keyword.repeat)

; Exceptions
[
  "try"
  (error)
  "compile_error"
] @keyword.exception

(try_statement
  "end" @keyword.exception)

(recover_statement
  "end" @keyword.exception)

; Attributes
(annotation) @attribute

; Variables
(identifier) @variable

(this) @variable.builtin

; Fields
(field
  name: (identifier) @variable.member)

(member_expression
  "."
  (identifier) @variable.member)

; Constructors
(constructor
  "new" @keyword.operator
  (identifier) @constructor)

; Methods
(method
  (identifier) @function.method)

(behavior
  (identifier) @function.method)

(ffi_method
  (identifier) @function.method)

((ffi_method
  (string) @string.special)
  (#set! priority 105))

(call_expression
  callee: [
    (identifier) @function.method.call
    (ffi_identifier
      (identifier) @function.method.call)
    (member_expression
      "."
      (identifier) @function.method.call)
  ])

; Parameters
(parameter
  name: (identifier) @variable.parameter)

(lambda_parameter
  name: (identifier) @variable.parameter)

; Types
(type_alias
  (identifier) @type.definition)

(base_type
  name: (identifier) @type)

(generic_parameter
  (identifier) @type)

(lambda_type
  (identifier)? @function.method)

((identifier) @type
  (#lua-match? @type "^_*[A-Z][a-zA-Z0-9_]*$"))

; Operators
(unary_expression
  operator: [
    "not"
    "addressof"
    "digestof"
  ] @keyword.operator)

(binary_expression
  operator: [
    "and"
    "or"
    "xor"
    "is"
    "isnt"
  ] @keyword.operator)

[
  "="
  "?"
  "|"
  "&"
  "-~"
  "+"
  "-"
  "*"
  "/"
  "%"
  "%%"
  "<<"
  ">>"
  "=="
  "!="
  ">"
  ">="
  "<="
  "<"
  "+~"
  "-~"
  "*~"
  "/~"
  "%~"
  "%%~"
  "<<~"
  ">>~"
  "==~"
  "!=~"
  ">~"
  ">=~"
  "<=~"
  "<~"
  "+?"
  "-?"
  "*?"
  "/?"
  "%?"
  "%%?"
  "<:"
] @operator

; Literals
(string) @string

(source_file
  (string) @string.documentation)

(actor_definition
  (string) @string.documentation)

(class_definition
  (string) @string.documentation)

(primitive_definition
  (string) @string.documentation)

(interface_definition
  (string) @string.documentation)

(trait_definition
  (string) @string.documentation)

(struct_definition
  (string) @string.documentation)

(type_alias
  (string) @string.documentation)

(field
  (string) @string.documentation)

(constructor
  [
    (string) @string.documentation
    (block
      .
      (string) @string.documentation)
  ])

(method
  [
    (string) @string.documentation
    (block
      .
      (string) @string.documentation)
  ])

(behavior
  [
    (string) @string.documentation
    (block
      .
      (string) @string.documentation)
  ])

(character) @character

(escape_sequence) @string.escape

(number) @number

(float) @number.float

(boolean) @boolean

; Punctuation
[
  "{"
  "}"
] @punctuation.bracket

[
  "["
  "]"
] @punctuation.bracket

[
  "("
  ")"
] @punctuation.bracket

[
  "."
  ","
  ";"
  ":"
  "~"
  ".>"
  "->"
  "=>"
] @punctuation.delimiter

[
  "@"
  "!"
  "^"
  "..."
] @punctuation.special

; Comments
[
  (line_comment)
  (block_comment)
] @comment @spell
