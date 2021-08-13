; Types

; Javascript

; Variables
;-----------
(identifier) @variable

; Properties
;-----------

(property_identifier) @property
(shorthand_property_identifier) @property

(variable_declarator
  name: (object_pattern
    (shorthand_property_identifier_pattern))) @variable

; Special identifiers
;--------------------

((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

((identifier) @constant
 (#vim-match? @constant "^[A-Z_][A-Z\\d_]+$"))

((shorthand_property_identifier) @constant
 (#vim-match? @constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @variable.builtin
 (#vim-match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (#eq? @function.builtin "require"))

; Function and method definitions
;--------------------------------

(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(generator_function
  name: (identifier) @function)
(generator_function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @method)

(pair
  key: (property_identifier) @method
  value: (function))
(pair
  key: (property_identifier) @method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @method)
  right: (function))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))
(variable_declarator
  name: (identifier) @function
  value: (function))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))
(assignment_expression
  left: (identifier) @function
  right: (function))

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (property_identifier) @method))

; Variables
;----------
(namespace_import
  (identifier) @namespace)

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

(true) @boolean
(false) @boolean
(null) @constant.builtin
[
(comment)
(hash_bang_line)
] @comment
(string) @string
(regex) @punctuation.delimiter
(regex_pattern) @string.regex
(template_string) @string
(number) @number

; Punctuation
;------------

"..." @punctuation.special

";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
"?." @punctuation.delimiter

(pair ":" @punctuation.delimiter)

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
] @operator

(binary_expression "/" @operator)
(ternary_expression ["?" ":"] @conditional)
(unary_expression ["!" "~" "-" "+" "delete" "void" "typeof"]  @operator)

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

((template_substitution ["${" "}"] @punctuation.special) @none
 ; Substitutions should have a higher priority than injections.
 (#set! "priority" 105))

; Keywords
;----------

[
"if"
"else"
"switch"
"case"
"default"
] @conditional

[
"import"
"from"
"as"
] @include

[
"for"
"of"
"do"
"while"
"continue"
] @repeat

[
"async"
"await"
"break"
"class"
"const"
"debugger"
"export"
"extends"
"get"
"in"
"instanceof"
"let"
"set"
"static"
"switch"
"target"
"typeof"
"var"
"void"
"with"
] @keyword

[
"return"
"yield"
] @keyword.return

[
 "function"
] @keyword.function

[
 "new"
 "delete"
] @keyword.operator

[
 "throw"
 "try"
 "catch"
 "finally"
] @exception
