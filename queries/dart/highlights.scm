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

; FIXME: currently this errors
; (template_substitution
;   "${" @punctuation.special
;   "}" @punctuation.special) @embedded

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

(identifier) @variable

(this) @variable.builtin

(unconditional_assignable_selector (identifier) @identifier)
(assignable_selector (identifier) @identifier)
(assignment_expression
  left: (assignable_expression) @identifier)

; Parameters

(formal_parameter
    name: (identifier) @parameter)

; Named arguments

(named_argument (label (identifier) @label))

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

; TODO: "rethrow" @keyword

; Reserved words (cannot be used as identifiers)
[
    ; "assert"
    ; "break"
    "class"
    "enum"
    "extends"
    "in"
    "is"
    "new"
    "return"
    "super"
    "var"
    "with"
    ; "void"
] @keyword

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
    "static"
    "typedef"
] @keyword

["if" "else" "switch" "default"] @conditional

["try" "throw" "catch" "finally"] @exception

["do" "while" "continue" "for"] @repeat

((identifier) @variable.builtin
 (#match? @variable.builtin "^(abstract|as|covariant|deferred|dynamic|export|external|factory|Function|get|implements|import|interface|library|operator|mixin|part|set|static|typedef)$")
 (#is-not? local))

; Error
(ERROR) @error
