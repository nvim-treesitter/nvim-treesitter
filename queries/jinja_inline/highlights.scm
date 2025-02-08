"#" @keyword.directive

(string_literal) @string

(number_literal) @number

(float_literal) @number.float

(boolean_literal) @boolean

(null_literal) @constant

"defined" @constant

(comment) @comment @spell

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

(binary_operator) @operator

[
  "block"
  "with"
  "filter"
  "macro"
  "set"
  "trans"
  "pluralize"
  "autoescape"
] @keyword

[
  "endtrans"
  "endblock"
  "endwith"
  "endfilter"
  "endmacro"
  "endcall"
  "endset"
  "endtrans"
  "endautoescape"
] @keyword

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
  "elif"
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

(arg
  (expression
    (binary_expression
      (unary_expression
        (primary_expression
          (identifier) @variable.parameter)))))

(expression
  "."
  (expression)+ @variable.member)

(assignment_expression
  "."
  (identifier)+ @variable.member)

(inline_trans
  "_" @function.builtin)

"debug" @function.builtin

(raw_end) @keyword

(raw_body) @markup.raw.block @nospell

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
  ] @keyword.operator)
