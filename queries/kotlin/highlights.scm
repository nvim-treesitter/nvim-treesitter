;;; Kotlin
;; Issues

; mapOf with type definition AND multiple entries are not highligted correctly. Issue in parser. Eg.
; a = mapOf<String, String>(AA.value to AA.value, AA.value to AA.value)

;; parser does not recognice `in` and `downto` in `for (i in 5..1) print(i)`

;; Strings

(line_string_literal) @string
(multi_line_string_literal) @string
; Interpolated
(interpolated_identifier) @none
(interpolated_expression) @none


;; Constants
; Assume all-caps names are constants
((simple_identifier) @constant
 (#vim-match? @constant "^[A-Z][A-Z_]+"))


;; Variables/fields
; field in data classes etc.
(class_parameter (simple_identifier) @field)
; field in normal classes
(property_declaration (variable_declaration (simple_identifier) @field))
; accessed field in blocks. `logger` in `logger.info("")`
(statements (call_expression (navigation_expression (simple_identifier) @field)))

(statements (navigation_expression (simple_identifier) @field))

(call_expression (navigation_expression (simple_identifier) @field))

; TODO check if this is needed
(directly_assignable_expression (navigation_expression (simple_identifier) @string))
; `variable` in `variable = car.doors`
(directly_assignable_expression (simple_identifier) @field)

(lambda_parameters) @field


; TODO not supported yet
; (navigation_expression (simple_identifier) @type
;   (#is-not? local))
; (directly_assignable_expression (simple_identifier) @type
;   (#is-not? local))


;; Property access syntax
; `value` in `a = get().value`
(assignment (navigation_expression (navigation_suffix) @property ))
; `value` in `val a = A.get().value`
(property_declaration  (navigation_expression (navigation_suffix) @property ))
; `value` in `mapOf(A.value to B.value)`
(infix_expression  (navigation_expression (navigation_suffix) @property ))
; java in `Car::class.java`
(value_argument (navigation_expression (navigation_suffix) @method ))


;; Builtin functions
;; TODO add more functions
((simple_identifier) @function.macro
 (#vim-match? @function.macro "(^let$|^listOf$|^mapOf$|^map$|^downto$)"))

;; TODO add more functions
((simple_identifier) @function.builtin
 (#vim-match? @function.builtin "(^print$|^println$)"))


((simple_identifier) @keyword.operator
 (#vim-match? @keyword.operator "^to$"))


;; Numbers
(integer_literal) @number

;; Booleans
(boolean_literal) @boolean

;; Annotations
(annotation (single_annotation) @annotation)

;; Types
; TODO more type definitions
(variable_declaration (user_type (type_identifier) @type))
(callable_reference (type_identifier) @type)


;; it
(indexing_expression (simple_identifier) @variable.builtin
  (#vim-match? @variable.builtin "^it$"))


;; Keyword operators

[
"in"
] @keyword.operator


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
 "throw"
] @keyword
; const does not work


;; Conditionals
[
"if"
"is"
"else"
"when"
] @conditional


;; Loops
[
"for"
"while"
] @repeat


;; Includes

"import" @include
"package" @include


;; Punctuation

[
"::"
";"
"."
","
] @punctuation.delimiter

[
"$"
"${"
"}"
] @none

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

; TODO parameter

(ERROR) @error
