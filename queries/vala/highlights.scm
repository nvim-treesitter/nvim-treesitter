; Variable

(uppercased_identifier) @constant

(namespaced_identifier
  left: [
    (camel_cased_identifier) @namespace
    (identifier) @variable
  ]
  right: [
    (identifier) @parameter
    (camel_cased_identifier) @type
    (uppercased_identifier) @constant
  ]
)
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
] @punctuation.bracket

[
  ";"
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


(null) @constant.builtin

[
  "typeof"
  "is"
] @keyword.operator

[
  (modifier)
  "var"
  "class"
  "interface"
  (property_parameter)
  (this)
  "enum"
  "new"
  "in"
  "as"
  "try"
  "catch"
  "requires"
  "ensures"
  "owned"
  "throws"
  "delete"
] @keyword

"throw" @exception

[
  "if"
  "else"
  "switch"
  "case"
  "default"
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

; Methods

(function_definition
  type: (_) @type
  name: [
  	(identifier) @method
    (camel_cased_identifier) @type
    (generic_identifier (_) @type) 
    (namespaced_identifier
        (_) @method .
    )
  ]
)

(function_call
  identifier: [
  	(identifier) @method
    (camel_cased_identifier) @type
    (generic_identifier (_) @type) 
    (namespaced_identifier
        (_) @method .
    )
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

(namespace
  "namespace" @include
  (_) @namespace
)

"global::" @namespace

"using" @include

; Classes

(class_declaration
    [
      (camel_cased_identifier) @type
      (generic_identifier (_) @type )
    ]
)

(class_constructor_definition
  [
    (_)
    (namespaced_identifier (_) @constructor .)
  ] @constructor
)

(class_destructor
  "~" @symbol
  (_) @constructor
)

; Interfaces

(interface_declaration
    [
      (camel_cased_identifier) @type
      (generic_identifier (_) @type )
    ]
)

; Strings and escape sequences

(string_literal) @string
(escape_sequence) @string.escape

(string_template
  "@" @symbol
) @string

(string_template_variable) @variable

(string_template_expression) @variable

; New instance from Object

(new_instance
  ".new" @keyword
)

; GObject construct

"construct" @constructor

; Try statement

(try_statement
  exception: (parameter_list (declaration_parameter
    (_) @exception
    (_) @variable
  ))
)

; Enum

(enum_declaration
    (camel_cased_identifier) @type
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
  name: (camel_cased_identifier) @attribute
  param: (_) @attribute
) @attribute
