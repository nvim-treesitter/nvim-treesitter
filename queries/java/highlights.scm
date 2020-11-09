; CREDITS @maxbrunsfeld (maxbrunsfeld@gmail.com)

; Variables

(identifier) @variable

; Methods

(method_declaration
  name: (identifier) @method)
(method_invocation
  name: (identifier) @method)

(super) @function.builtin

; Parameters
(formal_parameter
  name: (identifier) @parameter)
(catch_formal_parameter
  name: (identifier) @parameter)

;; Lambda parameter
(inferred_parameters (identifier) @parameter) ; (x,y) -> ...
(lambda_expression
    parameters: (identifier) @parameter) ; x -> ...


; Annotations


(annotation
  name: (identifier) @attribute)
(marker_annotation
  name: (identifier) @attribute)


; Operators

[
"@"
"+"
"?"
":"
"++"
"-"
"--"
"&"
"&&"
"|"
"||"
"!="
"=="
"*"
"/"
"%"
"<"
"<="
">"
">="
"="
"-="
"+="
"*="
"/="
"%="
"->"
"^"
"^="
"&="
"|="
"~"
">>"
">>>"
"<<"
"::"
] @operator

; Types

(interface_declaration
  name: (identifier) @type)
(class_declaration
  name: (identifier) @type)
(enum_declaration
  name: (identifier) @type)
(constructor_declaration
  name: (identifier) @type)
(type_identifier) @type



((field_access
  object: (identifier) @type)
  (#match? @type "^[A-Z]"))
((scoped_identifier
  scope: (identifier) @type)
  (#match? @type "^[A-Z]"))

[
(boolean_type)
(integral_type)
(floating_point_type)
(void_type)
] @type.builtin

; Variables

((identifier) @constant
  (#vim-match? @constant "^_*[A-Z][A-Z\d_]+"))

(this) @variable.builtin

; Literals

[
(hex_integer_literal)
(decimal_integer_literal)
(octal_integer_literal)
(binary_integer_literal)
] @number

[
(decimal_floating_point_literal)
(hex_floating_point_literal)
] @float

(character_literal) @character
(string_literal) @string
(null_literal) @constant.builtin

(comment) @comment

[
(true)
(false)
] @boolean

; Keywords

[
"abstract"
"assert"
"break"
"class"
"continue"
"default"
"enum"
"exports"
"extends"
"final"
"implements"
"instanceof"
"interface"
"module"
"native"
"open"
"opens"
"package"
"private"
"protected"
"provides"
"public"
"requires"
"return"
"static"
"strictfp"
"synchronized"
"to"
"transient"
"transitive"
"uses"
"volatile"
"with"
] @keyword

[
 "new"
] @keyword.operator

; Conditionals

[
"if"
"else"
"switch"
"case"
] @conditional

;

[
"for"
"while"
"do"
] @repeat

; Includes

"import" @include
"package" @include

; Punctuation

[
";"
"."
","
] @punctuation.delimiter

[
"["
"]"
"{"
"}"
"("
")"
] @punctuation.bracket

; Exceptions

[
"throw"
"throws"
"finally"
"try"
"catch"
] @exception

; Labels
(labeled_statement
  (identifier) @label)
