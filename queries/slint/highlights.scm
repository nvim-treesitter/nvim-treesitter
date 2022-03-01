
(user_type_identifier) @type

(var_identifier) @variable

(state_identifier) @field

(var_identifier
  (post_identifier) @variable)

(function_identifier) @function

(reference_identifier) @keyword
(visibility_modifier) @keyword

(comment) @comment

(value) @number
(string) @string

[
"struct"
"property"
"callback"
"import"
"from"
"root"
"parent"
"this"
"for"
"in"
"if"
"else"
"animate"
"states"
"when"
"in"
"out"
"transitions"
"global"
] @keyword

[
 "black"
 "transparent"
 "blue"
 "ease"
 "ease_in"
 "ease-in"
 "ease_in_out"
 "ease-in-out"
 "ease_out"
 "ease-out"
 "end"
 "green"
 "red"
 "red"
 "start"
 "yellow"
 "true"
 "false"
 ] @constant.builtin

"@" @keyword

; ; Punctuation
[
  ","
  "."
] @punctuation.delimiter

; ; Brackets
[
"("
")"
"["
"]"
"{"
"}"
] @punctuation.bracket

[
"angle"
"bool"
"brush"
; "color" // This causes problems
"duration"
"easing"
"float"
"image"
"int"
"length"
"percent"
"physical-length"
"physical_length"
"string"
] @type.builtin
