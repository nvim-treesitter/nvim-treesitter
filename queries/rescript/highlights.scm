(comment) @comment @spell

; Identifiers
;------------
(value_identifier) @variable

; Escaped identifiers like \"+."
((value_identifier) @constant.macro
  (#match? @constant.macro "^\\.*$"))

[
  (type_identifier)
  (unit_type)
  (list)
  (list_pattern)
] @type

[
  (variant_identifier)
  (polyvar_identifier)
] @constant

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

(member_expression
  (property_identifier) @property)

(module_identifier) @module

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

(template_substitution
  "${" @punctuation.bracket
  "}" @punctuation.bracket)

(character) @character

(escape_sequence) @string.escape

; Other literals
;---------------
[
  (true)
  (false)
] @constant.builtin

(number) @number

(polyvar) @constant

(polyvar_string) @constant

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

; first-level descructuring (required for nvim-tree-sitter as it only matches direct
; children and the above patterns do not match destructuring patterns in NeoVim)
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

(call_expression
  function: (value_identifier) @function.call)

(call_expression
  function: (value_identifier_path
    (value_identifier) @function.call))

; Meta
;-----
(decorator_identifier) @attribute

(extension_identifier) @keyword

"%" @keyword

; Misc
;-----
(subscript_expression
  index: (string) @property)

(polyvar_type_pattern
  "#" @constant)

[
  "include"
  "open"
] @keyword.import

[
  "as"
  "export"
  "external"
  "let"
  "module"
  "mutable"
  "private"
  "rec"
  "type"
  "and"
  "assert"
  "await"
  "with"
  "lazy"
  "constraint"
] @keyword

(function
  "async" @keyword)

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
  "=>"
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
] @punctuation.bracket

(polyvar_type
  [
    "["
    "[>"
    "[<"
    "]"
  ] @punctuation.bracket)

(type_arguments
  [
    "<"
    ">"
  ] @punctuation.bracket)

(type_parameters
  [
    "<"
    ">"
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
  ] @operator)

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
