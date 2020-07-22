(dotted_identifier_list) @string

; Methods

(function_type
  name: (identifier) @method)
(super) @function

; Annotations
; TODO: highlight??
(annotation
  name: (identifier) @attribute)
(marker_annotation
  name: (identifier) @attribute)

; TODO: operators
[
 "@" 
 (additive_operator)
] @operator
; TODO: delimiers/punctuation

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

((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\d_]+"))

(this) @constant.builtin

;; Parameters

(formal_parameter
    name: (identifier) @parameter)

;; Literals

(hex_integer_literal) @number
(decimal_integer_literal) @number
(decimal_floating_point_literal) @float

(string_literal) @string
(true) @boolean
(false) @boolean
(null_literal) @constant.builtin

(comment) @comment

; Keywords

["import" "library" "export"] @include

[
 "abstract"
 "assert"
 "break"
 "on"
 "class"
 "default"
 "enum"
 "extends"
 "final"
 "implements"
 "is"
 "as"
 "mixin"
 "external"
 "new"
 "return"
 "static"
 ] @keyword
;TODO: var, async, await
; "rethrow" @keyword

["if" "else" "switch" "case"] @conditional

["try" "throw" "catch" "finally"] @exception

["do" "while" "continue" "for"] @repeat
