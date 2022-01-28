; Pointers

(address_of_identifier
  "&" @symbol
  (_)*
)

(pointer_type
  (_)*
  "*" @symbol
)

(indirection_identifier
  "*" @symbol
  (_)*
)

"delete" @keyword

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

; Keywords

"return" @keyword.return
"yield" @keyword.return
"break" @keyword.return

; Booleans

(true) @boolean
(false) @boolean

; Operators

(binary_expression
  (_)
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
  (_)
)

(unary_expression
  (_)?
  [
    "-"
    "!"
    "--"
    "++"
  ] @operator
  (_)?
)

(null) @keyword

; Methods

(function_definition
  (modifier)* @keyword
  type: (_) @type
  name: [
  	(identifier) @method
    (camel_cased_identifier) @type
    (generic_identifier (_) @type) 
    (namespaced_identifier
    	left: (_)
        right: (_) @method .
    )
  ]
)

(function_call
  identifier: [
  	(identifier) @method
    (camel_cased_identifier) @type
    (generic_identifier (_) @type) 
    (namespaced_identifier
    	left: (_)
        right: (_) @method .
    )
  ]
  (parameter_list)
)

; Modifiers

(modifier) @keyword
"var" @keyword

; Types

(primitive_type) @type

(nullable_type
    (_) @type
    "?" @symbol
)

"typeof" @keyword

"is" @keyword

(is_type_expression
  (_)
  "is" @keyword
  (_) @type
)

; Comments

(comment) @comment

; Namespace

(namespace
  "namespace" @include
  (camel_cased_identifier) @namespace
)

"global" @namespace

"using" @include

; declaration
(declaration
  (_)*
  [
    (camel_cased_identifier) @type
    (_)
  ]
  (_)*
)

; Classes

(class_declaration
    (modifier) @keyword
    "class" @keyword
    [
      (camel_cased_identifier) @type
      (generic_identifier (_) @type )
    ]
)

(class_constructor_definition
  (modifier)* @keyword
  [
    (identifier)
    (namespaced_identifier)
    (camel_cased_identifier)
  ] @constructor
  (_)*
)

(class_destructor
  "~" @symbol
  (_) @constructor
  (_)*
)

; Interfaces

(interface_declaration
    (modifier) @keyword
    "interface" @keyword
    [
      (camel_cased_identifier) @type
      (generic_identifier (_) @type )
    ]
)

; Class properties

(property_parameter) @keyword
(this) @keyword

; Strings and escape sequences

(string_literal) @string
(escape_sequence) @string.escape

(string_template
  "@" @symbol
) @string

(string_template_variable) @variable

(string_template_expression) @variable

; Assignment and declaration

(new_instance
  [
    (
      "new" @keyword
      (_)*
    )
    (
      (_)*
      ".new" @keyword
    )
  ]
)

; Parameters

(instanciation_parameter
    (modifier) @keyword
)

; GObject construct

"construct" @constructor

; Conditionals

[
"if"
"else"
"switch"
"case"
"default"
] @conditional

; Try statement

(try_statement
  "try" @keyword
  (block)
  "catch" @keyword
  exception: (parameter_list (declaration_parameter
    (_) @exception
    (_) @variable
  ))
  (block)
)

; Enum

"enum" @keyword
(enum_declaration
    (camel_cased_identifier) @type
    (_)*
)

; Loop

[
"for"
"foreach"
"in"
"while"
"do"
] @repeat

(foreach_statement
  (_)*
  loop_item: (identifier) @variable
  (_)*
)

; Generics

(generic_identifier
  (camel_cased_identifier) @type
)

; Closure

(closure
  "("
  (identifier)* @variable
  ")"
  (_)*
)

; Casting

(static_cast
  (_) @type
)

(dynamic_cast
  (_)
  "as" @keyword
  (_) @type
)

; Throw error

"throws" @keyword
"throw" @exception

; Ownership

(ownership_transfer
  "owned" @keyword
  (_)
)

; Regex

(regex_literal) @string.regex

; Contract programming

"requires" @keyword
"ensures" @keyword

; Code attribute

(code_attribute
  "[" @attribute
  name: (camel_cased_identifier) @attribute
  (
    "(" @attribute
    (_)+
    ")" @attribute
  )?
  "]" @attribute
)

; Constant
(uppercased_identifier) @constant

; Other

(namespaced_identifier
  left: [
    (camel_cased_identifier) @namespace
    (identifier) @variable
  ]
  (
    "."
    right: [
      (identifier) @parameter
      (camel_cased_identifier) @type
      (uppercased_identifier) @constant
    ]
  )+
)

; Variable

(identifier) @variable
(camel_cased_identifier) @variable
