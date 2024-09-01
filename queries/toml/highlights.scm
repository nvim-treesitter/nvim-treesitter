(table
  [
    (bare_key) @markup.heading
    (dotted_key
      (bare_key) @markup.heading)
  ])

(table_array_element
  [
    (bare_key) @markup.heading
    (dotted_key
      (bare_key) @markup.heading)
  ])

(pair
  [
    (bare_key) @property
    (dotted_key
      (bare_key) @property)
  ])

[
  (string)
  (quoted_key)
] @string

(boolean) @boolean

(comment) @comment @spell

(escape_sequence) @string.escape

(integer) @number

(float) @number.float

[
  (local_date)
  (local_date_time)
  (local_time)
  (offset_date_time)
] @string.special

"=" @operator

[
  "."
  ","
] @punctuation.delimiter

[
  "["
  "]"
  "[["
  "]]"
  "{"
  "}"
] @punctuation.bracket
