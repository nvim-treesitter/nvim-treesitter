(comment) @comment @spell

(variable_name) @constant

(enum_constant) @constant

(ascii_name) @constant.builtin

"=" @operator

[
  (function_name)
  (command_name)
  (handler_name)
] @function

((command_name) @function.builtin
  (#any-of? @function.builtin "out" "in" "wait" "event" "exec" "disconnect" "connect"))

((handler_name) @function.builtin
  (#any-of? @function.builtin "mismatch" "writetimeout" "replytimeout" "readtimeout" "init"))

[
  "{"
  "}"
  "["
  "]"
  "("
  ")"
  "<"
  ">"
] @punctuation.bracket

[
  "$"
  "\\$"
  "@"
  "/"
  "#/"
] @punctuation.special

(variable_expansion
  [
    "\\${"
    "}"
  ] @punctuation.special)

(format_converter
  [
    "%"
    "{"
    "}"
    "["
    "]"
    "("
    ")"
    "<"
    ">"
    "#/"
    "/"
  ] @punctuation.special)

[
  "|"
  ";"
  ","
  "."
] @punctuation.delimiter

(quoted_literal) @string

(escape_sequence) @string.escape

(format_converter) @function.builtin

(checksum_flag) @operator

(checksum) @function

(regex_pattern) @string.regexp

(time_conversion_spec) @constant.builtin

(keyword) @keyword

(record_name) @constant

(field_name) @variable.member

(number) @number
