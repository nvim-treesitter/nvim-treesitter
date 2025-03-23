(comment) @comment @spell

[
  (env)
  (argv)
  (block_variable)
  (placeholder)
] @constant

(value) @variable

(directive
  (keyword) @attribute)

(global_options
  (option
    (keyword) @attribute))

(keyword) @keyword

(boolean) @boolean

(placeholder
  [
    "{"
    "}"
  ] @punctuation.special)

(auto) @variable.builtin

[
  (string_literal)
  (quoted_string_literal)
  (address)
] @string

[
  (matcher)
  (route)
  (snippet_name)
] @string.special

[
  (numeric_literal)
  (time)
  (size)
  (ip_literal)
] @number

[
  "{"
  "}"
] @punctuation.bracket

"," @punctuation.delimiter
