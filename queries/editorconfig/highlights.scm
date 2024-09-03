(comment) @comment @spell

(section
  (section_name) @string.special.path)

(character_choice
  (character) @constant)

(character_range
  start: (character) @constant
  end: (character) @constant)

[
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

[
  ","
  ".."
  (path_separator)
] @punctuation.delimiter

[
  "-"
  "="
  (negation)
] @operator

[
  (wildcard_characters)
  (wildcard_any_characters)
  (wildcard_single_character)
] @character.special

(escaped_character) @string.escape

(pair
  key: (identifier) @property
  value: (_) @string)

(boolean) @boolean

(integer) @number

(unset) @constant.builtin

[
  (spelling_language)
  (indent_style)
  (end_of_line)
  (charset)
] @string.special
