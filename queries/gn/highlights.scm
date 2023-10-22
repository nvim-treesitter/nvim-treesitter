; Includes

"import" @include

; Conditionals

[
  "if"
  "else"
] @conditional

; Repeats

"foreach" @repeat

; Operators

[
  "="
  "+="
  "-="
  "!"
  "+"
  "-"
  "<"
  "<="
  ">"
  ">="
  "=="
  "!="
  "&&"
  "||"
] @operator

; Variables

(identifier) @variable

; Functions

(call_expression function: (identifier) @function.call)

; Fields

(scope_access field: (identifier) @field)

; Literals

(string) @string

(escape_sequence) @string.escape

(expansion) @none

(integer) @number

(hex) @string.special

(boolean) @boolean

; Punctuation

[ "{" "}" "[" "]" "(" ")" ] @punctuation.bracket

[
  "."
  ","
] @punctuation.delimiter

(expansion ["$" "${" "}"] @punctuation.special)

; Comments

(comment) @comment
