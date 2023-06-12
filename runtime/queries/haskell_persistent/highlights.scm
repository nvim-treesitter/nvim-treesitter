; ----------------------------------------------------------------------------
; Literals and comments
(integer) @number

(float) @number.float

(char) @character

(string) @string

(attribute_name) @attribute

(attribute_exclamation_mark) @attribute

(con_unit) @string.special.symbol ; unit, as in ()

(comment) @comment @spell

; ----------------------------------------------------------------------------
; Keywords, operators, includes
[
  "Id"
  "Primary"
  "Foreign"
  "deriving"
] @keyword

"=" @operator

; ----------------------------------------------------------------------------
; Functions and variables
(variable) @variable

; ----------------------------------------------------------------------------
; Types
(type) @type

(constructor) @constructor
