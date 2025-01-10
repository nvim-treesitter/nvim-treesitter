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

(pair
  key: ((identifier) @property.builtin
    (#any-of? @property.builtin
      ; :=vim.tbl_keys(require('editorconfig').properties)
      "insert_final_newline" "trim_trailing_whitespace" "root" "end_of_line" "charset" "tab_width"
      "indent_size" "indent_style" "max_line_length" "spelling_language")))

(boolean) @boolean

(integer) @number

(unset) @constant.builtin

[
  (spelling_language)
  (indent_style)
  (end_of_line)
  (charset)
] @string.special
