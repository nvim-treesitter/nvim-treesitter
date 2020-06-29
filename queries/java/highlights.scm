; CREDITS @maxbrunsfeld (maxbrunsfeld@gmail.com)

; Methods


(method_declaration
  name: (identifier) @method)
(method_invocation
  name: (identifier) @method)

(super) @function.builtin

; Parameters
(formal_parameter
  name: (identifier) @parameter)

(inferred_parameters (identifier) @parameter)


; Annotations


(annotation
  name: (identifier) @attribute)
(marker_annotation
  name: (identifier) @attribute)


; Operators

[
"@"
"+"
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
  (#match? @constant "^_*[A-Z][A-Z\d_]+"))



; Literals

[
(hex_integer_literal)
(decimal_integer_literal)
(octal_integer_literal)
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
"catch"
"class"
"continue"
"default"
"enum"
"exports"
"extends"
"final"
"finally"
"implements"
"instanceof"
"interface"
"module"
"native"
"new"
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
"throw"
"throws"
"to"
"transient"
"transitive"
"try"
"uses"
"volatile"
"with"
] @keyword

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
