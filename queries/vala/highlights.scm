; Identifiers

((identifier) @constant (#match? @constant "^[A-Z][A-Z\\d_]+$"))


;;; here make the highlight break so I commit here 
;;; TODO
;;;(namespaced_identifier
;;;  left: [
;;;    ; Lowercased names in lhs typically are variables, while camel cased are namespaces
;;;    ; ((identifier) @namespace (#match? @namespace "^[A-Z]+[a-z]+$"))
;;;    ((identifier) @variable (#match? @variable "^[a-z]"))
;;;    (_)
;;;  ]
;;;  right: [
;;;    ; Lowercased are variables, camel cased are types
;;;    ; ((identifier) @parameter (#match? @parameter "^[a-z]"))
;;;    ((identifier) @type (#match? @type "^[A-Z]+[a-z]+$"))
;;;    (_)
;;;  ]
;;;)

(comment) @comment
((identifier) @constructor (#match? @constructor "^[A-Z]*[a-z]+"))

; Pointers

(address_of_identifier "&" @symbol)
(pointer_type "*" @symbol)
(indirection_identifier "*" @symbol)

; Misc

(number) @number

[
  "{"
  "}"
  "("
  ")"
  "["
  "]"
] @punctuation.bracket

[
  ";"
  ":"
  "."
  ","
  "->"
] @punctuation.delimiter

; Reserved keywords

[
  "return" 
  "yield"
  "break"
] @keyword.return
(primitive_type)

(null) @constant.builtin

[
  "typeof"
  "is"
] @keyword.operator

(this) @variable.builtin
;;; move enum to namespace
[
  "enum"
] @namespace

;;; move new and delet to operator
[
  "new"
  "delete"
] @keyword.operator
;;; keyword
[
  (modifier)
  "namespace"
  "var"
  "class"
	"override"
  "interface"
  (property_parameter)
  "public"
  "in"
  "as"
  "requires"
  "ensures"
  "owned"
  "#if"
  "#elif"
  (preproc_else)
  (preproc_endif)
] @keyword

"throw" @exception
;;; conditional
[
  "if"
  "else"
  "switch"
  "case"
  "default"
  "throws"
	"try"
  "catch"
] @conditional

[
  "for"
  "foreach"
  "while"
  "do"
] @repeat

[
  (true)
  (false)
] @boolean

; Operators

(binary_expression
  [
    "*"
    "/"
    "+"
    "-"
    "%"
    "<"
    "<="
    ">"
    ">="
    "=="
    "!="
    "+="
    "-="
    "*="
    "/="
    "%="
    "&&"
    "||"
    "&"
    "|"
    "^"
    "~"
    "|="
    "&="
    "^="
    "??"
    "="
  ] @operator    
)

(unary_expression
  [
    "-"
    "!"
    "--"
    "++"
  ] @operator
)

; Declaration

(declaration
  type_name: (_) @type
)

(declaration
  (identifier) @variable
)

; Methods

(function_definition
  type: (_) @type
  name: [
  	(identifier) @method
    (generic_identifier (_) @type) 
  ]
)

(function_call
  identifier: [
  	(identifier) @method
    (generic_identifier (_) @type) 
  ]
)

(member_function
  identifier: [
  	(identifier) @method
    (generic_identifier (_) @type)
  ]
)

; Types

(primitive_type) @type

(nullable_type
    (_) @type
    "?" @symbol
)

; Comments

(comment) @comment

; Namespace

"global::" @namespace

(using 
  "using" @include
  (_) @namespace
)

; Classes

(class_declaration
	(identifier) @type)

(class_constructor_definition
  name: [
    (_)
    (namespaced_identifier (_) @constructor .)
  ] @constructor
)

(class_destructor
  "~" @symbol
  (_) @constructor
)

; Interfaces

(interface_declaration) @type

; Strings and escape sequences

(string_literal) @string
(verbatim) @string
(escape_sequence) @string.escape

(string_template
  "@" @symbol
) @string

(string_template_variable) @variable

(string_template_expression) @variable

; New instance from Object

; GObject construct

(gobject_construct 
  "construct" @keyword
)

; Try statement

(try_statement
  exception: (parameter_list (declaration_parameter
    (_) @exception
    (_) @variable
  ))
)

; Enum

(enum_declaration
    name: (identifier) @type
)

; Loop

(foreach_statement
  loop_item: (identifier) @variable
)

; Casting

(static_cast
  type: (_) @type
)

(dynamic_cast
  type: (_) @type
)

; Regex

(regex_literal) @string.regex

; Code attribute

(code_attribute
  name: (identifier) @attribute
  param: (_) @attribute
) @attribute

;;; namespace 
(namespaced_identifier
	left: (identifier) @namespace
	right: (identifier) @type
	)

;;; define variable
(generic_identifier
	(identifier) @type )
(declaration 
	type_name: (identifier) @primitive_type
	(identifier) @variable)

;;; inline etc
(declaration_parameter 
	(identifier) @type
	(identifier) @variable
	)
(binary_expression (identifier) @variable)
(instanciation_parameter (identifier) @variable)
(assignment (identifier) @variable)

;;; array
(array_identifier 
	(identifier) @variable
	(identifier) @constant)
(array_identifier (identifier) @type)
