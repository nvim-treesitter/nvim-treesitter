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

; Operators

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
 ">="
 "<="
 "||"
 (is_operator)
 (prefix_operator)
 (equality_operator)
 (additive_operator)
] @operator

; Delimiters

"." @punctuation.delimiter
"," @punctuation.delimiter
";" @punctuation.delimiter

"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket


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
; using method_signature does not work
; so specifically use getter and setter signatures
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

((identifier) @type
 (#match? @type "^[A-Z]"))

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
 "as"
 "mixin"
 "external"
 "new"
 "return"
 "static"
 "required"
 "var"
 "const"
 "async"
 "await"
 ] @keyword
;TODO:
; "rethrow" @keyword

["if" "else" "switch" "case"] @conditional

["try" "throw" "catch" "finally"] @exception

["do" "while" "continue" "for"] @repeat
