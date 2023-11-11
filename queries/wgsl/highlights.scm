(identifier) @variable

(int_literal) @number

(float_literal) @number.float

(bool_literal) @boolean

(type_declaration) @type

(function_declaration
  (identifier) @function)

(parameter
  (variable_identifier_declaration
    (identifier) @variable.parameter))

(struct_declaration
  (identifier) @type)

(struct_declaration
  (struct_member
    (variable_identifier_declaration
      (identifier) @variable.member)))

(type_constructor_or_function_call_expression
  (type_declaration) @function.call)

[
  "struct"
  "bitcast"
  "discard"
  "enable"
  "fallthrough"
  "let"
  "type"
  "var"
  "override"
  (texel_format)
] @keyword

[
  "private"
  "storage"
  "uniform"
  "workgroup"
] @keyword.storage

[
  "read"
  "read_write"
  "write"
] @type.qualifier

"fn" @keyword.function

"return" @keyword.return

[
  ","
  "."
  ":"
  ";"
  "->"
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  "loop"
  "for"
  "while"
  "break"
  "continue"
  "continuing"
] @keyword.repeat

[
  "if"
  "else"
  "switch"
  "case"
  "default"
] @keyword.conditional

[
  "&"
  "&&"
  "/"
  "!"
  "="
  "=="
  "!="
  ">"
  ">="
  ">>"
  "<"
  "<="
  "<<"
  "%"
  "-"
  "+"
  "|"
  "||"
  "*"
  "~"
  "^"
  "@"
  "++"
  "--"
] @operator

(attribute
  (identifier) @attribute)

[
  (line_comment)
  (block_comment)
] @comment @spell
