(dotted_identifier_list) @string

; Methods

(function_type
  name: (identifier) @method)
(super) @function

; Annotations
(annotation
  name: (identifier) @annotation)
(marker_annotation
  name: (identifier) @annotation)

; Operators and Tokens

; FIXME: nodes not accessible and ranges
; currently incorrect
; (template_substitution
;   "${" @punctuation.special
;   "}" @punctuation.special) @embedded

(template_substitution (identifier) @embedded)

[
 "@"
 "=>"
 ".."
 "??"
 "=="
 "?"
 ":"
 "&&"
 "%"
 "<"
 ">"
 "="
 ">="
 "<="
 "||"
 (increment_operator)
 (is_operator)
 (prefix_operator)
 (equality_operator)
 (additive_operator)
] @operator

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

; Delimiters

[
  ";"
  "."
  ","
] @punctuation.delimiter

; Types

(class_definition
  name: (identifier) @type)
(constructor_signature
  name: (identifier) @type)
(type_identifier
  (identifier) @type)
(scoped_identifier
  scope: (identifier) @type)
(function_signature
  name: (identifier) @method)
(getter_signature
  (identifier) @method)
(setter_signature
  name: (identifier) @method)
(enum_declaration
  name: (identifier) @type)
(enum_constant
  name: (identifier) @type)
(type_identifier) @type
(void_type) @type

((scoped_identifier
  scope: (identifier) @type
  name: (identifier) @type)
 (#match? @type "^[a-zA-Z]"))

(type_identifier) @type

; Variables

; var keyword
(inferred_type) @keyword

(const_builtin) @constant.builtin
(final_builtin) @constant.builtin

((identifier) @type
 (#match? @type "^[A-Z]"))

; properties
; TODO: add method/call_expression to grammar and
; distinguish method call from variable access
(unconditional_assignable_selector
  (identifier) @property)
(assignable_selector
  (identifier) @property)

; assignments
(assignment_expression
  left: (assignable_expression) @variable)

(this) @variable.builtin

; Parameters

(formal_parameter
    name: (identifier) @parameter)

(named_argument
  (label (identifier) @variable.parameter))

; Literals

[
    (hex_integer_literal)
    (decimal_integer_literal)
    (decimal_floating_point_literal)
    ; TODO: inaccessbile nodes
    ; (octal_integer_literal)
    ; (hex_floating_point_literal)
] @number

(symbol_literal) @string.special.symbol
(string_literal) @string
(true) @boolean
(false) @boolean
(null_literal) @constant.builtin

(documentation_comment) @comment
(comment) @comment

; Keywords

["import" "library" "export"] @include

; Reserved words (cannot be used as identifiers)
; TODO: "rethrow" @keyword

[
    ; "assert"
    "class"
    "enum"
    "extends"
    "in"
    "is"
    "new"
    "return"
    "super"
    "with"
] @keyword


; Built in identifiers:
; alone these are marked as keywords
[
    "abstract"
    "as"
    "async"
    "await"
    "covariant"
    "deferred"
    "dynamic"
    "external"
    "factory"
    "Function"
    "get"
    "implements"
    "interface"
    "library"
    "operator"
    "mixin"
    "part"
    "set"
    "show"
    "static"
    "typedef"
] @keyword

; when used as an identifier:
((identifier) @variable.builtin
 (#vim-match? @variable.builtin "^(abstract|as|covariant|deferred|dynamic|export|external|factory|Function|get|implements|import|interface|library|operator|mixin|part|set|static|typedef)$"))

["if" "else" "switch" "default"] @conditional

[
  "try"
  "throw"
  "catch"
  "finally"
  (break_statement)
] @exception

["do" "while" "continue" "for"] @repeat

; Error
(ERROR) @error
