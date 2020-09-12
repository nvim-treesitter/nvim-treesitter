; Types

; Javascript

; Variables
;-----------
(identifier) @variable

; Properties
;-----------

(property_identifier) @property

; Special identifiers
;--------------------

(identifier) @variable

((identifier) @constant
 (#vim-match? @constant "^[A-Z_][A-Z\\d_]+$"))

((shorthand_property_identifier) @constant
 (#vim-match? @constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

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

(formal_parameters (identifier) @parameter)

(formal_parameters
  (rest_parameter
    (identifier) @parameter))

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

(true) @boolean
(false) @boolean
(null) @constant.builtin
(comment) @comment
(string) @string
(regex) @punctuation.delimiter
(regex_pattern) @string.regex
(template_string) @string
(number) @number

; Punctuation
;------------

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter

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
] @operator

(ternary_expression ["?" ":"] @operator)

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

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
"catch"
"class"
"const"
"debugger"
"delete"
"export"
"extends"
"finally"
"function"
"get"
"in"
"instanceof"
"let"
"new"
"return"
"set"
"static"
"switch"
"target"
"throw"
"try"
"typeof"
"var"
"void"
"with"
"yield"
] @keyword
