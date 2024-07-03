(comment) @comment @spell

; consistency with toml and ini
(section
  (section_name) @type)

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
  (path_separator)
] @punctuation.delimiter

[
  "-"
  "="
  ".."
  (negation)
  (wildcard_characters)
  (wildcard_any_characters)
  (wildcard_single_character)
] @operator

(escaped_character) @string.escape

(pair
  key: (identifier) @property)

(boolean) @boolean

(integer) @number

[
  (unset)
  (spelling_language)
  (indent_style)
  (end_of_line)
  (charset)
] @constant.builtin
