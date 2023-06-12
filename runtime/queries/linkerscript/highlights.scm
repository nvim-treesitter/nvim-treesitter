; Keywords
[
  "ENTRY"
  "SECTIONS"
  "AT"
  "OVERLAY"
  "NOCROSSREFS"
  "MEMORY"
  "PHDRS"
  "FILEHDR"
] @keyword

; Conditionals
(conditional_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

; Variables
(symbol) @variable

(filename) @string.special.path

; Functions
(call_expression
  function: (symbol) @function.call)

((call_expression
  function: (symbol) @keyword.directive)
  (#eq? @keyword.directive "DEFINED"))

((call_expression
  function: (symbol) @function.builtin)
  (#any-of? @function.builtin
    "ABSOLUTE" "ALIAS" "ADDR" "ALIGN" "ALIGNOF" "BASE" "BLOCK" "CHIP" "DATA_SEGMENT_ALIGN"
    "DATA_SEGMENT_END" "DATA_SEGMENT_RELRO_END" "END" "LENGTH" "LOADADDR" "LOG2CEIL" "MAX" "MIN"
    "NEXT" "ORIGIN" "SEGMENT_START" "SIZEOF" "BYTE" "FILL" "LONG" "SHORT" "QUAD" "SQUAD" "WORD"))

[
  "KEEP"
  "PROVIDE"
  "PROVIDE_HIDDEN"
] @function.builtin

; Types
(section_type
  "("
  [
    "NOLOAD"
    "DSECT"
    "COPY"
    "INFO"
    "OVERLAY"
  ] @type.builtin
  ")")

; Fields
[
  "ORIGIN"
  "org"
  "o"
  "LENGTH"
  "len"
  "l"
] @variable.member

; Constants
((symbol) @constant
  (#lua-match? @constant "^[%u_][%u%d_]+$"))

; Labels
(entry_command
  name: (symbol) @label)

(output_section
  name: (symbol) @label)

(memory_command
  name: (symbol) @label)

(phdrs_command
  name: (symbol) @label)

(region
  ">"
  (symbol) @label)

(lma_region
  ">"
  (symbol) @label)

(phdr
  ":"
  (symbol) @label)

([
  (symbol)
  (filename)
] @label
  (#lua-match? @label "^%."))

; Exceptions
"ASSERT" @keyword.exception

[
  "/DISCARD/"
  "."
] @variable.builtin

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "%"
  "||"
  "&&"
  "|"
  "&"
  "=="
  "!="
  ">"
  ">="
  "<="
  "<"
  "<<"
  ">>"
  "!"
  "~"
  "="
  "+="
  "-="
  "*="
  "/="
  "<<="
  ">>="
  "&="
  "|="
] @operator

; Literals
(number) @number

(quoted_symbol) @string

(wildcard_pattern
  [
    "*"
    "["
    "]"
  ] @character.special)

(attributes) @character.special

; Punctuation
[
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

[
  ":"
  ";"
] @punctuation.delimiter

">" @punctuation.special

; Comments
(comment) @comment @spell
