; Types

; Javascript

; Properties
;-----------

(property_identifier) @property

; Special identifiers
;--------------------

(identifier) @variable

((identifier) @constant
 (match? @constant "^[A-Z_][A-Z\\d_]+$"))

((shorthand_property_identifier) @constant
 (match? @constant "^[A-Z_][A-Z\\d_]+$"))

((identifier) @constructor
 (match? @constructor "^[A-Z]"))

((identifier) @variable.builtin
 (not-is? @variable.builtin import var parameter)
 (match? @variable.builtin "^(arguments|module|console|window|document)$"))

((identifier) @function.builtin
 (not-is? @function.builtin import var parameter)
 (eq? @function.builtin "require"))

((identifier) @parameter
 (is? @parameter parameter))


; Function and method definitions
;--------------------------------

(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @function.method)

(pair
  key: (property_identifier) @function.method
  value: (function))
(pair
  key: (property_identifier) @function.method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
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
    property: (property_identifier) @function.method))

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
(regex) @string.special
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

"--" @operator
"-" @operator
"-=" @operator
"&&" @operator
"+" @operator
"++" @operator
"+=" @operator
"<" @operator
"<<" @operator
"=" @operator
"==" @operator
"===" @operator
"=>" @operator
">" @operator
">>" @operator
"||" @operator
"??" @operator

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
