[
  "{{"
  "{{-"
  "-}}"
  "}}"
  "{%"
  "{%-"
  "-%}"
  "%}"
] @keyword.directive

(string_literal) @string

(number_literal) @number

(float_literal) @number

(boolean_literal) @boolean

(null_literal) @constant

"defined" @constant

(comment) @comment

[
  ","
  "."
  ":"
] @punctuation.delimiter

[
  (attribute_ignore)
  (attribute_context)
  "recursive"
] @attribute.builtin

[
  "("
  ")"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

[
  "-"
  "*"
  "+"
  "="
  "%"
  "~"
  "|"
] @operator

[
  "endtrans"
  "block"
  "endblock"
  "with"
  "endwith"
  "filter"
  "endfilter"
  "macro"
  "endmacro"
  "endcall"
  "set"
  "endset"
  "trans"
  "endtrans"
  "autoescape"
  "endautoescape"
  "pluralize"
  "is"
  "not"
  "and"
] @keyword.builtin

(do_statement
  "do" @keyword)

[
  "include"
  "import"
  "from"
  "extends"
  "as"
] @keyword.import

(import_statement
  (identifier) @variable)

(import_as
  (identifier) @variable)

[
  "if"
  "else"
  "endif"
] @keyword.conditional

[
  "for"
  "in"
  "continue"
  "break"
  "endfor"
] @keyword.repeat

"call" @function.call

(function_call
  (identifier) @function.call)

(arg
  (identifier) @variable.parameter)

(expression
  (expression) @variable.member
  "."
  (expression)+ @variable.member)

(assignment_expression
  (identifier) @variable.member
  "."
  (identifier)+ @variable.member)

(inline_trans
  "_" @function.builtin)

"debug" @function.builtin

; TODO: only match raw
(raw_start) @keyword

(raw_end) @keyword

(raw_body) @markup.raw.block @nospell

(identifier) @variable.parameter

(builtin_test
  [
    "boolean"
    "even"
    "in"
    "mapping"
    "sequence"
    "callable"
    "integer"
    "ne"
    "string"
    "defined"
    "filter"
    "iterable"
    "none"
    "test"
    "divisibleby"
    "float"
    "le"
    "number"
    "eq"
    "ge"
    "lower"
    "odd"
    "undefined"
    "escaped"
    "gt"
    "lt"
    "sameas"
    "upper"
  ] @keyword.builtin)
