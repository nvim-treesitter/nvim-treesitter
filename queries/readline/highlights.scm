(comment) @comment @spell

"set" @keyword

[
  "$if"
  "$else"
  "$endif"
] @keyword.conditional

"$include" @keyword.import

[
  "="
  "=="
  "!="
  ">="
  "<="
  ">"
  "<"
] @operator

[
  ":"
  "-"
] @punctuation.delimiter

[
  (application_name)
  (keyname)
  (keyseq)
  (macro)
  (string_value)
  (term_name)
] @string

(file_path) @string.special.path

(escape_sequence) @string.escape

(symbolic_character_name) @character.special

(key_literal) @character

(function_name) @function

[
  (bell_variable)
  (bool_variable)
  (edit_mode_variable)
  (keymap_variable)
  (number_variable)
  (string_variable)
] @variable.builtin

[
  (bell_value)
  (edit_mode_value)
  (keymap_value)
  "version"
  "term"
  "mode"
] @constant.builtin

(number_value) @number

(version_number) @number.float

(bool_value) @boolean
