; extends

; Comments
(comment) @comment

; Keys
[ (property)
 (palette_property)
] @property

; Values
(boolean_literal) @boolean

[
 (number_literal)
 (adjustment)
] @number

[
    (string_literal)
    (raw_value)
    (palette_value)
] @string

[
    (hex_color)
    (palette_index)
] @markup.bold

[
 (palette_index)
 (palette_value (hex_color))
] @markup.italic

