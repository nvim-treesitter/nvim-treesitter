; Keywords
[
  "package"
  "import"
  "func"
  "return"
  "type"
  "struct"
  "interface"
  "map"
  "chan"
  "for"
  "if"
  "else"
  "var"
  "const"
  "range"
] @keyword

; Dingo-specific keywords
[
  "enum"
  "match"
] @keyword

; Operators
[
  "="
  ":="
  "+"
  "-"
  "*"
  "/"
  "%"
  "&"
  "|"
  "^"
  "!"
  "<"
  ">"
  "=="
  "!="
  "<="
  ">="
  "&&"
  "||"
  "<<"
  ">>"
  "<-"
  "+="
  "-="
  "*="
  "/="
] @operator

; Dingo special operators
"=>" @operator

"?." @operator

"??" @operator

(error_propagation
  "?" @operator)

; Lambda pipes (special highlighting)
(lambda_expression
  "|" @punctuation.special)

; Types
(type_declaration
  (identifier) @type.definition)

(type_param
  (identifier) @type)

(generic_type
  (identifier) @type)

(qualified_type
  (identifier) @type)

; Dingo enum
(enum_declaration
  name: (identifier) @type.definition)

(enum_variant
  name: (identifier) @constructor)

(variant_field
  (identifier) @property)

; Match patterns
(match_expression
  "match" @keyword.conditional)

(variant_match
  (identifier) @constructor)

; Functions
(function_declaration
  name: (identifier) @function)

(call_expr
  (identifier) @function.call)

(call_expr
  (selector_expr
    (identifier) @function.method.call))

; Parameters
(param_decl
  (identifier) @variable.parameter)

(lambda_param
  (identifier) @variable.parameter)

; Variables
(var_spec
  (identifier) @variable)

(const_spec
  (identifier) @constant)

; Literals
(int_literal) @number

(float_literal) @number.float

(string_literal) @string

(rune_literal) @character

; Booleans and nil
"true" @boolean

"false" @boolean

"nil" @constant.builtin

; Comments
(comment) @comment

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ","
  ";"
  ":"
  "."
] @punctuation.delimiter

; Import path
(import_spec
  (string_literal) @string.special)

; Package name
(package_clause
  (identifier) @module)

; Wildcard pattern
"_" @variable.builtin

; Error propagation expression (special styling)
(error_propagation) @punctuation.special

; Safe navigation (special styling)
(safe_navigation) @punctuation.special
