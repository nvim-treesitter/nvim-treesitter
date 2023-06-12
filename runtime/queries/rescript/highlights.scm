(comment) @comment @spell

; Identifiers
;------------
; Escaped identifiers like \"+."
((value_identifier) @constant.macro
  (#lua-match? @constant.macro "^%.*$"))

(value_identifier) @variable

[
  (type_identifier)
  (unit_type)
  (list)
  (list_pattern)
] @type

((type_identifier) @type.builtin
  (#any-of? @type.builtin "int" "char" "string" "float" "bool" "unit"))

[
  (variant_identifier)
  (polyvar_identifier)
] @constructor

(record_type_field
  (property_identifier) @property)

(record_field
  (property_identifier) @property)

(object
  (field
    (property_identifier) @property))

(object_type
  (field
    (property_identifier) @property))

(module_identifier) @module

(member_expression
  (property_identifier) @variable.member)

(value_identifier_path
  (module_identifier)
  (value_identifier) @variable)

(record_pattern
  (value_identifier_path
    (value_identifier) @variable.member))

(record_pattern
  (value_identifier) @variable)

(labeled_argument
  label: (value_identifier) @variable.parameter)

; Parameters
;----------------
(list_pattern
  (value_identifier) @variable.parameter)

(spread_pattern
  (value_identifier) @variable.parameter)

; String literals
;----------------
[
  (string)
  (template_string)
] @string

(character) @character

(escape_sequence) @string.escape

; Other literals
;---------------
[
  (true)
  (false)
] @boolean

(number) @number

(polyvar) @constructor

(polyvar_string) @constructor

; Functions
;----------
; parameter(s) in parens
(parameter
  (value_identifier) @variable.parameter)

(labeled_parameter
  (value_identifier) @variable.parameter)

; single parameter with no parens
(function
  parameter: (value_identifier) @variable.parameter)

(parameter
  (tuple_pattern
    (tuple_item_pattern
      (value_identifier) @variable.parameter)))

(parameter
  (array_pattern
    (value_identifier) @variable.parameter))

(parameter
  (record_pattern
    (value_identifier) @variable.parameter))

; function identifier in let binding
(let_binding
  pattern: (value_identifier) @function
  body: (function))

; function calls
(call_expression
  function: (value_identifier_path
    (value_identifier) @function.method.call .))

(call_expression
  function: (value_identifier) @function.call)

; highlight the right-hand side of a pipe operator as a function call
(pipe_expression
  (value_identifier) @function.call .)

(pipe_expression
  (value_identifier_path
    (value_identifier) @function.method.call .) .)

; Meta
;-----
(decorator_identifier) @attribute

(extension_identifier) @keyword

"%" @keyword

; Misc
;-----
(polyvar_type_pattern
  "#" @constructor)

[
  "include"
  "open"
] @keyword.import

[
  "private"
  "mutable"
  "rec"
] @keyword.modifier

"type" @keyword.type

[
  "and"
  "with"
  "as"
] @keyword.operator

[
  "export"
  "external"
  "let"
  "module"
  "assert"
  "await"
  "lazy"
  "constraint"
] @keyword

"await" @keyword.coroutine

(function
  "async" @keyword.coroutine)

(module_unpack
  "unpack" @keyword)

[
  "if"
  "else"
  "switch"
  "when"
] @keyword.conditional

[
  "exception"
  "try"
  "catch"
] @keyword.exception

(call_expression
  function: (value_identifier) @keyword.exception
  (#eq? @keyword.exception "raise"))

[
  "for"
  "in"
  "to"
  "downto"
  "while"
] @keyword.repeat

[
  "."
  ","
  "|"
  ":"
] @punctuation.delimiter

[
  "++"
  "+"
  "+."
  "-"
  "-."
  "*"
  "**"
  "*."
  "/."
  "<="
  "=="
  "==="
  "!"
  "!="
  "!=="
  ">="
  "&&"
  "||"
  "="
  ":="
  "->"
  "|>"
  ":>"
  "+="
  "=>"
  (uncurry)
] @operator

; Explicitly enclose these operators with binary_expression
; to avoid confusion with JSX tag delimiters
(binary_expression
  [
    "<"
    ">"
    "/"
  ] @operator)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "<"
  ">"
] @punctuation.bracket

(unit
  [
    "("
    ")"
  ] @constant.builtin)

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @none

(polyvar_type
  [
    "["
    "[>"
    "[<"
    "]"
  ] @punctuation.bracket)

[
  "~"
  "?"
  ".."
  "..."
] @punctuation.special

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

; JSX
;----------
(jsx_identifier) @tag

(jsx_element
  open_tag: (jsx_opening_element
    [
      "<"
      ">"
    ] @tag.delimiter))

(jsx_element
  close_tag: (jsx_closing_element
    [
      "<"
      "/"
      ">"
    ] @tag.delimiter))

(jsx_self_closing_element
  [
    "/"
    ">"
    "<"
  ] @tag.delimiter)

(jsx_fragment
  [
    ">"
    "<"
    "/"
  ] @tag.delimiter)

(jsx_attribute
  (property_identifier) @tag.attribute)
