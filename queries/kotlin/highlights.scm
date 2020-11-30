;;; Kotlin 
;; Issues

; mapOf with type definition AND multiple entries are not highligted correctly. Issue in parser. Eg.
; a = mapOf<String, String>(AA.value to AA.value, AA.value to AA.value)


(function_modifier) @type

;; String

(line_string_literal) @string
(multi_line_string_literal) @string
(line_string_literal (interpolated_identifier)) @string
(line_string_literal (interpolated_expression (line_string_literal))) @string

;; Constants
; Assume all-caps names are constants
((simple_identifier) @constant
 (#vim-match? @constant "^[A-Z][A-Z_]+"))


;; Variables
(class_parameter (simple_identifier) @variable.builtin)

; Class level
(property_declaration (variable_declaration (simple_identifier) @variable.builtin))

(statements (call_expression (navigation_expression (simple_identifier) @variable.builtin)))

(directly_assignable_expression (navigation_expression (simple_identifier) @variable.builtin))

(directly_assignable_expression (simple_identifier) @variable.builtin)


; TODO not supported yet
; (navigation_expression (simple_identifier) @type
;   (#is-not? local))
; (directly_assignable_expression (simple_identifier) @type
;   (#is-not? local))


;; Property access syntax
; TODO
; a = get().value etc
(assignment (navigation_expression (navigation_suffix) @type ))
; val a = A.get().value etc
(property_declaration  (navigation_expression (navigation_suffix) @type ))
; value in `mapOf(A.value to B.value)` etc.
(infix_expression  (navigation_expression (navigation_suffix) @type ))
; java in `Car::class.java`
(value_argument (navigation_expression (navigation_suffix) @type ))


;; Interpolated

(interpolated_identifier) @type
(interpolated_expression) @type


;; Builtin functions
((simple_identifier) @function.builtin
 (#vim-match? @function.builtin "(^let$|^listOf$|^mapOf$|^map$)"))


((simple_identifier) @function.builtin
 (#vim-match? @function.builtin "^to$"))


(modifiers (annotation (user_type (type_identifier)))) @attribute

(annotation) @attribute

(integer_literal) @number

(boolean_literal) @boolean


;; it
(indexing_expression (simple_identifier) @type
  (#vim-match? @type "^it$"))


;; Keywords

[
 "enum"
 "as"
 "class"
 "object"
 "data"
 "val"
 "init"
 "private"
 "var"
 "break"
 "by"
 "fun"
 "companion"
 "return"
 "constructor"
] @keyword
; const does not work


;; Conditionals
[
"if"
"is"
"else"
"when"
] @conditional


;; Includes

"import" @include
"package" @include


;; Punctuation

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

[
"$"
"${"
"}"
] @punctuation.special

;; Comments
(comment) @comment

; Methods

(function_declaration (simple_identifier) @function)


[
"="
"-"
"->"
"+"
"++"
"--"
"*"
] @operator

(ERROR) @error
