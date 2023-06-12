; Types
; Javascript
; Variables
;-----------
(identifier) @variable

; Properties
;-----------
(property_identifier) @variable.member

(shorthand_property_identifier) @variable.member

(private_property_identifier) @variable.member

(object_pattern
  (shorthand_property_identifier_pattern) @variable)

(object_pattern
  (object_assignment_pattern
    (shorthand_property_identifier_pattern) @variable))

; Special identifiers
;--------------------
((identifier) @type
  (#lua-match? @type "^[A-Z]"))

((identifier) @constant
  (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

((shorthand_property_identifier) @constant
  (#lua-match? @constant "^_*[A-Z][A-Z%d_]*$"))

((identifier) @variable.builtin
  (#any-of? @variable.builtin "arguments" "module" "console" "window" "document"))

((identifier) @type.builtin
  (#any-of? @type.builtin
    "Object" "Function" "Boolean" "Symbol" "Number" "Math" "Date" "String" "RegExp" "Map" "Set"
    "WeakMap" "WeakSet" "Promise" "Array" "Int8Array" "Uint8Array" "Uint8ClampedArray" "Int16Array"
    "Uint16Array" "Int32Array" "Uint32Array" "Float32Array" "Float64Array" "ArrayBuffer" "DataView"
    "Error" "EvalError" "InternalError" "RangeError" "ReferenceError" "SyntaxError" "TypeError"
    "URIError"))

(statement_identifier) @label

; Function and method definitions
;--------------------------------
(function_expression
  name: (identifier) @function)

(function_declaration
  name: (identifier) @function)

(generator_function
  name: (identifier) @function)

(generator_function_declaration
  name: (identifier) @function)

(method_definition
  name: [
    (property_identifier)
    (private_property_identifier)
  ] @function.method)

(method_definition
  name: (property_identifier) @constructor
  (#eq? @constructor "constructor"))

(pair
  key: (property_identifier) @function.method
  value: (function_expression))

(pair
  key: (property_identifier) @function.method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: (function_expression))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))

(variable_declarator
  name: (identifier) @function
  value: (function_expression))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))

(assignment_expression
  left: (identifier) @function
  right: (function_expression))

; Function and method calls
;--------------------------
(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (member_expression
    property: [
      (property_identifier)
      (private_property_identifier)
    ] @function.method.call))

; Builtins
;---------
((identifier) @module.builtin
  (#eq? @module.builtin "Intl"))

((identifier) @function.builtin
  (#any-of? @function.builtin
    "eval" "isFinite" "isNaN" "parseFloat" "parseInt" "decodeURI" "decodeURIComponent" "encodeURI"
    "encodeURIComponent" "require"))

; Constructor
;------------
(new_expression
  constructor: (identifier) @constructor)

; Variables
;----------
(namespace_import
  (identifier) @module)

; Decorators
;----------
(decorator
  "@" @attribute
  (identifier) @attribute)

(decorator
  "@" @attribute
  (call_expression
    (identifier) @attribute))

(decorator
  "@" @attribute
  (member_expression
    (property_identifier) @attribute))

(decorator
  "@" @attribute
  (call_expression
    (member_expression
      (property_identifier) @attribute)))

; Literals
;---------
[
  (this)
  (super)
] @variable.builtin

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))

[
  (true)
  (false)
] @boolean

[
  (null)
  (undefined)
] @constant.builtin

[
  (comment)
  (html_comment)
] @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/[*][*][^*].*[*]/$"))

(hash_bang_line) @keyword.directive

((string_fragment) @keyword.directive
  (#eq? @keyword.directive "use strict"))

(string) @string

(template_string) @string

(escape_sequence) @string.escape

(regex_pattern) @string.regexp

(regex_flags) @character.special

(regex
  "/" @punctuation.bracket) ; Regex delimiters

(number) @number

((identifier) @number
  (#any-of? @number "NaN" "Infinity"))

; Punctuation
;------------
[
  ";"
  "."
  ","
  ":"
] @punctuation.delimiter

[
  "--"
  "-"
  "-="
  "&&"
  "+"
  "++"
  "+="
  "&="
  "/="
  "**="
  "<<="
  "<"
  "<="
  "<<"
  "="
  "=="
  "==="
  "!="
  "!=="
  "=>"
  ">"
  ">="
  ">>"
  "||"
  "%"
  "%="
  "*"
  "**"
  ">>>"
  "&"
  "|"
  "^"
  "??"
  "*="
  ">>="
  ">>>="
  "^="
  "|="
  "&&="
  "||="
  "??="
  "..."
] @operator

(binary_expression
  "/" @operator)

(ternary_expression
  [
    "?"
    ":"
  ] @keyword.conditional.ternary)

(unary_expression
  [
    "!"
    "~"
    "-"
    "+"
  ] @operator)

(unary_expression
  [
    "delete"
    "void"
  ] @keyword.operator)

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(template_substitution
  [
    "${"
    "}"
  ] @punctuation.special) @none

; Keywords
;----------
[
  "if"
  "else"
  "switch"
  "case"
] @keyword.conditional

[
  "import"
  "from"
] @keyword.import

(export_specifier
  "as" @keyword.import)

(import_specifier
  "as" @keyword.import)

(namespace_export
  "as" @keyword.import)

(namespace_import
  "as" @keyword.import)

[
  "for"
  "of"
  "do"
  "while"
  "continue"
] @keyword.repeat

[
  "break"
  "class"
  "const"
  "debugger"
  "export"
  "extends"
  "get"
  "let"
  "set"
  "static"
  "target"
  "var"
  "with"
] @keyword

[
  "async"
  "await"
] @keyword.coroutine

[
  "return"
  "yield"
] @keyword.return

"function" @keyword.function

[
  "new"
  "delete"
  "in"
  "instanceof"
  "typeof"
] @keyword.operator

[
  "throw"
  "try"
  "catch"
  "finally"
] @keyword.exception

(export_statement
  "default" @keyword)

(switch_default
  "default" @keyword.conditional)
